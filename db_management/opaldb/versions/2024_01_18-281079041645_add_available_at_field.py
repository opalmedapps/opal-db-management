"""add_available_at_field

Revision ID: 281079041645
Revises: ee749ce6f599
Create Date: 2023-10-30 18:18:47.562219

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '281079041645'
down_revision = '224fa0bbfd7c'
branch_labels = None
depends_on = None


# Ensure that the AvailableAt column have been populated with the value from column ResultDateTime.
available_at_migration_query = """
    UPDATE PatientTestResult ptr
    SET ptr.AvailableAt = ptr.ResultDateTime
    WHERE ptr.ResultDateTime IS NOT NULL
    ;
"""


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
    # Ensure the AvailableAt fields have been populated with the values of the ResultDateTime field
    op.execute(available_at_migration_query)
    op.alter_column(
        'PatientTestResult',
        'AvailableAt',
        existing_type=sa.DateTime(),
        nullable=False,
    )


def downgrade() -> None:
    """Revert the above changes."""
    op.drop_column('PatientTestResult', 'AvailableAt')
