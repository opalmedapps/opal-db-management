FROM python:3.13.0-alpine3.20 AS build

# dependencies for building Python packages
RUN apk add --no-cache build-base \
  # mysqlclient dependencies
  && apk add --no-cache mariadb-dev

# Install pip requirements
RUN python -m pip install --no-cache-dir --upgrade pip
COPY ./requirements /tmp/
RUN python -m pip install --no-cache-dir -r /tmp/base.txt

FROM python:3.13.0-alpine3.20

RUN apk upgrade --no-cache \
  # mysqlclient dependencies
  && apk add --no-cache mariadb-dev \
  # bash for arrays in shell scripts
  && apk add --no-cache bash

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# get Python packages lib and bin
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/lib /usr/local/lib
COPY docker/alembic-docker-entrypoint.sh /docker-entrypoint.sh
COPY docker/alembic-upgrade.sh /app/alembic-upgrade.sh

WORKDIR /app/

COPY db_management ./db_management
COPY alembic.ini .

ENTRYPOINT ["/docker-entrypoint.sh"]
# TODO: If we want to make the alembic container stay alive instead of closing, we could add "tail" "-f" "/dev/null"
#       to the arguments in the ENTRYPOINT commands, but apparently that can cause some issues with Linux users:
#       https://stackoverflow.com/questions/43843079/using-tail-f-dev-null-to-keep-container-up-fails-unexpectedly
