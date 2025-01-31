FROM python:3.11.8-slim-bookworm as build

RUN apt-get update \
  && apt-get upgrade \
  # dependencies for building Python packages
  && apt-get install -y build-essential \
  # mysqlclient dependencies
  && apt-get install -y default-libmysqlclient-dev pkg-config \
  # cleaning up unused files
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/*

# Install pip requirements
RUN python -m pip install --no-cache-dir --upgrade pip
COPY ./requirements /tmp/
RUN python -m pip install --no-cache-dir -r /tmp/development.txt

FROM python:3.11.8-slim-bookworm

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# get Python package lib and bin
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
