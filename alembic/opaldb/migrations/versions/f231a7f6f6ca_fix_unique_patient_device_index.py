"""Fix unique index in PatientDeviceIdentifier since PatientSerNum was replaced by Username (QSCCD-1123)

Revision ID: f231a7f6f6ca
Revises: 83ccbdfcf3b5
Create Date: 2023-05-09 17:58:55.818233

"""
from alembic import op

# revision identifiers, used by Alembic.
revision = 'f231a7f6f6ca'
down_revision = '83ccbdfcf3b5'
branch_labels = None
depends_on = None


# Ensure that the username values for legacy rows in the PatientDeviceIdentifier table have been populated.
# This is necessary for rows that used PatientSerNum, before the Username column was added.
username_migration_query = """
    UPDATE PatientDeviceIdentifier pdi
    SET pdi.Username = IFNULL((
        SELECT Username FROM Users u
        WHERE u.UserTypeSerNum = pdi.PatientSerNum
            AND u.UserType = 'Patient'
    ), '')
    WHERE pdi.Username = ''
        AND pdi.PatientSerNum IS NOT NULL
    ;
"""


def sanitization_query(unique_field_first: str, unique_field_second: str) -> str:
    """
    Delete all rows that would violate constraint uniqueness, based on the two provided fields.

    As a result, only one row is kept with the most recent LastUpdated timestamp for each field pair.
    Without this sanitization, creation of the unique index would fail if any duplicate rows already exist.

    Args:
        unique_field_first: The first of the pair of fields that must be unique together.
        unique_field_second: The second of the pair of fields that must be unique together.

    Returns:
        A query that performs the uniqueness sanitization.
    """
    query = """
        DROP TEMPORARY TABLE IF EXISTS pdi_rows;

        -- Label rows in PatientDeviceIdentifier with row numbers for each {field1}, {field2} combination
        -- The most recently updated row for each {field1} and {field2} combination will have row number 1
        CREATE TEMPORARY TABLE pdi_rows
        SELECT
            ROW_NUMBER() OVER (
                PARTITION BY {field1}, {field2}
                ORDER BY LastUpdated DESC
            ) row_num,
           pdi.*
        FROM
            PatientDeviceIdentifier pdi;

        -- Delete all rows not labelled "1" to get rid of duplicates on the unique constraint
        DELETE FROM PatientDeviceIdentifier
        WHERE PatientDeviceIdentifierSerNum IN (
            SELECT PatientDeviceIdentifierSerNum
            FROM pdi_rows
            WHERE pdi_rows.row_num <> 1
        );

        DROP TEMPORARY TABLE IF EXISTS pdi_rows;
    """
    return query.format(field1=unique_field_first, field2=unique_field_second)


def upgrade() -> None:
    """Fix PatientDeviceIdentifier unique index with the right fields since replacing PatientSerNum by Username."""
    # Ensure the username fields have been populated for legacy rows
    op.execute(username_migration_query)

    # Sanitize data before creating the new unique index to prevent uniqueness conflicts
    op.execute(sanitization_query('Username', 'DeviceId'))

    op.drop_index('patient_device', table_name='PatientDeviceIdentifier')
    op.create_index(
        'ix_PatientDeviceIdentifier_Unique_Username_DeviceId',
        'PatientDeviceIdentifier',
        ['Username', 'DeviceId'],
        unique=True,
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    """Revert change of PatientDeviceIdentifier's unique index."""
    # Sanitize data before restoring the old the unique index to prevent uniqueness conflicts
    op.execute(sanitization_query('PatientSerNum', 'DeviceId'))

    op.drop_index('ix_PatientDeviceIdentifier_Unique_Username_DeviceId', table_name='PatientDeviceIdentifier')
    op.create_index('patient_device', 'PatientDeviceIdentifier', ['PatientSerNum', 'DeviceId'], unique=True)
    # ### end Alembic commands ###
