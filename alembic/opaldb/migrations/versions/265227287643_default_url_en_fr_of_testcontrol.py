"""‘default_url_en_fr_of_testcontrol’

Revision ID: 265227287643
Revises: 7ebe01c0c5e0
Create Date: 2023-05-24 17:25:46.042693

"""
from sqlalchemy.dialects import mysql

from alembic import op

# revision identifiers, used by Alembic.
revision = '265227287643'
down_revision = '7ebe01c0c5e0'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Alter URL_EN and URL_FR in TestControl to have proper defaults."""
    op.alter_column('TestControl', 'URL_EN',
               existing_type=mysql.VARCHAR(length=2000),
               nullable=True)
    op.alter_column('TestControl', 'URL_FR',
               existing_type=mysql.VARCHAR(length=2000),
               nullable=True)
