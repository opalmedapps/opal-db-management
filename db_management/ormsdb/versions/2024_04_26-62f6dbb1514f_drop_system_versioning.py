# SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Disable system versioning for OrmsDatabase.

Revision ID: 62f6dbb1514f
Revises: 7b734eb191ab
Create Date: 2024-04-26 15:26:14.206735

"""

from pathlib import Path

from alembic import op

# revision identifiers, used by Alembic.
revision = '62f6dbb1514f'
down_revision = '7b734eb191ab'
branch_labels = None
depends_on = None

# Find root and revision data paths for reading sql files
ROOT_DIR = Path(__file__).parents[1]
REVISIONS_DIR = ROOT_DIR / 'revision_data'


def upgrade() -> None:
    """Drop system versioning from all tables."""
    funcs_sql_content = ''
    funcs_file_path = REVISIONS_DIR.joinpath('OrmsDB_disable_system_versioning.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path).open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    op.execute(funcs_sql_content)


def downgrade() -> None:
    """Re-enable system versioning to all tables."""
    funcs_sql_content = ''
    funcs_file_path = REVISIONS_DIR.joinpath('OrmsDB_enable_system_versioning.sql')
    # Read in SQL content from handle
    with Path(funcs_file_path).open(encoding='ISO-8859-1') as file_handle:
        funcs_sql_content += file_handle.read()
        file_handle.close()
    op.execute(funcs_sql_content)
