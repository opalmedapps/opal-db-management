# Install PHP and apache docker image
FROM php:8.0.26-apache-bullseye

# Install required packages and apache modules.
RUN apt-get update \ 
    && apt-get upgrade -y \
    && apt-get install -y git openssh-client \
    && a2enmod headers \
    && a2enmod rewrite \
    && docker-php-ext-install pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

# Initialize default branch name variable that can assign when building the images.
ARG OPALDBV_BRANCH="development"
ARG REGISTERDBV_BRANCH="development"
ARG QUESTIONNAIREDBV_BRANCH="development"
ARG OPAL_REPORT_BRANCH="development"

# Create the ssh folder and add GitLab to known hosts
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# Clone the 3 dbv's repos needed using the branch name variable (default or passed as arguments)
ARG CACHEBUST=1
RUN --mount=type=ssh,id=ssh_key git clone --branch $OPALDBV_BRANCH git@gitlab.com:opalmedapps/dbv_opaldb.git ./dbv/dbv_opaldb
RUN --mount=type=ssh,id=ssh_key git clone --branch $REGISTERDBV_BRANCH git@gitlab.com:opalmedapps/dbv_registerdb.git ./dbv/dbv_registerdb
RUN --mount=type=ssh,id=ssh_key git clone --branch $QUESTIONNAIREDBV_BRANCH git@gitlab.com:opalmedapps/dbv_questionnairedb.git ./dbv/dbv_questionnairedb
RUN --mount=type=ssh,id=ssh_key git clone --branch $OPAL_REPORT_BRANCH git@gitlab.com:opalmedapps/dbv_opalrpt.git ./dbv/dbv_opalreportdb

# Copy configuration file 
COPY ./config/opaldb-config.php ./dbv/dbv_opaldb/config.php
COPY ./config/registrationdb-config.php ./dbv/dbv_registerdb/config.php
COPY ./config/questionairesdb-config.php ./dbv/dbv_questionnairedb/config.php
COPY ./config/opalreportdb-config.php ./dbv/dbv_opalreportdb/config.php

# Copy the index landing page
COPY ./index.php ./index.php

RUN chown -R www-data:www-data .
USER www-data
