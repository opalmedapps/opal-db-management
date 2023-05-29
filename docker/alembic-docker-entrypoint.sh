#!/bin/bash
set -euo pipefail

# Alembic populates opaldb according to version files
alembic --name opaldb upgrade head

exec "$@"
