"""Add default value for alert deletedBy.

Revision ID: 7ebe01c0c5e0
Revises: f231a7f6f6ca
Create Date: 2023-05-19 16:57:01.636308

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '7ebe01c0c5e0'
down_revision = 'f231a7f6f6ca'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Alter deletedBy in Alert to have proper default."""
    op.alter_column(
        'alert',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=128),
        server_default=sa.text("''"),
        existing_nullable=False,
        existing_comment='Username of the person who deleted the record',
    )


def downgrade() -> None:
    """Alter deletedBy in Alert to have proper default."""
    op.alter_column(
        'alert',
        'deletedBy',
        existing_type=mysql.VARCHAR(length=128),
        server_default=None,
        existing_nullable=False,
        existing_comment='Username of the person who deleted the record',
    )
