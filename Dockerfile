# Install PHP and apache docker image
FROM php:8.2.13-apache-bullseye

# Install required packages and apache modules.
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git openssh-client \
    && a2enmod headers \
    && a2enmod rewrite \
    && docker-php-ext-install pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

# Change default port to 8080 to allow non-root user to bind port
# Binding port 80 on CentOS seems to be forbidden for non-root users
RUN sed -ri -e 's!Listen 80!Listen 8080!g' /etc/apache2/ports.conf

# Initialize default branch name variable that can assign when building the images.
ARG OPALDBV_BRANCH="development"
ARG OPAL_REPORT_BRANCH="development"

WORKDIR /var/www/html

# Create the ssh folder and add GitLab to known hosts
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# Support busting the cache to force cloning the repos (without this the git clone commands will be cached)
ARG CACHEBUST=1

# Clone the 3 dbv's repos needed using the branch name variable (default or passed as arguments)
RUN --mount=type=ssh,id=ssh_key git clone --branch $OPALDBV_BRANCH git@gitlab.com:opalmedapps/dbv_opaldb.git ./dbv/dbv_opaldb \
        && git clone --branch $OPAL_REPORT_BRANCH git@gitlab.com:opalmedapps/dbv_opalrpt.git ./dbv/dbv_opalreportdb

# Copy configuration file
COPY ./config/opaldb-config.php ./dbv/dbv_opaldb/config.php
COPY ./config/opalreportdb-config.php ./dbv/dbv_opalreportdb/config.php

# Add the SecureMySQL adapter
COPY ./config/SecureMySQL.php ./dbv/dbv_opaldb/lib/adapters/
COPY ./config/SecureMySQL.php ./dbv/dbv_opalreportdb/lib/adapters/

# Copy the index landing page
COPY ./index.php ./index.php

RUN chown -R www-data:www-data .
USER www-data

EXPOSE 8080
