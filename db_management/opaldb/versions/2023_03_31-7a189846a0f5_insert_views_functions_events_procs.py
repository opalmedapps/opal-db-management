# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Insert views, functions, events, and procedures.

Revision ID: 7a189846a0f5
Revises: 85a1cf55990c
Create Date: 2023-02-01 10:41:21.466828

"""

from pathlib import Path

from db_management.connection import connection_cursor, sql_connection_parameters
from db_management.settings import DB_NAME_OPAL, DB_USER

# revision identifiers, used by Alembic.
revision = '7a189846a0f5'
down_revision = '85a1cf55990c'
branch_labels = None
depends_on = None

# Find root and revision data paths
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'

CONNECTION_PARAMETERS = sql_connection_parameters(DB_NAME_OPAL)


def upgrade() -> None:
    """Insert functions, events, etc for OpalDB."""
    with connection_cursor(CONNECTION_PARAMETERS) as cursor:
        cursor.execute(query='SET foreign_key_checks=0;')

    funcs_sql_content = ''
    funcs_file_path = REVISIONS_DIR.joinpath('OpalDB_views_functions_events_procs.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path).open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    # Execute
    with connection_cursor(CONNECTION_PARAMETERS) as cursor:
        cursor.execute(funcs_sql_content)
        cursor.execute(query='SET foreign_key_checks = 1;')
        cursor.close()


def downgrade() -> None:
    """Drop all from OpalDB."""
    with connection_cursor(CONNECTION_PARAMETERS) as cursor:
        cursor.execute(query='SET foreign_key_checks=0;')

        cursor.execute(
            query=f"""
        DROP DATABASE {DB_NAME_OPAL};

        CREATE DATABASE IF NOT EXISTS {DB_NAME_OPAL} /*!40100 DEFAULT CHARACTER SET latin1 */;
        USE {DB_NAME_OPAL};
        GRANT ALL PRIVILEGES ON {DB_NAME_OPAL}.* TO {DB_USER}@`%`;

        """
        )

        cursor.execute(query='SET foreign_key_checks=1;')
        cursor.close()
