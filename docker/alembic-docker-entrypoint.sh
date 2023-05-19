#!/bin/bash
set -euo pipefail

# Alembic populates database according to version files
# Note: Due to foreign key constraint OpalDB
cd /app/questionnairedb && alembic upgrade head
cd /app/opaldb && alembic upgrade head

# Check for test data insertion condition
if [ "${INSERT_TEST_DATA:-0}" == "1" ]; then
  cd /app && python insert_test_data.py
else
  echo "Omit test data insertion"
fi

exec "$@"
