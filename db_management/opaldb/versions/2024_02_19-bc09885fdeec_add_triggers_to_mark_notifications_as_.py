"""
Update `document_insert_trigger` and `document_update_trigger` that create unnecessary `Notification` records.

Revision ID: bc09885fdeec
Revises: 627bbdebf282
Create Date: 2024-02-19 21:52:59.876836

"""
from alembic import op

from db_management.opaldb.custom_operations import ReplaceableObject

# revision identifiers, used by Alembic.
revision = 'bc09885fdeec'
down_revision = '627bbdebf282'
branch_labels = None
depends_on = None

UPDATED_DOCUMENT_INSERT_TRIGGER = ReplaceableObject(
    name='`document_insert_trigger`',
    sql_text="""AFTER INSERT ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `CronLogSerNum`, `SessionId`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`,\n					`ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`,\n					`TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum,NULL,NEW.CronLogSerNum, NULL,NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.DocumentId,NEW.AliasExpressionSerNum,NEW.ApprovedBySerNum,NEW.ApprovedTimeStamp,\n				NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry,NEW.ErrorReasonText,NEW.OriginalFileName,NEW.FinalFileName, NEW.CreatedBySerNum, NEW.CreatedTimeStamp,\n				NEW.TransferStatus,NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'INSERT');\nEND;\n""",  # noqa: WPS322, E501
)

UPDATED_DOCUMENT_UPDATE_TRIGGER = ReplaceableObject(
    name='`document_update_trigger`',
    sql_text="""AFTER UPDATE ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`,\n									`ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`,\n									`CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum, NULL,NEW.SessionId, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.DocumentId, NEW.AliasExpressionSerNum, NEW.ApprovedBySerNum,\n				NEW.ApprovedTimeStamp, NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry, NEW.ErrorReasonText, NEW.OriginalFileName, NEW.FinalFileName, NEW.CreatedBySerNum,\n				NEW.CreatedTimeStamp, NEW.TransferStatus, NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'UPDATE');\nEND;\n""",  # noqa: WPS322, E501
)

OLD_DOCUMENT_INSERT_TRIGGER = ReplaceableObject(
    name='`document_insert_trigger`',
    sql_text="""AFTER INSERT ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `CronLogSerNum`, `SessionId`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`,\n					`ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`,\n					`TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum,NULL,NEW.CronLogSerNum, NULL,NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.DocumentId,NEW.AliasExpressionSerNum,NEW.ApprovedBySerNum,NEW.ApprovedTimeStamp,\n				NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry,NEW.ErrorReasonText,NEW.OriginalFileName,NEW.FinalFileName, NEW.CreatedBySerNum, NEW.CreatedTimeStamp,\n				NEW.TransferStatus,NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'INSERT');\n\n	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR\n	FROM NotificationControl ntc, Patient pt\n	WHERE ntc.NotificationType = 'Document'\n		AND pt.PatientSerNum = NEW.PatientSerNum\n		AND pt.AccessLevel = 3;\nEND;\n""",  # noqa: WPS322, E501
)

OLD_DOCUMENT_UPDATE_TRIGGER = ReplaceableObject(
    name='`document_update_trigger`',
    sql_text="""AFTER UPDATE ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`,\n									`ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`,\n									`CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum, NULL,NEW.SessionId, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.DocumentId, NEW.AliasExpressionSerNum, NEW.ApprovedBySerNum,\n				NEW.ApprovedTimeStamp, NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry, NEW.ErrorReasonText, NEW.OriginalFileName, NEW.FinalFileName, NEW.CreatedBySerNum,\n				NEW.CreatedTimeStamp, NEW.TransferStatus, NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'UPDATE');\n\n\n	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR\n	FROM NotificationControl ntc, Patient pt\n	WHERE ntc.NotificationType = 'UpdDocument'\n		AND NEW.ReadStatus = 0\n		AND pt.PatientSerNum = NEW.PatientSerNum\n		AND pt.AccessLevel = 3;\nEND;\n""",  # noqa: WPS322, E501
)


def upgrade() -> None:
    """Update `document_insert_trigger` and `document_update_trigger` triggers."""
    op.drop_trigger(OLD_DOCUMENT_INSERT_TRIGGER)
    op.drop_trigger(OLD_DOCUMENT_UPDATE_TRIGGER)
    op.create_trigger(UPDATED_DOCUMENT_INSERT_TRIGGER)
    op.create_trigger(UPDATED_DOCUMENT_UPDATE_TRIGGER)


def downgrade() -> None:
    """Revert `document_insert_trigger` and `document_update_trigger` triggers."""
    op.drop_trigger(UPDATED_DOCUMENT_INSERT_TRIGGER)
    op.drop_trigger(UPDATED_DOCUMENT_UPDATE_TRIGGER)
    op.create_trigger(OLD_DOCUMENT_INSERT_TRIGGER)
    op.create_trigger(OLD_DOCUMENT_UPDATE_TRIGGER)
