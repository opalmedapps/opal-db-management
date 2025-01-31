# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Add build type.

Revision ID: cba33004cbc6
Revises: d007634d1fdd
Create Date: 2023-08-08 15:37:29.611695

"""

import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = 'cba33004cbc6'
down_revision = 'd007634d1fdd'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add BuildType for tracking Production/Development status of the database."""
    op.create_table(
        'BuildType',
        sa.Column(
            'Name',
            sa.String(length=30),
            nullable=False,
        ),
    )


def downgrade() -> None:
    """Drop BuildType."""
    op.drop_table('BuildType')
