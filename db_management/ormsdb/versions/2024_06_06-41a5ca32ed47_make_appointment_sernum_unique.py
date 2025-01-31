"""make_appointment_sernum_unique

Revision ID: 41a5ca32ed47
Revises: 62f6dbb1514f
Create Date: 2024-06-06 13:45:43.394491

"""
from alembic import op

# revision identifiers, used by Alembic.
revision = '41a5ca32ed47'
down_revision = '62f6dbb1514f'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Alter the appointment sernum column in patient location table."""
    op.drop_index('ix_PatientLocationMH_AppointmentSerNum', table_name='PatientLocationMH')
    op.create_index(
        op.f('ix_PatientLocationMH_AppointmentSerNum'),
        'PatientLocationMH',
        ['AppointmentSerNum'],
        unique=True,
    )


def downgrade() -> None:
    """Drop the column change."""
    op.drop_index(op.f('ix_PatientLocationMH_AppointmentSerNum'), table_name='PatientLocationMH')
    op.create_index(
        'ix_PatientLocationMH_AppointmentSerNum',
        'PatientLocationMH',
        ['AppointmentSerNum'],
        unique=False,
    )
