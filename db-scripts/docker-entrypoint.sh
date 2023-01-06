#!/bin/bash

cd /app/alembic/opaldb && alembic upgrade head

# TODO: add additional upgrade statements for each database


exec "$@"
