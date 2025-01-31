#!/bin/bash

# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Description: This script upgrades the Production data set for the MUHC.

set -euo pipefail

# Define a log function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

log "Beginning MUHC production data upgrade."

# Define the commands as an array
declare -a commands=(
"python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/upgrade/"
"python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/upgrade/"
"python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/upgrade/"
"python -m db_management.run_sql_scripts OrmsLog db_management/ormslogdb/data/upgrade/"
)


# Execute each command
for cmd in "${commands[@]}"; do
    log "Executing: $cmd"
    if eval "$cmd"; then
        log "Command executed successfully."
    else
        log "Error executing command. Exiting."
        exit 1
    fi
    echo "------------------------------------------------------------"
done

log "Data successfully upgraded and ready for alembic schema upgrade."
