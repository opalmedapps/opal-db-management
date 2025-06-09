#!/bin/bash

# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Description: This script resets the test data insertions for OpalDB, QuestionnaireDB, and orms.
# Args:
#      Institution: omi or ohigph

set -euo pipefail

# Define a log function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

log "Beginning test data reset."

# Check for the institution argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <institution>"
    echo "Valid institutions: omi, ohigph, OMI, OHIGPH"
    exit 1
fi

# Convert the provided institution to lowercase for easier directory-based script call
institution=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# Validate the institution
if [[ "$institution" != "omi" && "$institution" != "ohigph" ]]; then
    echo "Invalid argument: $institution"
    echo "Valid arguments: omi, ohigph"
    exit 1
fi


# Define the commands as an array
declare -a commands=(
    "python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/truncate/"
    "python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/truncate/"
    "python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/truncate/"
)

# Insert fake patients if in CI to avoid foreign key constraint errors
if [[ -n "${CI:-}" ]]; then
    commands+=("python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/patients/")
fi

commands+=(
    # QuestionnaireDB needs to come first due to references from OpalDB to QuestionnaireDB
    "python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/initial/"
    "python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/test/$institution/"
    "python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/test/"
    "python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/initial/"
    "python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/"
    "python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/$institution/"
    "python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/initial/"
    "python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/test/"
    "python -m db_management.run_sql_scripts OrmsDatabase db_management/ormsdb/data/test/$institution/"
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

log "Test data successfully reset."
