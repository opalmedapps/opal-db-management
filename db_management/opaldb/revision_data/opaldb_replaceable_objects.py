"""Lists of all ReplaceableObject instance definitions for OpalDB non-table entities."""
from typing import Final

from db_management.opaldb.custom_operations import ReplaceableObject

TRIGGER_LIST: Final = (
    ReplaceableObject(
        name='`alert_after_delete`',
        sql_text="""AFTER DELETE ON `alert` FOR EACH ROW BEGIN\n	INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (OLD.ID, OLD.contact, OLD.subject, OLD.body, OLD.trigger, NOW(), OLD.createdBy, OLD.lastUpdated, OLD.updatedBy, 'DELETE', OLD.active, OLD.deleted, OLD.deletedBy);\nEND;\n"""),

    ReplaceableObject(
        name='`alert_after_insert`',
        sql_text="""AFTER INSERT ON `alert` FOR EACH ROW BEGIN\nINSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (NEW.ID, NEW.contact, NEW.subject, NEW.body, NEW.trigger, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy, 'INSERT', NEW.active, NEW.deleted, NEW.deletedBy);\nEND;\n"""),

    ReplaceableObject(
        name='`alert_after_update`',
        sql_text="""AFTER UPDATE ON `alert` FOR EACH ROW BEGIN\n	IF NEW.lastUpdated != OLD.lastUpdated THEN\n		INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (NEW.ID, NEW.contact, NEW.subject, NEW.body, NEW.trigger, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy, 'UPDATE', NEW.active, NEW.deleted, NEW.deletedBy);\n	END IF;\nEND;\n"""),

    ReplaceableObject(
        name='`alias_delete_trigger`',
        sql_text="""AFTER DELETE ON `Alias` FOR EACH ROW BEGIN\n   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.AliasSerNum, OLD.AliasType, OLD.AliasUpdate, OLD.AliasName_FR, OLD.AliasName_EN, OLD.AliasDescription_FR, OLD.AliasDescription_EN, OLD.EducationalMaterialControlSerNum, OLD.SourceDatabaseSerNum, OLD.ColorTag, OLD.LastTransferred, NULL, NULL, 'DELETE', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`alias_expression_delete_trigger`',
        sql_text="""AFTER DELETE ON `AliasExpression` FOR EACH ROW BEGIN\n   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (OLD.AliasSerNum, OLD.ExpressionName, OLD.Description, OLD.LastTransferred, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`alias_expression_insert_trigger`',
        sql_text="""AFTER INSERT ON `AliasExpression` FOR EACH ROW BEGIN\n   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`alias_expression_update_trigger`',
        sql_text="""AFTER UPDATE ON `AliasExpression` FOR EACH ROW BEGIN\nif NEW.LastTransferred <=> OLD.LastTransferred THEN\n   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `ExpressionName`, Description, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());\nEND IF;\nEND;\n"""),

    ReplaceableObject(
        name='`alias_insert_trigger`',
        sql_text="""AFTER INSERT ON `Alias` FOR EACH ROW BEGIN\n   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.AliasSerNum, NEW.AliasType, NEW.AliasUpdate, NEW.AliasName_FR, NEW.AliasName_EN, NEW.AliasDescription_FR, NEW.AliasDescription_EN, NEW.EducationalMaterialControlSerNum, NEW.HospitalMapSerNum, NEW.SourceDatabaseSerNum, NEW.ColorTag, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`alias_update_trigger`',
        sql_text="""AFTER UPDATE ON `Alias` FOR EACH ROW BEGIN\nif NEW.LastTransferred <=> OLD.LastTransferred THEN\n   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.AliasSerNum, NEW.AliasType, NEW.AliasUpdate, NEW.AliasName_FR, NEW.AliasName_EN, NEW.AliasDescription_FR, NEW.AliasDescription_EN, NEW.EducationalMaterialControlSerNum, NEW.HospitalMapSerNum, NEW.SourceDatabaseSerNum, NEW.ColorTag, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());\nEND IF;\nEND;\n"""),

    ReplaceableObject(
        name='`announcement_delete_trigger`',
        sql_text="""AFTER DELETE ON `Announcement` FOR EACH ROW BEGIN\nINSERT INTO `AnnouncementMH`(`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.AnnouncementSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`announcement_insert_trigger`',
        sql_text="""AFTER INSERT ON `Announcement` FOR EACH ROW BEGIN\n	INSERT INTO `AnnouncementMH`(`AnnouncementSerNum`,`CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)\n		VALUES (NEW.AnnouncementSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');\n\n	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n		SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.AnnouncementSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR\n		FROM NotificationControl ntc\n		WHERE ntc.NotificationType = 'Announcement';\nEND;\n"""),

    ReplaceableObject(
        name='`announcement_update_trigger`',
        sql_text="""AFTER UPDATE ON `Announcement` FOR EACH ROW BEGIN\nINSERT INTO `AnnouncementMH`(`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.AnnouncementSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`appointment_delete_trigger`',
        sql_text="""AFTER DELETE ON `Appointment` FOR EACH ROW BEGIN\n INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (OLD.AppointmentSerNum,NULL,OLD.SessionId,OLD.AliasExpressionSerNum, OLD.CronLogSerNum, OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.AppointmentAriaSer,OLD.PrioritySerNum, OLD.DiagnosisSerNum, OLD.Status, OLD.State, OLD.ScheduledStartTime,OLD.ScheduledEndTime, OLD.ActualStartDate, OLD.ActualEndDate, OLD.Location, OLD.RoomLocation_EN, OLD.RoomLocation_FR, OLD.Checkin, OLD.DateAdded,OLD.ReadStatus,NOW(), 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`appointment_insert_trigger`',
        sql_text="""AFTER INSERT ON `Appointment` FOR EACH ROW BEGIN\nINSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`,`RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`, `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NULL,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum, NEW.AppointmentAriaSer, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'INSERT');\nEND;\n"""),

    ReplaceableObject(
        name='`appointment_update_trigger`',
        sql_text="""AFTER UPDATE ON `Appointment` FOR EACH ROW BEGIN\n INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NEW.SessionId,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.AppointmentAriaSer,NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_code_delete_trigger`',
        sql_text="""AFTER DELETE ON `DiagnosisCode` FOR EACH ROW BEGIN\n   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.DiagnosisTranslationSerNum, OLD.SourceUID, OLD.DiagnosisCode, OLD.Description, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_code_insert_trigger`',
        sql_text="""AFTER INSERT ON `DiagnosisCode` FOR EACH ROW BEGIN\n   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.SourceUID, NEW.DiagnosisCode, NEW.Description, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_code_update_trigger`',
        sql_text="""AFTER UPDATE ON `DiagnosisCode` FOR EACH ROW BEGIN\n   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.SourceUID, NEW.DiagnosisCode, NEW.Description, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_delete_trigger`',
        sql_text="""AFTER DELETE ON `Diagnosis` FOR EACH ROW BEGIN\n	INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,\n	`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,\n	`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)\n	VALUES (OLD.DiagnosisSerNum, OLD.PatientSerNum, OLD.SourceDatabaseSerNum,\n	OLD.DiagnosisAriaSer, OLD.DiagnosisCode, OLD.Description_EN, OLD.Description_FR,\n	OLD.Stage, OLD.StageCriteria, 'DELETE', NOW(), OLD.createdBy, OLD.lastUpdated,\n	OLD.updatedBy);\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_insert_trigger`',
        sql_text="""AFTER INSERT ON `Diagnosis` FOR EACH ROW BEGIN\nINSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,\n	`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,\n	`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)\n	VALUES (NEW.DiagnosisSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum,\n	NEW.DiagnosisAriaSer, NEW.DiagnosisCode, NEW.Description_EN, NEW.Description_FR,\n	NEW.Stage, NEW.StageCriteria, 'INSERT', NOW(), NEW.createdBy, NEW.lastUpdated,\n	NEW.updatedBy);\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_translation_delete_trigger`',
        sql_text="""AFTER DELETE ON `DiagnosisTranslation` FOR EACH ROW BEGIN\n   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.DiagnosisTranslationSerNum, OLD.EducationalMaterialControlSerNum, OLD.Name_EN, OLD.Name_FR, OLD.Description_EN, OLD.Description_FR, NULL, NULL, 'DELETE', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_translation_insert_trigger`',
        sql_text="""AFTER INSERT ON `DiagnosisTranslation` FOR EACH ROW BEGIN\n   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.EducationalMaterialControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_translation_update_trigger`',
        sql_text="""AFTER UPDATE ON `DiagnosisTranslation` FOR EACH ROW BEGIN\n   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.EducationalMaterialControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`diagnosis_update_trigger`',
        sql_text="""AFTER UPDATE ON `Diagnosis` FOR EACH ROW BEGIN\n	IF NEW.lastUpdated != OLD.lastUpdated THEN\n		INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,\n		`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,\n		`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)\n		VALUES (NEW.DiagnosisSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum,\n		NEW.DiagnosisAriaSer, NEW.DiagnosisCode, NEW.Description_EN, NEW.Description_FR,\n		NEW.Stage, NEW.StageCriteria, 'UPDATE', NOW(), NEW.createdBy, NEW.lastUpdated,\n		NEW.updatedBy);\n	END IF;\nEND;\n"""),

    ReplaceableObject(
        name='`doctor_delete_trigger`',
        sql_text="""AFTER DELETE ON `Doctor` FOR EACH ROW BEGIN\n INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSer, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (OLD.DoctorSerNum, NULL, OLD.ResourceSerNum, OLD.SourceDatabaseSerNum, OLD.DoctorAriaSer, OLD.FirstName, OLD.LastName, OLD.Role, OLD.Workplace, OLD.Email, OLD.Phone, OLD.Address,OLD.ProfileImage,NOW(), 'DELETE', OLD.BIO_EN, OLD.BIO_FR);\nEND;\n"""),

    ReplaceableObject(
        name='`doctor_insert_trigger`',
        sql_text="""AFTER INSERT ON `Doctor` FOR EACH ROW BEGIN\n INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSerNum, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (NEW.DoctorSerNum, NULL, NEW.ResourceSerNum, NEW.SourceDatabaseSerNum, NEW.DoctorAriaSer, NEW.FirstName, NEW.LastName, NEW.Role, NEW.Workplace, NEW.Email, NEW.Phone, NEW.Address,NEW.ProfileImage,NOW(), 'INSERT', NEW.BIO_EN, NEW.BIO_FR);\nEND;\n"""),

    ReplaceableObject(
        name='`doctor_update_trigger`',
        sql_text="""AFTER UPDATE ON `Doctor` FOR EACH ROW BEGIN\n INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSerNum, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (NEW.DoctorSerNum, NULL, NEW.ResourceSerNum, NEW.SourceDatabaseSerNum, NEW.DoctorAriaSer, NEW.FirstName, NEW.LastName, NEW.Role, NEW.Workplace, NEW.Email, NEW.Phone, NEW.Address,NEW.ProfileImage,NOW(), 'UPDATE', NEW.BIO_EN, NEW.BIO_FR);\nEND;\n"""),

    ReplaceableObject(
        name='`document_delete_trigger`',
        sql_text="""AFTER DELETE ON `Document` FOR EACH ROW BEGIN\nINSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`,`CronLogSerNum`,`PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n VALUES (OLD.DocumentSerNum,NULL,OLD.SessionId,OLD.CronLogSerNum,OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.DocumentId,OLD.AliasExpressionSerNum,OLD.ApprovedBySerNum,OLD.ApprovedTimeStamp, OLD.AuthoredBySerNum, OLD.DateOfService, OLD.Revised, OLD.ValidEntry,OLD.ErrorReasonText,OLD.OriginalFileName,OLD.FinalFileName, OLD.CreatedBySerNum, OLD.CreatedTimeStamp, OLD.TransferStatus,OLD.TransferLog, OLD.ReadStatus, OLD.DateAdded, NOW(), 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`document_insert_trigger`',
        sql_text="""AFTER INSERT ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `CronLogSerNum`, `SessionId`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`,\n					`ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`,\n					`TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum,NULL,NEW.CronLogSerNum, NULL,NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.DocumentId,NEW.AliasExpressionSerNum,NEW.ApprovedBySerNum,NEW.ApprovedTimeStamp,\n				NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry,NEW.ErrorReasonText,NEW.OriginalFileName,NEW.FinalFileName, NEW.CreatedBySerNum, NEW.CreatedTimeStamp,\n				NEW.TransferStatus,NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'INSERT');\n\n	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR\n	FROM NotificationControl ntc, Patient pt\n	WHERE ntc.NotificationType = 'Document'\n		AND pt.PatientSerNum = NEW.PatientSerNum\n		AND pt.AccessLevel = 3;\nEND;\n"""),

    ReplaceableObject(
        name='`document_update_trigger`',
        sql_text="""AFTER UPDATE ON `Document` FOR EACH ROW BEGIN\n	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`,\n									`ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`,\n									`CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)\n	VALUES (NEW.DocumentSerNum, NULL,NEW.SessionId, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.DocumentId, NEW.AliasExpressionSerNum, NEW.ApprovedBySerNum,\n				NEW.ApprovedTimeStamp, NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry, NEW.ErrorReasonText, NEW.OriginalFileName, NEW.FinalFileName, NEW.CreatedBySerNum,\n				NEW.CreatedTimeStamp, NEW.TransferStatus, NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'UPDATE');\n\n\n	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR\n	FROM NotificationControl ntc, Patient pt\n	WHERE ntc.NotificationType = 'UpdDocument'\n		AND NEW.ReadStatus = 0\n		AND pt.PatientSerNum = NEW.PatientSerNum\n		AND pt.AccessLevel = 3;\nEND;\n"""),

    ReplaceableObject(
        name='`educationalmaterial_delete_trigger`',
        sql_text="""AFTER DELETE ON `EducationalMaterial` FOR EACH ROW BEGIN\nINSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.EducationalMaterialSerNum, OLD.CronLogSerNum, OLD.EducationalMaterialControlSerNum, OLD.PatientSerNum, NOW(), OLD.ReadStatus, 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`educationalmaterial_insert_trigger`',
        sql_text="""AFTER INSERT ON `EducationalMaterial` FOR EACH ROW BEGIN\n	INSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)\n	VALUES (NEW.EducationalMaterialSerNum, NEW.CronLogSerNum, NEW.EducationalMaterialControlSerNum, NEW.PatientSerNum, NOW(), NEW.ReadStatus, 'INSERT');\n\n	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT  NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.EducationalMaterialSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.EducationalMaterialSerNum, 'EDUCATIONAL', 'EN') EN, getRefTableRowTitle(NEW.EducationalMaterialSerNum, 'EDUCATIONAL', 'FR') FR\n	FROM NotificationControl ntc\n	WHERE ntc.NotificationType = 'EducationalMaterial';\nEND;\n"""),

    ReplaceableObject(
        name='`educationalmaterial_update_trigger`',
        sql_text="""AFTER UPDATE ON `EducationalMaterial` FOR EACH ROW BEGIN\nINSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.EducationalMaterialSerNum, NEW.CronLogSerNum, NEW.EducationalMaterialControlSerNum, NEW.PatientSerNum, NOW(), NEW.ReadStatus, 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`filter_delete_trigger`',
        sql_text="""AFTER DELETE ON `Filters` FOR EACH ROW BEGIN\n   INSERT INTO `FiltersMH`(`FilterSerNum`,`ControlTable`, `ControlTableSerNum`, `FilterType`, `FilterId`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.FilterSerNum, OLD.ControlTable, OLD.ControlTableSerNum, OLD.FilterType, OLD.FilterId, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`filter_insert_trigger`',
        sql_text="""AFTER INSERT ON `Filters` FOR EACH ROW BEGIN\n   INSERT INTO `FiltersMH`(`FilterSerNum`,`ControlTable`, `ControlTableSerNum`, `FilterType`, `FilterId`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.FilterSerNum, NEW.ControlTable, NEW.ControlTableSerNum, NEW.FilterType, NEW.FilterId, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());\nEND;\n"""),

    ReplaceableObject(
        name='`hospitalmap_delete_trigger`',
        sql_text="""AFTER DELETE ON `HospitalMap` FOR EACH ROW BEGIN\n   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.HospitalMapSerNum, OLD.MapUrl, OLD.MapURL_EN, OLD.MapURL_FR, OLD.QRMapAlias, OLD.QRImageFileName, OLD.MapName_EN, OLD.MapDescription_EN, OLD.MapName_FR, OLD.MapDescription_FR, NOW(), OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`hospitalmap_insert_trigger`',
        sql_text="""AFTER INSERT ON `HospitalMap` FOR EACH ROW BEGIN\n   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR, NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');\nEND;\n"""),

    ReplaceableObject(
        name='`hospitalmap_update_trigger`',
        sql_text="""AFTER UPDATE ON `HospitalMap` FOR EACH ROW BEGIN\n   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR,  NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`legacy_questionnaire_delete_trigger`',
        sql_text="""AFTER DELETE ON `Questionnaire` FOR EACH ROW BEGIN\nINSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `DateAdded`, ModificationAction) VALUES (OLD.QuestionnaireSerNum, OLD.CronLogSerNum, OLD.QuestionnaireControlSerNum, OLD.PatientSerNum, OLD.PatientQuestionnaireDBSerNum, OLD.CompletedFlag, OLD.CompletionDate, NOW(), 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`legacy_questionnaire_insert_trigger`',
        sql_text="""AFTER INSERT ON `Questionnaire` FOR EACH ROW BEGIN\n	INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`,\n			`DateAdded`, ModificationAction)\n	VALUES (NEW.QuestionnaireSerNum, NEW.CronLogSerNum, NEW.QuestionnaireControlSerNum, NEW.PatientSerNum, NEW.PatientQuestionnaireDBSerNum, NEW.CompletedFlag, NEW.CompletionDate,\n			NOW(), 'INSERT');\n\n\n	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.QuestionnaireSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'EN') EN, getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'FR') FR\n	FROM NotificationControl ntc\n	WHERE ntc.NotificationType = 'LegacyQuestionnaire';\nEND;\n"""),

    ReplaceableObject(
        name='`legacy_questionnaire_update_trigger`',
        sql_text="""AFTER UPDATE ON `Questionnaire` FOR EACH ROW BEGIN\nINSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `DateAdded`, ModificationAction) VALUES (NEW.QuestionnaireSerNum, NEW.CronLogSerNum, NEW.QuestionnaireControlSerNum, NEW.PatientSerNum, NEW.PatientQuestionnaireDBSerNum, NEW.CompletedFlag, NEW.CompletionDate, NOW(), 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`notification_control_delete_trigger`',
        sql_text="""AFTER DELETE ON `NotificationControl` FOR EACH ROW BEGIN\n   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.NotificationControlSerNum, OLD.Name_EN, OLD.Name_FR, OLD.Description_EN, OLD.Description_FR, OLD.NotificationTypeSerNum, OLD.DateAdded, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`notification_control_insert_trigger`',
        sql_text="""AFTER INSERT ON `NotificationControl` FOR EACH ROW BEGIN\n   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.NotificationControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.NotificationTypeSerNum, NEW.DateAdded, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');\nEND;\n"""),

    ReplaceableObject(
        name='`notification_control_update_trigger`',
        sql_text="""AFTER UPDATE ON `NotificationControl` FOR EACH ROW BEGIN\n   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.NotificationControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.NotificationTypeSerNum, NEW.DateAdded, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`notification_delete_trigger`',
        sql_text="""AFTER DELETE ON `Notification` FOR EACH ROW BEGIN\n	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	VALUES (OLD.NotificationSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.NotificationControlSerNum, OLD.RefTableRowSerNum, OLD.ReadStatus, NOW(), 'DELETE', OLD.RefTableRowTitle_EN, OLD.RefTableRowTitle_FR);\nEND;\n"""),

    ReplaceableObject(
        name='`notification_insert_trigger`',
        sql_text="""AFTER INSERT ON `Notification` FOR EACH ROW BEGIN\n	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	VALUES (NEW.NotificationSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.NotificationControlSerNum, NEW.RefTableRowSerNum, NEW.ReadStatus, NOW(), 'INSERT', NEW.RefTableRowTitle_EN, NEW.RefTableRowTitle_FR);\nEND;\n"""),

    ReplaceableObject(
        name='`notification_update_trigger`',
        sql_text="""AFTER UPDATE ON `Notification` FOR EACH ROW BEGIN\n	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	VALUES (NEW.NotificationSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.NotificationControlSerNum, NEW.RefTableRowSerNum, NEW.ReadStatus, NOW(), 'UPDATE', NEW.RefTableRowTitle_EN, NEW.RefTableRowTitle_FR);\nEND;\n"""),

    ReplaceableObject(
        name='`PatientLocation_after_insert`',
        sql_text="""AFTER INSERT ON `PatientLocation` FOR EACH ROW BEGIN\n	if (new.CheckedInFlag = 1) then\n		update Appointment set Checkin = 1 where AppointmentSerNum = new.AppointmentSerNum;\n	end if;\nEND;\n"""),

    ReplaceableObject(
        name='`patient_delete_trigger`',
        sql_text="""AFTER DELETE ON `Patient` FOR EACH ROW BEGIN\nINSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (OLD.PatientSerNum,NULL,OLD.SessionId,OLD.PatientAriaSer,OLD.PatientId, OLD.PatientId2, OLD.FirstName,OLD.LastName,OLD.Alias, OLD.Sex, OLD.DateOfBirth, OLD.Age, OLD.TelNum,OLD.EnableSMS,OLD.Email,OLD.Language,OLD.SSN, OLD.AccessLevel,OLD.RegistrationDate, OLD.ConsentFormExpirationDate, OLD.BlockedStatus, OLD.StatusReasonTxt, OLD.DeathDate, NOW(), 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`patient_insert_trigger`',
        sql_text="""AFTER INSERT ON `Patient` FOR EACH ROW BEGIN\nINSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`,`RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.PatientSerNum,NULL,NULL,NEW.PatientAriaSer,NEW.PatientId, NEW.PatientId2, NEW.FirstName,NEW.LastName,NEW.Alias, NEW.Sex, NEW.DateOfBirth, NEW.Age, NEW.TelNum,NEW.EnableSMS,NEW.Email,NEW.Language,NEW.SSN, NEW.AccessLevel,NEW.RegistrationDate, NEW.ConsentFormExpirationDate, NEW.BlockedStatus, NEW.StatusReasonTxt, NEW.DeathDate, NOW(), 'INSERT');\nEND;\n"""),

    ReplaceableObject(
        name='`patient_update_trigger`',
        sql_text="""AFTER UPDATE ON `Patient` FOR EACH ROW BEGIN\nINSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`,`RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.PatientSerNum,NULL,NEW.SessionId,NEW.PatientAriaSer,NEW.PatientId, NEW.PatientId2, NEW.FirstName,NEW.LastName,NEW.Alias, NEW.Sex, NEW.DateOfBirth, NEW.Age, NEW.TelNum,NEW.EnableSMS,NEW.Email,NEW.Language,NEW.SSN, NEW.AccessLevel, NEW.RegistrationDate, NEW.ConsentFormExpirationDate, NEW.BlockedStatus, NEW.StatusReasonTxt, NEW.DeathDate, NOW(), 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`post_control_delete_trigger`',
        sql_text="""AFTER DELETE ON `PostControl` FOR EACH ROW BEGIN\n   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.PostControlSerNum, OLD.PostType, OLD.PublishFlag, OLD.PostName_FR, OLD.PostName_EN, OLD.Body_FR, OLD.Body_EN, OLD.PublishDate, OLD.Disabled, NOW(), OLD.LastPublished, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`post_control_insert_trigger`',
        sql_text="""AFTER INSERT ON `PostControl` FOR EACH ROW BEGIN\n   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.PostControlSerNum, NEW.PostType, NEW.PublishFlag, NEW.PostName_FR, NEW.PostName_EN, NEW.Body_FR, NEW.Body_EN, NEW.PublishDate, NEW.Disabled, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');\nEND;\n"""),

    ReplaceableObject(
        name='`post_control_update_trigger`',
        sql_text="""AFTER UPDATE ON `PostControl` FOR EACH ROW BEGIN\nif NEW.LastPublished <=> OLD.LastPublished THEN\n   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.PostControlSerNum, NEW.PostType, NEW.PublishFlag, NEW.PostName_FR, NEW.PostName_EN, NEW.Body_FR, NEW.Body_EN, NEW.PublishDate, NEW.Disabled, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');\nEND IF;\nEND;\n"""),

    ReplaceableObject(
        name='`questionnaire_control_delete_trigger`',
        sql_text="""AFTER DELETE ON `QuestionnaireControl` FOR EACH ROW BEGIN\n   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (OLD.QuestionnaireControlSerNum, OLD.QuestionnaireDBSerNum, OLD.QuestionnaireName_EN, OLD.QuestionnaireName_FR, OLD.Intro_EN, OLD.Intro_FR, OLD.PublishFlag,NOW(), OLD.LastUpdatedBy, OLD.LastPublished, OLD.SessionId, 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`questionnaire_control_insert_trigger`',
        sql_text="""AFTER INSERT ON `QuestionnaireControl` FOR EACH ROW BEGIN\n   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (NEW.QuestionnaireControlSerNum, NEW.QuestionnaireDBSerNum, NEW.QuestionnaireName_EN, NEW.QuestionnaireName_FR, NEW.Intro_EN, NEW.Intro_FR, NEW.PublishFlag,NOW(), NEW.LastUpdatedBy, NEW.LastPublished, NEW.SessionId, 'INSERT');\nEND;\n"""),

    ReplaceableObject(
        name='`questionnaire_control_update_trigger`',
        sql_text="""AFTER UPDATE ON `QuestionnaireControl` FOR EACH ROW BEGIN\nif NEW.LastPublished <=> OLD.LastPublished THEN\n   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (NEW.QuestionnaireControlSerNum, NEW.QuestionnaireDBSerNum, NEW.QuestionnaireName_EN, NEW.QuestionnaireName_FR, NEW.Intro_EN, NEW.Intro_FR, NEW.PublishFlag,NOW(), NEW.LastUpdatedBy, NEW.LastPublished, NEW.SessionId, 'UPDATE');\nEND IF;\nEND;\n"""),

    ReplaceableObject(
        name='`txteammessage_delete_trigger`',
        sql_text="""AFTER DELETE ON `TxTeamMessage` FOR EACH ROW BEGIN\nINSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  VALUES (OLD.TxTeamMessageSerNum,OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`txteammessage_insert_trigger`',
        sql_text="""AFTER INSERT ON `TxTeamMessage` FOR EACH ROW BEGIN\n	INSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)\n	VALUES (NEW.TxTeamMessageSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');\n\n	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)\n	SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.TxTeamMessageSerNum, NOW(), 0,\n				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR\n	FROM NotificationControl ntc\n	WHERE ntc.NotificationType = 'TxTeamMessage';\nEND;\n"""),

    ReplaceableObject(
        name='`txteammessage_update_trigger`',
        sql_text="""AFTER UPDATE ON `TxTeamMessage` FOR EACH ROW BEGIN\nINSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  VALUES (NEW.TxTeamMessageSerNum,NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');\nEND;\n"""),

    ReplaceableObject(
        name='`users_delete_trigger`',
        sql_text="""AFTER DELETE ON `Users` FOR EACH ROW BEGIN\nINSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`)\nVALUES (OLD.UserSerNum, NULL,OLD.SessionId,OLD.UserType, OLD.UserTypeSerNum, OLD.Username,OLD.Password, NOW(), 'DELETE');\nEND;\n"""),

    ReplaceableObject(
        name='`users_insert_trigger`',
        sql_text="""AFTER INSERT ON `Users` FOR EACH ROW BEGIN\nINSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`)\nVALUES (NEW.UserSerNum, NULL,NEW.SessionId,NEW.UserType,  NEW.UserTypeSerNum, NEW.Username,NEW.Password, NOW(), 'INSERT');\nEND;\n"""),

    ReplaceableObject(
        name='`users_update_trigger`',
        sql_text="""AFTER UPDATE ON `Users` FOR EACH ROW BEGIN\nINSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`)\nVALUES (NEW.UserSerNum, NULL,NEW.SessionId,NEW.UserType, NEW.UserTypeSerNum, NEW.Username,NEW.Password, NOW(), 'UPDATE');\nEND;\n"""),
)
