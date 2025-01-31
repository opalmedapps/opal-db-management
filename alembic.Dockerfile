FROM python:3.10.11-slim-bullseye

RUN apt-get update \
  # dependencies for building Python packages
  && apt-get install -y build-essential \
  # mysqlclient dependencies
  && apt-get install -y default-libmysqlclient-dev pkg-config \
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
RUN python -m pip install --no-cache-dir -r /tmp/development.txt

COPY docker/alembic-docker-entrypoint.sh /docker-entrypoint.sh
WORKDIR /app/

COPY db_management .
COPY alembic.ini .


ENTRYPOINT ["/docker-entrypoint.sh"]
