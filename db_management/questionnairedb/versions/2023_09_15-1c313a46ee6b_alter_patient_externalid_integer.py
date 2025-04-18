# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Alter-patient-externalid-integer.

Revision ID: 1c313a46ee6b
Revises: cba33004cbc6
Create Date: 2023-09-15 15:02:48.286414

"""

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '1c313a46ee6b'
down_revision = 'cba33004cbc6'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Alter patient.externalId to Integer to increase query efficiency."""
    op.alter_column(
        'patient',
        'externalId',
        existing_type=sa.VARCHAR(length=64),
        type_=mysql.INTEGER(display_width=11),
        comment='OpalDB.Patient.PatientSerNum',
        existing_nullable=False,
    )


def downgrade() -> None:
    """Set patient.externalId to String."""
    op.alter_column(
        'patient',
        'externalId',
        existing_type=mysql.INTEGER(display_width=11),
        type_=sa.VARCHAR(length=64),
        comment=None,
        existing_comment='OpalDB.Patient.PatientSerNum',
        existing_nullable=False,
    )
