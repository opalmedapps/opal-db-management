"""
Add trigger and event for PatientTestResult table in OpalDB.

The trigger immediately creates/updates a Notification record once a lab result inserted to the DB.

The event creates/updates daily a Notification record for the delayed labs.

For more information on how labs are populated to the DB see opal-labs/api/processLabForPatient.php

Revision ID: 51397d6b3015
Revises: 2cbae06775ef
Create Date: 2024-01-16 21:44:10.154371

"""
from typing import Final

from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject

# revision identifiers, used by Alembic.
revision = '51397d6b3015'
down_revision = '281079041645'
branch_labels = None
depends_on = None


PATIENT_TEST_RESULT_TRIGGER = ReplaceableObject(
    name='`patienttestresult_insert_trigger`',
    sqltext="""AFTER INSERT ON `PatientTestResult` FOR EACH ROW BEGIN\n   INSERT INTO `Notification`(`PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	 	 SELECT NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.PatientTestResultSerNum, NOW(), 0, 'New Lab Result', 'Nouveau résultat de laboratoire'\n	 	 FROM NotificationControl ntc\n	 	 WHERE ntc.NotificationType = 'NewLabResult';\nEND;\n""",
)
PATIENT_TEST_RESULT_EVENT = ReplaceableObject(
    name='`delayed_patienttestresult_event`',
    sqltext="""ON SCHEDULE EVERY 1 DAY STARTS (CURRENT_DATE + INTERVAL 1 DAY)\n   DO\n      INSERT INTO `Notification`(`PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n         SELECT ptr.PatientSerNum, ntc.NotificationControlSerNum, ptr.PatientTestResultSerNum, NOW(), 0, 'New Lab Result', 'Nouveau résultat de laboratoire'\n	 	 FROM PatientTestResult ptr, NotificationControl ntc\n	 	 WHERE ntc.NotificationType = 'NewLabResult' AND DATE(ptr.AvailableAt) = CURDATE();\nEND;\n""",
)

def upgrade() -> None:
    """Create a trigger and an event for PatientTestResult table."""
    op.create_trigger(PATIENT_TEST_RESULT_TRIGGER)
    op.create_event(PATIENT_TEST_RESULT_EVENT)


def downgrade() -> None:
    """Delete event and trigger for PatientTestResult table."""
    op.drop_trigger(PATIENT_TEST_RESULT_TRIGGER)
    op.drop_event(PATIENT_TEST_RESULT_EVENT)
