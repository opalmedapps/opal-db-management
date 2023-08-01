"""add_InterpretationRecommended_to_TestControl

Revision ID: 7714d52efeaf
Revises: eb93d22b78f1
Create Date: 2023-07-31 15:05:17.853399

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '7714d52efeaf'
down_revision = '12ea7cde17ce'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add InterpretationRecommended column to record if the clinician interpretation is recommended"""
    op.add_column('TestControl', sa.Column(
        'InterpretationRecommended',
        sa.Boolean(),
        server_default=sa.text('false'),
        nullable=False,
        comment='Clinician interpretation recommended.',
    ))


def downgrade() -> None:
    """Drop InterpretationRecommended column"""
    op.drop_column('TestControl', 'InterpretationRecommended')
