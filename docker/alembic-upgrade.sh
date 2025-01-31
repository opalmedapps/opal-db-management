#!/bin/sh
set -euo pipefail

echo "Upgrading QuestionnaireDB..."
alembic --name questionnairedb upgrade head
echo "Upgrading OpalDB..."
alembic --name opaldb upgrade head
echo "Upgrading OrmsDatabase..."
alembic --name ormsdb upgrade head
echo "Upgrading OrmsLog..."
alembic --name ormslogdb upgrade head
