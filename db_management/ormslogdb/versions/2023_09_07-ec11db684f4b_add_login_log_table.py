# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Add login log table.

Revision ID: ec11db684f4b
Revises: 07f067b25688
Create Date: 2023-09-07 14:52:49.462284

"""

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'ec11db684f4b'
down_revision = '07f067b25688'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Upgrade function to create LoginLog table."""
    op.create_table(
        'LoginLog',
        sa.Column('ID', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('UserName', sa.String(length=50), nullable=False),
        sa.Column('DisplayName', sa.String(length=50), server_default=sa.text("''"), nullable=True),
        sa.Column('LoginDate', sa.TIMESTAMP(), server_default=sa.text('current_timestamp()'), nullable=False),
        sa.Column('Status', mysql.INTEGER(display_width=11), nullable=False),
        sa.Column('Error', sa.String(length=200), server_default=sa.text("''"), nullable=True),
        sa.Column('LoginIPAddress', sa.String(length=20), server_default=sa.text("''"), nullable=False),
        sa.PrimaryKeyConstraint('ID'),
    )
    op.create_index(op.f('ix_LoginLog_UserName'), 'LoginLog', ['UserName'], unique=False)


def downgrade() -> None:
    """Downgrade function to delete LoginLog table."""
    op.drop_index(op.f('ix_LoginLog_UserName'), table_name='LoginLog')
    op.drop_table('LoginLog')
