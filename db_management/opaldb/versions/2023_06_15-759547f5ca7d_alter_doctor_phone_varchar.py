"""alter_doctor_phone_varchar

Revision ID: 759547f5ca7d
Revises: 295142b4e158
Create Date: 2023-06-15 19:38:36.276152

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '759547f5ca7d'
down_revision = '295142b4e158'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Alter doctor and doctor mh to use varchar phone fields."""
    op.alter_column(
        'Doctor',
        'Phone',
        existing_type=mysql.BIGINT(display_width=20),
        type_=sa.String(length=20),
        existing_nullable=True,
    )
    op.alter_column(
        'DoctorMH',
        'Phone',
        existing_type=mysql.INTEGER(display_width=20),
        type_=sa.String(length=20),
        existing_nullable=True,
    )


def downgrade() -> None:
    """Revert varchar phone fields"""
    op.alter_column(
        'DoctorMH',
        'Phone',
        existing_type=sa.String(length=20),
        type_=mysql.INTEGER(display_width=20),
        existing_nullable=True,
    )
    op.alter_column(
        'Doctor',
        'Phone',
        existing_type=sa.String(length=20),
        type_=mysql.BIGINT(display_width=20),
        existing_nullable=True,
    )

