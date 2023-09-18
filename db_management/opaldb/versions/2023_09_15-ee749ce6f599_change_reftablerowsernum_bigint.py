"""
Change `RefTableRowSerNum` to BigInt from Integer.

Revision ID: ee749ce6f599
Revises: c3293af1f69e
Create Date: 2023-09-15 15:14:47.971625

"""
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'ee749ce6f599'
down_revision = 'c3293af1f69e'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Change column type to BigInt."""
    op.alter_column(
        'NotificationMH',
        'RefTableRowSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        type_=mysql.BIGINT(display_width=11),
        existing_nullable=False,
    )
    op.alter_column(
        'PushNotification',
        'RefTableRowSerNum',
        existing_type=mysql.INTEGER(display_width=11),
        type_=mysql.BIGINT(display_width=11),
        existing_nullable=False,
    )


def downgrade() -> None:
    """Revert the column type to Integer."""
    op.alter_column(
        'PushNotification',
        'RefTableRowSerNum',
        existing_type=mysql.BIGINT(display_width=11),
        type_=mysql.INTEGER(display_width=11),
        existing_nullable=False,
    )
    op.alter_column(
        'NotificationMH',
        'RefTableRowSerNum',
        existing_type=mysql.BIGINT(display_width=11),
        type_=mysql.INTEGER(display_width=11),
        existing_nullable=False,
    )
