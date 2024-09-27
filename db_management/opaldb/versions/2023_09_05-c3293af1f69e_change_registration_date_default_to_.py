"""
Change registration date default to current timetstamp.

Revision ID: c3293af1f69e
Revises: 7714d52efeaf
Create Date: 2023-09-05 19:21:44.983692

"""

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'c3293af1f69e'
down_revision = '7714d52efeaf'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Change default of RegistrationDate column to current timestamp."""
    op.alter_column(
        'Patient',
        'RegistrationDate',
        existing_type=mysql.DATETIME(),
        server_default=sa.text('current_timestamp()'),
        existing_nullable=False,
    )


def downgrade() -> None:
    """Revert default of RegistrationDate column to January 1st 2018."""
    op.alter_column(
        'Patient',
        'RegistrationDate',
        existing_type=mysql.DATETIME(),
        server_default=sa.text("'2018-01-01 00:00:00'"),
        existing_nullable=False,
    )
