"""
Add build type.

Revision ID: 7b734eb191ab
Revises: 24441ebcade3
Create Date: 2023-08-08 15:43:00.927961

"""

import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '7b734eb191ab'
down_revision = '24441ebcade3'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add BuildType for tracking Production/Development status of the database."""
    op.create_table(
        'BuildType',
        sa.Column(
            'Name',
            sa.String(length=30),
            nullable=False,
        ),
    )


def downgrade() -> None:
    """Drop BuildType."""
    op.drop_table('BuildType')
