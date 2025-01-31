# syntax = docker/dockerfile:1.0-experimental
FROM python:3.10.10-slim-bullseye

# for which environment the build is done: development or production
ARG ENV=development

RUN apt-get update \
  # dependencies for building Python packages
  && apt-get install -y build-essential \
  #install git
  && apt-get install git -y \
  # mysqlclient dependencies
  && apt-get install -y default-libmysqlclient-dev \
  # argon2-cffi dependencies
  && apt-get install -y libffi-dev libssl-dev \
  # Translations dependencies
  && apt-get install -y gettext \
  # cleaning up unused files
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/*

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install pip requirements
RUN python -m pip install --upgrade pip
COPY ./requirements /tmp/
RUN python -m pip install --no-cache-dir packaging
RUN python -m pip install --no-cache-dir -r /tmp/${ENV}.txt

EXPOSE 8092

COPY db-scripts/docker-entrypoint.sh /docker-entrypoint.sh
WORKDIR /app
ADD alembic /app/alembic

WORKDIR /app/alembic/opaldb

ENTRYPOINT ["/docker-entrypoint.sh", "tail", "-f", "/dev/null"]
