"""
Make `OAUser.Username` unique to avoid duplicate usernames.

Revision ID: 151fda749fb7
Revises: fc19fc57f40d
Create Date: 2024-11-15 19:56:27.518043
"""

from alembic import op

# revision identifiers, used by Alembic.
revision = '151fda749fb7'
down_revision = 'fc19fc57f40d'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add unique constraint to `OAUser.Username`."""
    op.create_unique_constraint('username_unique', 'OAUser', ['Username'])


def downgrade() -> None:
    """Remove unique constraint from `OAUser.Username`."""
    op.drop_constraint('username_unique', 'OAUser', type_='unique')
