# Install PHP and the required modules
FROM php:8.0-apache
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git openssh-client
RUN a2enmod headers
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install pdo pdo_mysql

# Initialize default branch name variable that can assign when building the images.
ARG OPALDBV_BRANCH="development"
ARG REGISTERDBV_BRANCH="development"
ARG QUESTIONNAIREDBV_BRANCH="development"

# Create the ssh folder and scan the localhost key
RUN mkdir -p -m 0600 ~/.ssh
RUN ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# Clone the 3 dbv's repos needed using the branch name variable (default or passed as arguments)
RUN --mount=type=ssh,id=ssh_key git clone --branch $OPALDBV_BRANCH git@gitlab.com:opalmedapps/dbv_opaldb.git ./dbv/dbv_opaldb
RUN --mount=type=ssh,id=ssh_key git clone --branch $REGISTERDBV_BRANCH git@gitlab.com:opalmedapps/dbv_registerdb.git ./dbv/dbv_registerdb
RUN --mount=type=ssh,id=ssh_key git clone  --branch $QUESTIONNAIREDBV_BRANCH git@gitlab.com:opalmedapps/dbv_questionnairedb.git ./dbv/dbv_questionnairedb

# Copy configuratoin file 
COPY ./config/opaldb-config.php ./dbv/dbv_opaldb/config.php
COPY ./config/registrationdb-config.php ./dbv/dbv_registerdb/config.php
COPY ./config/questionairesdb-config.php ./dbv/dbv_questionnairedb/config.php

# Copy files to container and change the ownership to work properly with apache.
COPY . .
USER root
RUN chown -R www-data:www-data .
