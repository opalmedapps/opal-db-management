"""Adds missing autoincrements to OpalDB.

Revision ID: 12ea7cde17ce
Revises: 759547f5ca7d
Create Date: 2023-07-18 16:04:02.348834

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '12ea7cde17ce'
down_revision = '759547f5ca7d'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add autoincrements to various MH tables."""
    pass

def downgrade() -> None:
    """Remove autoincrements from various MH tables."""
    pass
