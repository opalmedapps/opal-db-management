"""
Add offset fields.

Revision ID: d52eab1ee338
Revises: ee749ce6f599
Create Date: 2023-10-29 22:40:49.035315

"""

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'd52eab1ee338'
down_revision = 'ee749ce6f599'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add new columns in Filter to support appointment triggers by ScheduledTime offset."""
    op.add_column(
        'Filters',
        sa.Column(
            'ScheduledTimeOffset',
            mysql.INTEGER(display_width=11),
            server_default=sa.text('0'),
            nullable=False,
        ),
    )
    op.add_column(
        'Filters',
        sa.Column(
            'ScheduledTimeUnit',
            sa.Enum('minutes', 'hours', 'days', 'weeks', 'months'),
            nullable=True,
        ),
    )
    op.add_column(
        'Filters',
        sa.Column(
            'ScheduledTimeDirection',
            sa.Enum('before', 'after'),
            server_default=sa.text("'after'"),
            nullable=False,
        ),
    )


def downgrade() -> None:
    """Revert the above changes."""
    op.drop_column('Filters', 'ScheduledTimeDirection')
    op.drop_column('Filters', 'ScheduledTimeUnit')
    op.drop_column('Filters', 'ScheduledTimeOffset')
