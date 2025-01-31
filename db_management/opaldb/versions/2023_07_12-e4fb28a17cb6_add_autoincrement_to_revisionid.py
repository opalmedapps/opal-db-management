# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Add autoincrement to revisionid.

Revision ID: e4fb28a17cb6
Revises: 759547f5ca7d
Create Date: 2023-07-12 17:43:36.846170

"""

from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'e4fb28a17cb6'
down_revision = '759547f5ca7d'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Set autoincrement to True for the revisionId column."""
    op.alter_column(
        'AppointmentPendingMH',
        'revisionId',
        existing_type=mysql.BIGINT(display_width=20),
        existing_nullable=False,
        existing_autoincrement=False,
        autoincrement=True,
    )


def downgrade() -> None:
    """Set autoincrement to False for the revisionId column."""
    op.alter_column(
        'AppointmentPendingMH',
        'revisionId',
        existing_type=mysql.BIGINT(display_width=20),
        existing_nullable=False,
        autoincrement=False,
    )
