# SPDX-FileCopyrightText: Copyright (C) 2025 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""
Remove_the foreign key from Patient_Hospital_Identifier.Hospital_Identifier_Type_Code to Hospital_Identifier_Type.Code.

Replace it with a dedicated column for the code.

Revision ID: 5ea831859359
Revises: 151fda749fb7
Create Date: 2025-06-04 17:56:59.085599
"""

from alembic import op

# revision identifiers, used by Alembic.
revision = '5ea831859359'
down_revision = '151fda749fb7'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Upgrade the database schema to remove the foreign key constraint and replace it with a char column."""
    op.create_table_comment(
        'Hospital_Identifier_Type',
        'Deprecated. Superseded by Site model in new admin',
        existing_comment=None,
        schema=None,
    )
    op.drop_constraint('Patient_Hospital_Identifier_ibfk_1', 'Patient_Hospital_Identifier', type_='foreignkey')


def downgrade() -> None:
    """Downgrade the database schema to restore the foreign key constraint and remove the char column."""
    op.create_foreign_key(
        'Patient_Hospital_Identifier_ibfk_1',
        'Patient_Hospital_Identifier',
        'Hospital_Identifier_Type',
        ['Hospital_Identifier_Type_Code'],
        ['Code'],
    )
    op.drop_table_comment(
        'Hospital_Identifier_Type', existing_comment='Deprecated. Superseded by Site model in new admin', schema=None
    )
