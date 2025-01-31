"""add_offset_fields

Revision ID: 4c21bfb529c8
Revises: ee749ce6f599
Create Date: 2023-10-29 21:29:49.787944

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '4c21bfb529c8'
down_revision = 'ee749ce6f599'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add new columns in Filter to support appointment triggers by ScheduledTime offset."""
    op.add_column('Filters', sa.Column('ScheduledTimeOffset', mysql.INTEGER(display_width=11), server_default=sa.text('0'), nullable=False))
    op.add_column('Filters', sa.Column('ScheduledTimeUnit', sa.Enum('minutes', 'hours', 'days', 'weeks', 'months'), nullable=True))
    op.add_column('Filters', sa.Column('ScheduledTimeDirection', sa.Enum('before', 'after'), server_default=sa.text('after'), nullable=False))
    op.drop_column('Filters', 'scheduled_time_offset')
    op.alter_column('NotificationMH', 'RefTableRowSerNum',
               existing_type=mysql.BIGINT(display_width=11),
               type_=mysql.INTEGER(display_width=11),
               existing_nullable=False)
    op.alter_column('PushNotification', 'RefTableRowSerNum',
               existing_type=mysql.BIGINT(display_width=11),
               type_=mysql.INTEGER(display_width=11),
               existing_nullable=False)
    # ### end Alembic commands ###


def downgrade() -> None:
    """Revert the above changes."""
    op.alter_column('PushNotification', 'RefTableRowSerNum',
               existing_type=mysql.INTEGER(display_width=11),
               type_=mysql.BIGINT(display_width=11),
               existing_nullable=False)
    op.alter_column('NotificationMH', 'RefTableRowSerNum',
               existing_type=mysql.INTEGER(display_width=11),
               type_=mysql.BIGINT(display_width=11),
               existing_nullable=False)
    op.add_column('Filters', sa.Column('scheduled_time_offset', mysql.INTEGER(display_width=11), server_default=sa.text('0'), autoincrement=False, nullable=True))
    op.drop_column('Filters', 'ScheduledTimeDirection')
    op.drop_column('Filters', 'ScheduledTimeUnit')
    op.drop_column('Filters', 'ScheduledTimeOffset')
