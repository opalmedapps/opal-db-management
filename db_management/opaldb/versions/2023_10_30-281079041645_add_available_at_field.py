"""add_available_at_field

Revision ID: 281079041645
Revises: ee749ce6f599
Create Date: 2023-10-30 18:18:47.562219

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '281079041645'
down_revision = 'd52eab1ee338'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Add new columns in PatientTestResult to indicate the date and time when it is available to be viewed."""
    op.add_column(
        'PatientTestResult',
        sa.Column(
            'AvailableAt',
            sa.DateTime(),
            nullable=True,
        ),
    )


def downgrade() -> None:
    """Revert the above changes."""
    op.drop_column('PatientTestResult', 'AvailableAt')
