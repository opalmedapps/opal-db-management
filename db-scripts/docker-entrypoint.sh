#!/bin/bash

cd /app/Alembic/opaldb && alembic upgrade head && cd ../

# TODO: add additional upgrade statements for each database


exec "$@"
