#!/bin/bash
set -euo pipefail

# Alembic populates opaldb according to version files
cd opaldb && alembic upgrade head

# Check for test data insertion condition
if [ -z "${INSERT_TEST_DATA:-}" ]; then
  echo "Omit test data insertion"
else
  cd /app && python insert_test_data.py
fi

exec "$@"
