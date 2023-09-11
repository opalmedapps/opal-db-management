#!/bin/bash
# Description: This script resets the test data insertions for OpalDB, QuestionnaireDB, and orms.
# Args:
#      Institution: muhc or chusj


# Define a log function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

log "Beginning test data reset."

# Check for the institution argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <institution>"
    echo "Valid institutions: muhc, chusj, MUHC, CHUSJ"
    exit 1
fi

# Convert the provided institution to lowercase for easier directory-based script call
institution=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# Validate the institution
if [[ "$institution" != "muhc" && "$institution" != "chusj" ]]; then
    echo "Invalid argument: $institution"
    echo "Valid arguments: muhc, chusj"
    exit 1
fi


# Define the commands as an array
declare -a commands=(
"python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/truncate/"
"python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/truncate/"
"python -m db_management.run_sql_scripts orms db_management/ormsdb/data/truncate/"
"python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/initial/"
"python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/$institution/"
"python -m db_management.run_sql_scripts OpalDB db_management/opaldb/data/test/ --disable-foreign-key-checks"
"python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/initial/"
"python -m db_management.run_sql_scripts QuestionnaireDB db_management/questionnairedb/data/test/"
"python -m db_management.run_sql_scripts orms db_management/ormsdb/data/initial/"
"python -m db_management.run_sql_scripts orms db_management/ormsdb/data/test/"
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
