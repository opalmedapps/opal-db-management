#!/bin/bash
set -euo pipefail

# Alembic populates database according to version files
# Note: Due to foreign key constraint OpalDB must be run last
alembic --name questionnairedb upgrade head
alembic --name opaldb upgrade head

# Check for test data insertion condition
if [ "${INSERT_TEST_DATA:-0}" == "1" ]; then
  cd /app && python insert_test_data.py
else
  echo "Omit test data insertion"
fi

exec "$@"
