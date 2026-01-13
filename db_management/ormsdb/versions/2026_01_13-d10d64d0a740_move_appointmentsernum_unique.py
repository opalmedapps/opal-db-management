# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Move `unique=True` from PatientLocationMH.AppointSerNum to PatientLocation.AppointmentSerNum.

Revision ID: d10d64d0a740
Revises: 41a5ca32ed47
Create Date: 2026-01-13 16:12:03.416194

"""

from alembic import op

# revision identifiers, used by Alembic.
revision = 'd10d64d0a740'
down_revision = '41a5ca32ed47'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Move unique from PatientLocationMH.AppointSerNum to PatientLocation.AppointmentSerNum."""
    op.drop_index(op.f('ix_PatientLocation_AppointmentSerNum'), table_name='PatientLocation')
    op.create_index(op.f('ix_PatientLocation_AppointmentSerNum'), 'PatientLocation', ['AppointmentSerNum'], unique=True)
    op.drop_index(op.f('ix_PatientLocationMH_AppointmentSerNum'), table_name='PatientLocationMH')
    op.create_index(
        op.f('ix_PatientLocationMH_AppointmentSerNum'), 'PatientLocationMH', ['AppointmentSerNum'], unique=False
    )


def downgrade() -> None:
    """Move unique from PatientLocation.AppointSerNum to PatientLocationMH.AppointmentSerNum."""
    op.drop_index(op.f('ix_PatientLocationMH_AppointmentSerNum'), table_name='PatientLocationMH')
    op.create_index(
        op.f('ix_PatientLocationMH_AppointmentSerNum'), 'PatientLocationMH', ['AppointmentSerNum'], unique=True
    )
    op.drop_index(op.f('ix_PatientLocation_AppointmentSerNum'), table_name='PatientLocation')
    op.create_index(
        op.f('ix_PatientLocation_AppointmentSerNum'), 'PatientLocation', ['AppointmentSerNum'], unique=False
    )
