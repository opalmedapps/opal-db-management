#!/bin/bash
set -euo pipefail

# Alembic populates database according to version files
# Note: Due to foreign key constraint OpalDB must be after QuestionnaireDB
alembic --name questionnairedb upgrade head
alembic --name opaldb upgrade head
alembic --name ormsdb upgrade head

exec "$@"
