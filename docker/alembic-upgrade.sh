#!/bin/sh

# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# option pipefail available on alpine sh
# shellcheck disable=SC3040
set -euo pipefail

echo "Upgrading QuestionnaireDB..."
alembic --name questionnairedb upgrade head
echo "Upgrading OpalDB..."
alembic --name opaldb upgrade head
echo "Upgrading OrmsDatabase..."
alembic --name ormsdb upgrade head
echo "Upgrading OrmsLog..."
alembic --name ormslogdb upgrade head
