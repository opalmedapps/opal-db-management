"""add_offset_fields

Revision ID: b1053ec56a50
Revises: ee749ce6f599
Create Date: 2023-10-29 21:54:27.531336

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'b1053ec56a50'
down_revision = 'ee749ce6f599'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add new columns in Filter to support appointment triggers by ScheduledTime offset."""
    op.add_column('Filters', sa.Column('ScheduledTimeOffset', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=True))
    op.add_column('Filters', sa.Column('ScheduledTimeUnit', sa.Enum('minutes', 'hours', 'days', 'weeks', 'months'), nullable=True))
    op.add_column('Filters', sa.Column('ScheduledTimeDirection', sa.Enum('before', 'after'), server_default=sa.text('after'), nullable=True))


def downgrade() -> None:
    """Revert the above changes."""
    op.drop_column('Filters', 'ScheduledTimeDirection')
    op.drop_column('Filters', 'ScheduledTimeUnit')
    op.drop_column('Filters', 'ScheduledTimeOffset')
