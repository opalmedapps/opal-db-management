#!/bin/bash

cd /app/Alembic/opaldb && alembic upgrade head

# TODO: add additional upgrade statements for each database


exec "$@"
