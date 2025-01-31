"""
Add triggers for marking `Notification` records as read.

Triggers are added for the following tables:
    - Announcement
    - Appointment
    - Document
    - EducationalMaterial
    - Questionnaire
    - TxTeamMessage

The triggers immediately update `Notification` records once the corresponding categories are marked as read.

Revision ID: bc09885fdeec
Revises: 627bbdebf282
Create Date: 2024-02-19 21:52:59.876836

"""
from typing import Final

from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject

# revision identifiers, used by Alembic.
revision = 'bc09885fdeec'
down_revision = '627bbdebf282'
branch_labels = None
depends_on = None

UPDATED_DOCUMENT_INSERT_TRIGGER = ReplaceableObject(
    name='`document_insert_trigger`',
    sqltext="""AFTER INSERT ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `CronLogSerNum`, `SessionId`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`,\n					`ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`,\n					`TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum,NULL,NEW.CronLogSerNum, NULL,NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.DocumentId,NEW.AliasExpressionSerNum,NEW.ApprovedBySerNum,NEW.ApprovedTimeStamp,\n				NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry,NEW.ErrorReasonText,NEW.OriginalFileName,NEW.FinalFileName, NEW.CreatedBySerNum, NEW.CreatedTimeStamp,\n				NEW.TransferStatus,NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'INSERT');\nEND;\n""",  # noqa: WPS322, E501
)

UPDATED_DOCUMENT_UPDATE_TRIGGER = ReplaceableObject(
    name='`document_update_trigger`',
    sqltext="""AFTER UPDATE ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`,\n									`ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`,\n									`CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum, NULL,NEW.SessionId, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.DocumentId, NEW.AliasExpressionSerNum, NEW.ApprovedBySerNum,\n				NEW.ApprovedTimeStamp, NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry, NEW.ErrorReasonText, NEW.OriginalFileName, NEW.FinalFileName, NEW.CreatedBySerNum,\n				NEW.CreatedTimeStamp, NEW.TransferStatus, NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'UPDATE');\nEND;\n""",  # noqa: WPS322, E501
)

OLD_DOCUMENT_INSERT_TRIGGER = ReplaceableObject(
    name='`document_insert_trigger`',
    sqltext="""AFTER INSERT ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `CronLogSerNum`, `SessionId`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`,\n					`ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`,\n					`TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum,NULL,NEW.CronLogSerNum, NULL,NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.DocumentId,NEW.AliasExpressionSerNum,NEW.ApprovedBySerNum,NEW.ApprovedTimeStamp,\n				NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry,NEW.ErrorReasonText,NEW.OriginalFileName,NEW.FinalFileName, NEW.CreatedBySerNum, NEW.CreatedTimeStamp,\n				NEW.TransferStatus,NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'INSERT');\n\n	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR\n	FROM NotificationControl ntc, Patient pt\n	WHERE ntc.NotificationType = 'Document'\n		AND pt.PatientSerNum = NEW.PatientSerNum\n		AND pt.AccessLevel = 3;\nEND;\n""",  # noqa: WPS322, E501
)

OLD_DOCUMENT_UPDATE_TRIGGER = ReplaceableObject(
    name='`document_update_trigger`',
    sqltext="""AFTER UPDATE ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`,\n									`ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`,\n									`CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum, NULL,NEW.SessionId, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.DocumentId, NEW.AliasExpressionSerNum, NEW.ApprovedBySerNum,\n				NEW.ApprovedTimeStamp, NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry, NEW.ErrorReasonText, NEW.OriginalFileName, NEW.FinalFileName, NEW.CreatedBySerNum,\n				NEW.CreatedTimeStamp, NEW.TransferStatus, NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'UPDATE');\n\n\n	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR\n	FROM NotificationControl ntc, Patient pt\n	WHERE ntc.NotificationType = 'UpdDocument'\n		AND NEW.ReadStatus = 0\n		AND pt.PatientSerNum = NEW.PatientSerNum\n		AND pt.AccessLevel = 3;\nEND;\n""",  # noqa: WPS322, E501
)

TABLES_TO_UPDATE: Final = (
    {
        'trigger_name': 'announcement_read_notification_update_trigger',
        'table_name': 'Announcement',
        'ser_num_column': 'AnnouncementSerNum',
        'read_by_column': 'ReadBy',
    },
    {
        'trigger_name': 'appointment_read_notification_update_trigger',
        'table_name': 'Appointment',
        'ser_num_column': 'AppointmentSerNum',
        'read_by_column': 'ReadBy',
    },
    {
        'trigger_name': 'document_read_notification_update_trigger',
        'table_name': 'Document',
        'ser_num_column': 'DocumentSerNum',
        'read_by_column': 'ReadBy',
    },
    {
        'trigger_name': 'educationalmaterial_read_notification_update_trigger',
        'table_name': 'EducationalMaterial',
        'ser_num_column': 'EducationalMaterialSerNum',
        'read_by_column': 'ReadBy',
    },
    {
        'trigger_name': 'questionnaire_read_notification_update_trigger',
        'table_name': 'Questionnaire',
        'ser_num_column': 'QuestionnaireSerNum',
        'read_by_column': 'SessionId',
    },
    {
        'trigger_name': 'txteammessage_read_notification_update_trigger',
        'table_name': 'TxTeamMessage',
        'ser_num_column': 'TxTeamMessageSerNum',
        'read_by_column': 'ReadBy',
    },
)

READ_CATEGORY_TRIGGER_TEMPLATE = """
AFTER UPDATE ON `{table_name}` FOR EACH ROW
BEGIN
    UPDATE Notification n
    SET n.ReadBy = NEW.{read_by_column}
    WHERE n.RefTableRowSerNum = NEW.{ser_num_column};
END;
"""


def upgrade() -> None:
    """
    Create triggers that mark `Notifications` as read once a corresponding category is updated.

    Also, update `document_insert_trigger` and `document_update_trigger` that create unnecessary `Notification` records.
    """
    op.drop_trigger(OLD_DOCUMENT_INSERT_TRIGGER)
    op.drop_trigger(OLD_DOCUMENT_UPDATE_TRIGGER)
    op.create_trigger(UPDATED_DOCUMENT_INSERT_TRIGGER)
    op.create_trigger(UPDATED_DOCUMENT_UPDATE_TRIGGER)

    for table in TABLES_TO_UPDATE:
        trigger = READ_CATEGORY_TRIGGER_TEMPLATE.format(
            table_name=table['table_name'],
            ser_num_column=table['ser_num_column'],
            read_by_column=table['read_by_column'],
        )
        op.create_trigger(ReplaceableObject(name=table['trigger_name'], sqltext=trigger))


def downgrade() -> None:
    """Delete triggers that mark `Notifications` as read once a corresponding category is updated.

    Also revert `document_insert_trigger` and `document_update_trigger` triggers.
    """
    for table in TABLES_TO_UPDATE:
        trigger = READ_CATEGORY_TRIGGER_TEMPLATE.format(
            table_name=table['table_name'],
            ser_num_column=table['ser_num_column'],
            read_by_column=table['read_by_column'],
        )
        op.drop_trigger(ReplaceableObject(name=table['trigger_name'], sqltext=trigger))

    op.drop_trigger(UPDATED_DOCUMENT_INSERT_TRIGGER)
    op.drop_trigger(UPDATED_DOCUMENT_UPDATE_TRIGGER)
    op.create_trigger(OLD_DOCUMENT_INSERT_TRIGGER)
    op.create_trigger(OLD_DOCUMENT_UPDATE_TRIGGER)
