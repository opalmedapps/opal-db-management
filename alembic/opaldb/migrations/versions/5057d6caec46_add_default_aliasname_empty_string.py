"""add_default_aliasname_empty_string

Revision ID: 5057d6caec46
Revises: 7ebe01c0c5e0
Create Date: 2023-05-25 13:22:54.474766

"""
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

from alembic import op

# revision identifiers, used by Alembic.
revision = '5057d6caec46'
down_revision = '7ebe01c0c5e0'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add default value for DiagnosisTranslation.AliasName"""
    op.alter_column(
        'DiagnosisTranslation',
        'AliasName',
        existing_type=mysql.VARCHAR(length=100),
        server_default=sa.text("''"),
        existing_nullable=False,
    )


def downgrade() -> None:
    """Remove default value for DiagnosisTranslation.AliasName"""
    op.alter_column(
        'DiagnosisTranslation',
        'AliasName',
        existing_type=mysql.VARCHAR(length=100),
        server_default=None,
        existing_nullable=False,
    )
