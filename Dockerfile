# SPDX-FileCopyrightText: Copyright (C) 2021 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

FROM python:3.12.10-alpine3.21 AS build
COPY --from=ghcr.io/astral-sh/uv:0.7.8 /uv /uvx /bin/

# dependencies for building Python packages
RUN apk add --no-cache build-base \
  # mysqlclient dependencies
  && apk add --no-cache mariadb-dev

WORKDIR /app
COPY pyproject.toml .
COPY uv.lock .

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-editable --no-dev --compile-bytecode

FROM python:3.12.10-alpine3.21

RUN apk upgrade --no-cache \
  # mysqlclient dependencies
  && apk add --no-cache mariadb-dev \
  # bash for arrays in shell scripts
  && apk add --no-cache bash

# add venv to search path
ENV PATH=/app/.venv/bin:$PATH

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# get Python packages lib and bin
COPY --from=build /app/.venv /app/.venv
COPY docker/entrypoint.sh /docker-entrypoint.sh
COPY docker/alembic-upgrade.sh /app/alembic-upgrade.sh

WORKDIR /app/
COPY db_management ./db_management
COPY alembic.ini .

ENTRYPOINT ["/docker-entrypoint.sh"]
