"""Change patient doctor last update default value to current date.

Revision ID: 0326fe035657
Revises: 799788987ccd
Create Date: 2024-08-12 16:30:15.942315

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '0326fe035657'
down_revision = '799788987ccd'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Create comments."""
    op.alter_column(
        'PatientDoctorHistory',
        'LastUpdated',
        existing_type=mysql.TIMESTAMP(),
        server_default=sa.text('current_timestamp() ON UPDATE current_timestamp()'),
        existing_nullable=False,
    )


def downgrade() -> None:
    """Drop comments."""
    op.alter_column(
        'PatientDoctorHistory',
        'LastUpdated',
        existing_type=mysql.TIMESTAMP(),
        server_default=sa.text("'0000-00-00 00:00:00'"),
        existing_nullable=False,
    )
