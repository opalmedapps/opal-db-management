"""‘Default_value_of_AliasName_of_DiagnosisTranslation’

Revision ID: 357c4c529cab
Revises: 7ebe01c0c5e0
Create Date: 2023-05-24 14:39:58.806111

"""
from sqlalchemy.dialects import mysql

from alembic import op

# revision identifiers, used by Alembic.
revision = '357c4c529cab'
down_revision = '7ebe01c0c5e0'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Alter AliasName in DiagnosisTranslation to have proper default."""
    op.alter_column(
        'DiagnosisTranslation',
        'AliasName',
        existing_type=mysql.VARCHAR(length=100),
        nullable=True
    )
