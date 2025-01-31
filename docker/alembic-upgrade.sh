#!/bin/bash
set -euo pipefail

echo "Upgrading QuestionnaireDB..."
alembic --name questionnairedb upgrade head
echo "Upgrading OpalDB..."
alembic --name opaldb upgrade head
echo "Upgrading ormsDB..."
alembic --name ormsdb upgrade head
echo "Upgrading ormslogDB..."
alembic --name ormslogdb upgrade head
