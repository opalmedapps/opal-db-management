"""update_source_system_id_field

Revision ID: 70fe771798bc
Revises: 799788987ccd
Create Date: 2024-10-10 13:59:35.752627

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '70fe771798bc'
down_revision = '799788987ccd'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Update all occurences of AppointmentAriaSer to SourceSystemID and update field type to allow character ids."""
    op.add_column(
        'Appointment',
        sa.Column(
            'SourceSystemID',
            sa.String(length=100),
            nullable=False,
            comment='Unique identifier for the appointment in the source system. Equivalent to ORMs MVA.AppointId field, if ORMs is installed.',  # noqa: E501
        ),
    )
    op.drop_index(
        'ix_Appointment_AppointmentAriaSer',
        table_name='Appointment',
    )
    op.create_index(
        op.f('ix_Appointment_SourceSystemID'),
        'Appointment',
        ['SourceSystemID'],
        unique=False,
    )
    op.drop_column(
        'Appointment',
        'AppointmentAriaSer',
    )
    op.add_column(
        'AppointmentMH',
        sa.Column(
            'SourceSystemID',
            sa.String(length=100),
            nullable=False,
        ),
    )
    op.drop_index(
        'ix_AppointmentMH_AppointmentAriaSer',
        table_name='AppointmentMH',
    )
    op.create_index(
        op.f('ix_AppointmentMH_SourceSystemID'),
        'AppointmentMH',
        ['SourceSystemID'],
        unique=False,
    )
    op.drop_column(
        'AppointmentMH',
        'AppointmentAriaSer',
    )
    op.add_column(
        'AppointmentPending',
        sa.Column(
            'SourceSystemID',
            sa.String(length=100),
            nullable=False,
        ),
    )
    op.drop_index(
        'ix_AppointmentPending_AppointmentAriaSer',
        table_name='AppointmentPending',
    )
    op.drop_index(
        'UniqueAppointment',
        table_name='AppointmentPending',
    )
    op.create_index(
        'UniqueAppointment',
        'AppointmentPending',
        ['sourceName', 'SourceSystemID'],
        unique=True,
    )
    op.create_index(
        op.f('ix_AppointmentPending_SourceSystemID'),
        'AppointmentPending',
        ['SourceSystemID'],
        unique=False,
    )
    op.drop_column(
        'AppointmentPending',
        'AppointmentAriaSer',
    )
    op.add_column(
        'AppointmentPendingMH',
        sa.Column(
            'SourceSystemID',
            sa.String(length=100),
            nullable=False,
        ),
    )
    op.drop_index(
        'ix_AppointmentPendingMH_AppointmentAriaSer',
        table_name='AppointmentPendingMH',
    )
    op.drop_index(
        'UniqueAppointment',
        table_name='AppointmentPendingMH',
    )
    op.create_index(
        'UniqueAppointment',
        'AppointmentPendingMH',
        ['sourceName', 'SourceSystemID'],
        unique=False,
    )
    op.create_index(
        op.f('ix_AppointmentPendingMH_SourceSystemID'),
        'AppointmentPendingMH',
        ['SourceSystemID'],
        unique=False,
    )
    op.drop_column(
        'AppointmentPendingMH',
        'AppointmentAriaSer',
    )


def downgrade() -> None:
    """Revert SourceSystemID to AppointmentAriaSer."""
    op.add_column(
        'AppointmentPendingMH',
        sa.Column(
            'AppointmentAriaSer',
            mysql.INTEGER(display_width=11),
            autoincrement=False,
            nullable=False,
        ),
    )
    op.drop_index(
        op.f('ix_AppointmentPendingMH_SourceSystemID'),
        table_name='AppointmentPendingMH',
    )
    op.drop_index(
        'UniqueAppointment',
        table_name='AppointmentPendingMH',
    )
    op.create_index(
        'UniqueAppointment',
        'AppointmentPendingMH',
        ['sourceName', 'AppointmentAriaSer'],
        unique=False,
    )
    op.create_index(
        'ix_AppointmentPendingMH_AppointmentAriaSer',
        'AppointmentPendingMH',
        ['AppointmentAriaSer'],
        unique=False,
    )
    op.drop_column(
        'AppointmentPendingMH',
        'SourceSystemID',
    )
    op.add_column(
        'AppointmentPending',
        sa.Column(
            'AppointmentAriaSer',
            mysql.INTEGER(display_width=11),
            autoincrement=False,
            nullable=False,
        ),
    )
    op.drop_index(
        op.f('ix_AppointmentPending_SourceSystemID'),
        table_name='AppointmentPending',
    )
    op.drop_index(
        'UniqueAppointment',
        table_name='AppointmentPending',
    )
    op.create_index(
        'UniqueAppointment',
        'AppointmentPending',
        ['sourceName', 'AppointmentAriaSer'],
        unique=True,
    )
    op.create_index(
        'ix_AppointmentPending_AppointmentAriaSer',
        'AppointmentPending',
        ['AppointmentAriaSer'],
        unique=False,
    )
    op.drop_column(
        'AppointmentPending',
        'SourceSystemID',
    )
    op.add_column(
        'AppointmentMH',
        sa.Column(
            'AppointmentAriaSer',
            mysql.INTEGER(display_width=11),
            autoincrement=False,
            nullable=False,
        ),
    )
    op.drop_index(
        op.f('ix_AppointmentMH_SourceSystemID'),
        table_name='AppointmentMH',
    )
    op.create_index(
        'ix_AppointmentMH_AppointmentAriaSer',
        'AppointmentMH',
        ['AppointmentAriaSer'],
        unique=False,
    )
    op.drop_column(
        'AppointmentMH',
        'SourceSystemID',
    )
    op.add_column(
        'Appointment',
        sa.Column(
            'AppointmentAriaSer',
            mysql.INTEGER(display_width=11),
            autoincrement=False,
            nullable=False,
        ),
    )
    op.drop_index(
        op.f('ix_Appointment_SourceSystemID'),
        table_name='Appointment',
    )
    op.create_index(
        'ix_Appointment_AppointmentAriaSer',
        'Appointment',
        ['AppointmentAriaSer'],
        unique=False,
    )
    op.drop_column(
        'Appointment',
        'SourceSystemID',
    )
