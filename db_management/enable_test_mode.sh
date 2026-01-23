#!/bin/bash

# SPDX-FileCopyrightText: Copyright (C) 2026 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Description: This script sets BuildType to Development for OpalDB, QuestionnaireDB, and orms to allow test data to be reset and inserted.

set -euo pipefail

# Define a log function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

log "Enabling test mode..."


python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/testmode/
python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/test/testmode/
python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/test/testmode/

log "Test mode enabled."
