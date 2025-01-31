"""add_interpretability_flag_to_test_control

Revision ID: 9d4ea63841f1
Revises: eb93d22b78f1
Create Date: 2023-07-25 19:57:08.324851

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '9d4ea63841f1'
down_revision = 'eb93d22b78f1'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add InterpretabilityFlag column to record if the lab result requires clinician interpretation"""
    op.add_column('TestControl', sa.Column(
        'InterpretabilityFlag',
        sa.Boolean(),
        server_default=sa.text('false'),
        nullable=False,
        comment='Marker for data if the lab result requires clinician interpretation.',
    ))


def downgrade() -> None:
    """Drop InterpretabilityFlag column"""
    op.drop_column('TestControl', 'InterpretabilityFlag')
