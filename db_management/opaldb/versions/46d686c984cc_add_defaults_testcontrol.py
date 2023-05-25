"""Add server defaults (empty strings) to DT and TC tables.

Revision ID: 46d686c984cc
Revises: 7ebe01c0c5e0
Create Date: 2023-05-25 13:27:29.218739

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '46d686c984cc'
down_revision = '7ebe01c0c5e0'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Define server defaults for DiagnosisTranslation, TestControl tables"""
    op.alter_column(
        'DiagnosisTranslation',
        'AliasName',
        existing_type=mysql.VARCHAR(length=100),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'TestControl',
        'URL_EN',
        existing_type=mysql.VARCHAR(length=2000),
        server_default=sa.text("''"),
        existing_nullable=False,
    )
    op.alter_column(
        'TestControl',
        'URL_FR',
        existing_type=mysql.VARCHAR(length=2000),
        server_default=sa.text("''"),
        existing_nullable=False,
    )


def downgrade() -> None:
    """Remove server defaults for DiagnosisTranslation, TestControl tables"""
    op.alter_column(
        'TestControl',
        'URL_FR',
        existing_type=mysql.VARCHAR(length=2000),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'TestControl',
        'URL_EN',
        existing_type=mysql.VARCHAR(length=2000),
        server_default=None,
        existing_nullable=False,
    )
    op.alter_column(
        'DiagnosisTranslation',
        'AliasName',
        existing_type=mysql.VARCHAR(length=100),
        server_default=None,
        existing_nullable=False,
    )
