"""‘Announcement_readStatus_default’

Revision ID: eb93d22b78f1
Revises: 759547f5ca7d
Create Date: 2023-07-17 18:22:23.476788

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'eb93d22b78f1'
down_revision = '759547f5ca7d'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add default value for the field ReadStatus."""
    op.alter_column(
        'Announcement',
        'ReadStatus',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=sa.text('0'),
        existing_comment='Deprecated',
        existing_nullable=False,
    )


def downgrade() -> None:
    """Remove the default value for the field ReasStatus."""
    op.alter_column(
        'Announcement',
        'ReadStatus',
        existing_type=mysql.INTEGER(display_width=11),
        server_default=None,
        existing_comment='Deprecated',
        existing_nullable=False,
    )
