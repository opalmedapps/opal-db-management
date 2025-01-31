#!/bin/bash
set -euo pipefail

# Alembic populates database according to version files
# Note: Due to foreign key constraint OpalDB must be after QuestionnaireDB
echo "Upgrading QuestionnaireDB..."
alembic --name questionnairedb upgrade head
echo "Upgrading OpalDB..."
alembic --name opaldb upgrade head
echo "Upgrading ormsDB..."
alembic --name ormsdb upgrade head
echo "Upgrading ormslogDB..."
alembic --name ormslogdb upgrade head

exec "$@"
