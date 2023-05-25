#!/bin/bash
set -euo pipefail

# Alembic populates opaldb according to version files
alembic --name opaldb upgrade head

# Check for test data insertion condition
if [ "${INSERT_TEST_DATA:-0}" == "1" ]; then
  cd /app && python insert_test_data.py
else
  echo "Omit test data insertion"
fi

exec "$@"
