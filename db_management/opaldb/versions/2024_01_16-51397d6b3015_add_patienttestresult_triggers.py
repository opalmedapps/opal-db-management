"""
Add trigger and event for PatientTestResult table in OpalDB.

The trigger immediately creates/updates a Notification record once a lab result inserted to the DB.

The event creates/updates daily a Notification record for the delayed labs.

For more information on how labs are populated to the DB see opal-labs/api/processLabForPatient.php

Revision ID: 51397d6b3015
Revises: 281079041645
Create Date: 2024-01-16 21:44:10.154371

"""

from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject

# revision identifiers, used by Alembic.
revision = '51397d6b3015'
down_revision = '281079041645'
branch_labels = None
depends_on = None


PATIENT_TEST_RESULT_TRIGGER = ReplaceableObject(
    name='`patienttestresult_insert_trigger`',
    sqltext="""
    AFTER INSERT ON `PatientTestResult` FOR EACH ROW
    BEGIN
        INSERT INTO `Notification`(
            `PatientSerNum`,
            `NotificationControlSerNum`,
            `RefTableRowSerNum`,
            `DateAdded`,
            `ReadStatus`,
            `RefTableRowTitle_EN`,
            `RefTableRowTitle_FR`
        )
            SELECT
                NEW.PatientSerNum,
                ntc.NotificationControlSerNum,
                NEW.PatientTestResultSerNum,
                NOW(),
                0,
                'New Lab Result',
                'Nouveau résultat de laboratoire'
            FROM NotificationControl ntc
            WHERE ntc.NotificationType = 'NewLabResult';
    END;
""",
)

CREATE_PATIENT_TEST_RESULT_EVENT = """
    CREATE EVENT delayed_patienttestresult_event
    ON SCHEDULE EVERY 1 DAY STARTS (CURRENT_DATE + INTERVAL 1 DAY)
    COMMENT 'Create notifications for the delayed lab results daily at midnight.'
    DO
        BEGIN
            INSERT INTO `Notification`(
                `PatientSerNum`,
                `NotificationControlSerNum`,
                `RefTableRowSerNum`,
                `DateAdded`,
                `ReadStatus`,
                `RefTableRowTitle_EN`,
                `RefTableRowTitle_FR`
            )
            SELECT
                ptr.PatientSerNum,
                ntc.NotificationControlSerNum,
                ptr.PatientTestResultSerNum,
                NOW(),
                0,
                'New Lab Result',
                'Nouveau résultat de laboratoire'
            FROM PatientTestResult ptr, NotificationControl ntc
            WHERE ntc.NotificationType = 'NewLabResult' AND DATE(ptr.AvailableAt) = CURDATE();
    END;
"""

DROP_PATIENT_TEST_RESULT_EVENT = 'DROP EVENT IF EXISTS delayed_patienttestresult_event'


def upgrade() -> None:
    """Create a trigger and an event for PatientTestResult table."""
    op.create_trigger(PATIENT_TEST_RESULT_TRIGGER)
    op.execute(CREATE_PATIENT_TEST_RESULT_EVENT)


def downgrade() -> None:
    """Delete event and trigger for PatientTestResult table."""
    op.drop_trigger(PATIENT_TEST_RESULT_TRIGGER)
    op.execute(DROP_PATIENT_TEST_RESULT_EVENT)
