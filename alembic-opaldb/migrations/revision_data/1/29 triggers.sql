CREATE TRIGGER `alert_after_delete` AFTER DELETE ON `alert` FOR EACH ROW BEGIN
	INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (OLD.ID, OLD.contact, OLD.subject, OLD.body, OLD.trigger, NOW(), OLD.createdBy, OLD.lastUpdated, OLD.updatedBy, 'DELETE', OLD.active, OLD.deleted, OLD.deletedBy);
END;

CREATE TRIGGER `alert_after_insert` AFTER INSERT ON `alert` FOR EACH ROW BEGIN
INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (NEW.ID, NEW.contact, NEW.subject, NEW.body, NEW.trigger, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy, 'INSERT', NEW.active, NEW.deleted, NEW.deletedBy);
END;

CREATE TRIGGER `alert_after_update` AFTER UPDATE ON `alert` FOR EACH ROW BEGIN
	IF NEW.lastUpdated != OLD.lastUpdated THEN
		INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (NEW.ID, NEW.contact, NEW.subject, NEW.body, NEW.trigger, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy, 'UPDATE', NEW.active, NEW.deleted, NEW.deletedBy);
	END IF;
END;

CREATE TRIGGER `alias_delete_trigger` AFTER DELETE ON `Alias` FOR EACH ROW BEGIN
   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.AliasSerNum, OLD.AliasType, OLD.AliasUpdate, OLD.AliasName_FR, OLD.AliasName_EN, OLD.AliasDescription_FR, OLD.AliasDescription_EN, OLD.EducationalMaterialControlSerNum, OLD.SourceDatabaseSerNum, OLD.ColorTag, OLD.LastTransferred, NULL, NULL, 'DELETE', NOW());
END;

CREATE TRIGGER `alias_expression_delete_trigger` AFTER DELETE ON `AliasExpression` FOR EACH ROW BEGIN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (OLD.AliasSerNum, OLD.ExpressionName, OLD.Description, OLD.LastTransferred, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END;

CREATE TRIGGER `alias_expression_insert_trigger` AFTER INSERT ON `AliasExpression` FOR EACH ROW BEGIN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END;

CREATE TRIGGER `alias_expression_update_trigger` AFTER UPDATE ON `AliasExpression` FOR EACH ROW BEGIN
if NEW.LastTransferred <=> OLD.LastTransferred THEN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `ExpressionName`, Description, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END IF;
END;

CREATE TRIGGER `alias_insert_trigger` AFTER INSERT ON `Alias` FOR EACH ROW BEGIN
   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.AliasSerNum, NEW.AliasType, NEW.AliasUpdate, NEW.AliasName_FR, NEW.AliasName_EN, NEW.AliasDescription_FR, NEW.AliasDescription_EN, NEW.EducationalMaterialControlSerNum, NEW.HospitalMapSerNum, NEW.SourceDatabaseSerNum, NEW.ColorTag, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END;

CREATE TRIGGER `alias_update_trigger` AFTER UPDATE ON `Alias` FOR EACH ROW BEGIN
if NEW.LastTransferred <=> OLD.LastTransferred THEN
   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.AliasSerNum, NEW.AliasType, NEW.AliasUpdate, NEW.AliasName_FR, NEW.AliasName_EN, NEW.AliasDescription_FR, NEW.AliasDescription_EN, NEW.EducationalMaterialControlSerNum, NEW.HospitalMapSerNum, NEW.SourceDatabaseSerNum, NEW.ColorTag, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END IF;
END;

CREATE TRIGGER `announcement_delete_trigger` AFTER DELETE ON `Announcement` FOR EACH ROW BEGIN
INSERT INTO `AnnouncementMH`(`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.AnnouncementSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END;

CREATE TRIGGER `announcement_insert_trigger` AFTER INSERT ON `Announcement` FOR EACH ROW BEGIN
	INSERT INTO `AnnouncementMH`(`AnnouncementSerNum`,`CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)
		VALUES (NEW.AnnouncementSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');

	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
		SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.AnnouncementSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR
		FROM NotificationControl ntc
		WHERE ntc.NotificationType = 'Announcement';
END;

CREATE TRIGGER `announcement_update_trigger` AFTER UPDATE ON `Announcement` FOR EACH ROW BEGIN
INSERT INTO `AnnouncementMH`(`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.AnnouncementSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END;

CREATE TRIGGER `appointment_delete_trigger` AFTER DELETE ON `Appointment` FOR EACH ROW BEGIN
 INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (OLD.AppointmentSerNum,NULL,OLD.SessionId,OLD.AliasExpressionSerNum, OLD.CronLogSerNum, OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.AppointmentAriaSer,OLD.PrioritySerNum, OLD.DiagnosisSerNum, OLD.Status, OLD.State, OLD.ScheduledStartTime,OLD.ScheduledEndTime, OLD.ActualStartDate, OLD.ActualEndDate, OLD.Location, OLD.RoomLocation_EN, OLD.RoomLocation_FR, OLD.Checkin, OLD.DateAdded,OLD.ReadStatus,NOW(), 'DELETE');
END;

CREATE TRIGGER `appointment_insert_trigger` AFTER INSERT ON `Appointment` FOR EACH ROW BEGIN
INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`,`RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`, `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NULL,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum, NEW.AppointmentAriaSer, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'INSERT');
END;

CREATE TRIGGER `appointment_update_trigger` AFTER UPDATE ON `Appointment` FOR EACH ROW BEGIN
 INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NEW.SessionId,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.AppointmentAriaSer,NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'UPDATE');
END;

CREATE TRIGGER `delete_task_trigger` AFTER DELETE ON `Task` FOR EACH ROW BEGIN
INSERT INTO `TaskMH`(`TaskSerNum`, `CronLogSerNum`, `PatientSerNum`, `AliasExpressionSerNum`, `SourceDatabaseSerNum`, `TaskAriaSer`, `Status`, `State`, `PrioritySerNum`, `DiagnosisSerNum`, `DueDateTime`, `CreationDate`, `CompletionDate`, `DateAdded`, `LastUpdated`, `ModificationAction`) VALUES (OLD.TaskSerNum, OLD.CronLogSerNum, OLD.PatientSerNum,OLD.AliasExpressionSerNum,OLD.SourceDatabaseSerNum,OLD.TaskAriaSer, OLD.Status, OLD.State, OLD.PrioritySerNum, OLD.DiagnosisSerNum, OLD.DueDateTime, OLD.CreationDate, OLD.CompletionDate, OLD.DateAdded,NULL, 'DELETE');
END;

CREATE TRIGGER `diagnosis_code_delete_trigger` AFTER DELETE ON `DiagnosisCode` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.DiagnosisTranslationSerNum, OLD.SourceUID, OLD.DiagnosisCode, OLD.Description, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END;

CREATE TRIGGER `diagnosis_code_insert_trigger` AFTER INSERT ON `DiagnosisCode` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.SourceUID, NEW.DiagnosisCode, NEW.Description, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END;

CREATE TRIGGER `diagnosis_code_update_trigger` AFTER UPDATE ON `DiagnosisCode` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.SourceUID, NEW.DiagnosisCode, NEW.Description, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END;

CREATE TRIGGER `diagnosis_delete_trigger` AFTER DELETE ON `Diagnosis` FOR EACH ROW BEGIN
	INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,
	`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,
	`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)
	VALUES (OLD.DiagnosisSerNum, OLD.PatientSerNum, OLD.SourceDatabaseSerNum,
	OLD.DiagnosisAriaSer, OLD.DiagnosisCode, OLD.Description_EN, OLD.Description_FR,
	OLD.Stage, OLD.StageCriteria, 'DELETE', NOW(), OLD.createdBy, OLD.lastUpdated,
	OLD.updatedBy);
END;

CREATE TRIGGER `diagnosis_insert_trigger` AFTER INSERT ON `Diagnosis` FOR EACH ROW BEGIN
INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,
	`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,
	`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)
	VALUES (NEW.DiagnosisSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum,
	NEW.DiagnosisAriaSer, NEW.DiagnosisCode, NEW.Description_EN, NEW.Description_FR,
	NEW.Stage, NEW.StageCriteria, 'INSERT', NOW(), NEW.createdBy, NEW.lastUpdated,
	NEW.updatedBy);
END;

CREATE TRIGGER `diagnosis_translation_delete_trigger` AFTER DELETE ON `DiagnosisTranslation` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.DiagnosisTranslationSerNum, OLD.EducationalMaterialControlSerNum, OLD.Name_EN, OLD.Name_FR, OLD.Description_EN, OLD.Description_FR, NULL, NULL, 'DELETE', NOW());
END;

CREATE TRIGGER `diagnosis_translation_insert_trigger` AFTER INSERT ON `DiagnosisTranslation` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.EducationalMaterialControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END;

CREATE TRIGGER `diagnosis_translation_update_trigger` AFTER UPDATE ON `DiagnosisTranslation` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.EducationalMaterialControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END;

CREATE TRIGGER `diagnosis_update_trigger` AFTER UPDATE ON `Diagnosis` FOR EACH ROW BEGIN
	IF NEW.lastUpdated != OLD.lastUpdated THEN
		INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,
		`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,
		`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)
		VALUES (NEW.DiagnosisSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum,
		NEW.DiagnosisAriaSer, NEW.DiagnosisCode, NEW.Description_EN, NEW.Description_FR,
		NEW.Stage, NEW.StageCriteria, 'UPDATE', NOW(), NEW.createdBy, NEW.lastUpdated,
		NEW.updatedBy);
	END IF;
END;

CREATE TRIGGER `doctor_delete_trigger` AFTER DELETE ON `Doctor` FOR EACH ROW BEGIN
 INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSer, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (OLD.DoctorSerNum, NULL, OLD.ResourceSerNum, OLD.SourceDatabaseSerNum, OLD.DoctorAriaSer, OLD.FirstName, OLD.LastName, OLD.Role, OLD.Workplace, OLD.Email, OLD.Phone, OLD.Address,OLD.ProfileImage,NOW(), 'DELETE', OLD.BIO_EN, OLD.BIO_FR);
END;

CREATE TRIGGER `doctor_insert_trigger` AFTER INSERT ON `Doctor` FOR EACH ROW BEGIN
 INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSerNum, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (NEW.DoctorSerNum, NULL, NEW.ResourceSerNum, NEW.SourceDatabaseSerNum, NEW.DoctorAriaSer, NEW.FirstName, NEW.LastName, NEW.Role, NEW.Workplace, NEW.Email, NEW.Phone, NEW.Address,NEW.ProfileImage,NOW(), 'INSERT', NEW.BIO_EN, NEW.BIO_FR);
END;

CREATE TRIGGER `doctor_update_trigger` AFTER UPDATE ON `Doctor` FOR EACH ROW BEGIN
 INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSerNum, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (NEW.DoctorSerNum, NULL, NEW.ResourceSerNum, NEW.SourceDatabaseSerNum, NEW.DoctorAriaSer, NEW.FirstName, NEW.LastName, NEW.Role, NEW.Workplace, NEW.Email, NEW.Phone, NEW.Address,NEW.ProfileImage,NOW(), 'UPDATE', NEW.BIO_EN, NEW.BIO_FR);
END;

CREATE TRIGGER `document_delete_trigger` AFTER DELETE ON `Document` FOR EACH ROW BEGIN
INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`,`CronLogSerNum`,`PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)
 VALUES (OLD.DocumentSerNum,NULL,OLD.SessionId,OLD.CronLogSerNum,OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.DocumentId,OLD.AliasExpressionSerNum,OLD.ApprovedBySerNum,OLD.ApprovedTimeStamp, OLD.AuthoredBySerNum, OLD.DateOfService, OLD.Revised, OLD.ValidEntry,OLD.ErrorReasonText,OLD.OriginalFileName,OLD.FinalFileName, OLD.CreatedBySerNum, OLD.CreatedTimeStamp, OLD.TransferStatus,OLD.TransferLog, OLD.ReadStatus, OLD.DateAdded, NOW(), 'DELETE');
END;

CREATE TRIGGER `document_insert_trigger` AFTER INSERT ON `Document` FOR EACH ROW BEGIN
	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `CronLogSerNum`, `SessionId`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, 
					`ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, 
					`TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`) 
	VALUES (NEW.DocumentSerNum,NULL,NEW.CronLogSerNum, NULL,NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.DocumentId,NEW.AliasExpressionSerNum,NEW.ApprovedBySerNum,NEW.ApprovedTimeStamp, 
				NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry,NEW.ErrorReasonText,NEW.OriginalFileName,NEW.FinalFileName, NEW.CreatedBySerNum, NEW.CreatedTimeStamp, 
				NEW.TransferStatus,NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'INSERT');
				
	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0, 
				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR
	FROM NotificationControl ntc, Patient pt 
	WHERE ntc.NotificationType = 'Document' 
		AND pt.PatientSerNum = NEW.PatientSerNum 
		AND pt.AccessLevel = 3;
END;

CREATE TRIGGER `document_update_trigger` AFTER UPDATE ON `Document` FOR EACH ROW BEGIN
	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, 
									`ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, 
									`CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)
	VALUES (NEW.DocumentSerNum, NULL,NEW.SessionId, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.DocumentId, NEW.AliasExpressionSerNum, NEW.ApprovedBySerNum,
				NEW.ApprovedTimeStamp, NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry, NEW.ErrorReasonText, NEW.OriginalFileName, NEW.FinalFileName, NEW.CreatedBySerNum, 
				NEW.CreatedTimeStamp, NEW.TransferStatus, NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'UPDATE');
				
				
	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR
	FROM NotificationControl ntc, Patient pt 
	WHERE ntc.NotificationType = 'UpdDocument' 
		AND NEW.ReadStatus = 0
		AND pt.PatientSerNum = NEW.PatientSerNum
		AND pt.AccessLevel = 3;
END;

CREATE TRIGGER `educationalmaterial_delete_trigger` AFTER DELETE ON `EducationalMaterial` FOR EACH ROW BEGIN
INSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.EducationalMaterialSerNum, OLD.CronLogSerNum, OLD.EducationalMaterialControlSerNum, OLD.PatientSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END;

CREATE TRIGGER `educationalmaterial_insert_trigger` AFTER INSERT ON `EducationalMaterial` FOR EACH ROW BEGIN
	INSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) 
	VALUES (NEW.EducationalMaterialSerNum, NEW.CronLogSerNum, NEW.EducationalMaterialControlSerNum, NEW.PatientSerNum, NOW(), NEW.ReadStatus, 'INSERT');
	
	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT  NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.EducationalMaterialSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.EducationalMaterialSerNum, 'EDUCATIONAL', 'EN') EN, getRefTableRowTitle(NEW.EducationalMaterialSerNum, 'EDUCATIONAL', 'FR') FR
	FROM NotificationControl ntc 
	WHERE ntc.NotificationType = 'EducationalMaterial';
END;

CREATE TRIGGER `educationalmaterial_update_trigger` AFTER UPDATE ON `EducationalMaterial` FOR EACH ROW BEGIN
INSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.EducationalMaterialSerNum, NEW.CronLogSerNum, NEW.EducationalMaterialControlSerNum, NEW.PatientSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END;

CREATE TRIGGER `email_delete_trigger` AFTER DELETE ON `EmailLog` FOR EACH ROW BEGIN
INSERT INTO `EmailLogMH`(`EmailLogSerNum`, `CronLogSerNum`, `PatientSerNum`, `EmailControlSerNum`, `Status`, `DateAdded`, `ModificationAction`) VALUES (OLD.EmailLogSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.EmailControlSerNum, OLD.Status, NOW(), 'DELETE');
END;

CREATE TRIGGER `email_insert_trigger` AFTER INSERT ON `EmailLog` FOR EACH ROW BEGIN
INSERT INTO `EmailLogMH`(`EmailLogSerNum`, `CronLogSerNum`, `PatientSerNum`, `EmailControlSerNum`, `Status`, `DateAdded`, `ModificationAction`) VALUES (NEW.EmailLogSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.EmailControlSerNum, NEW.Status, NOW(), 'INSERT');
END;

CREATE TRIGGER `email_update_trigger` AFTER UPDATE ON `EmailLog` FOR EACH ROW BEGIN
INSERT INTO `EmailLogMH`(`EmailLogSerNum`, `CronLogSerNum`, `PatientSerNum`, `EmailControlSerNum`, `Status`, `DateAdded`, `ModificationAction`) VALUES (NEW.EmailLogSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.EmailControlSerNum, NEW.Status, NOW(), 'UPDATE');
END;

CREATE TRIGGER `filter_delete_trigger` AFTER DELETE ON `Filters` FOR EACH ROW BEGIN
   INSERT INTO `FiltersMH`(`FilterSerNum`,`ControlTable`, `ControlTableSerNum`, `FilterType`, `FilterId`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.FilterSerNum, OLD.ControlTable, OLD.ControlTableSerNum, OLD.FilterType, OLD.FilterId, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END;

CREATE TRIGGER `filter_insert_trigger` AFTER INSERT ON `Filters` FOR EACH ROW BEGIN
   INSERT INTO `FiltersMH`(`FilterSerNum`,`ControlTable`, `ControlTableSerNum`, `FilterType`, `FilterId`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.FilterSerNum, NEW.ControlTable, NEW.ControlTableSerNum, NEW.FilterType, NEW.FilterId, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END;

CREATE TRIGGER `hospitalmap_delete_trigger` AFTER DELETE ON `HospitalMap` FOR EACH ROW BEGIN
   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.HospitalMapSerNum, OLD.MapUrl, OLD.MapURL_EN, OLD.MapURL_FR, OLD.QRMapAlias, OLD.QRImageFileName, OLD.MapName_EN, OLD.MapDescription_EN, OLD.MapName_FR, OLD.MapDescription_FR, NOW(), OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');
END;

CREATE TRIGGER `hospitalmap_insert_trigger` AFTER INSERT ON `HospitalMap` FOR EACH ROW BEGIN
   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR, NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');
END;

CREATE TRIGGER `hospitalmap_update_trigger` AFTER UPDATE ON `HospitalMap` FOR EACH ROW BEGIN
   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR,  NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');
END;

CREATE TRIGGER `insert_task_trigger` AFTER INSERT ON `Task` FOR EACH ROW BEGIN
INSERT INTO `TaskMH`(`TaskSerNum`,`CronLogSerNum`, `PatientSerNum`, `AliasExpressionSerNum`, `PrioritySerNum`, `DiagnosisSerNum`, `SourceDatabaseSerNum`, `TaskAriaSer`, `Status` , `State`, `DueDateTime`, `DateAdded`, `CreationDate`, `CompletionDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.TaskSerNum,NEW.CronLogSerNum, NEW.PatientSerNum,NEW.AliasExpressionSerNum, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.SourceDatabaseSerNum, NEW.TaskAriaSer, NEW.Status, NEW.State, NEW.DueDateTime, NEW.CreationDate, NEW.CompletionDate, NEW.DateAdded,NULL, 'INSERT');
END;

CREATE TRIGGER `insert_test_result_notification_queue_trigger` AFTER INSERT ON `TestResultNotificationQueue`
     FOR EACH ROW BEGIN
    INSERT INTO `TestResultNotificationProcessingLog`
        (`TestResultNotificationQueueId`, `Status`, `InsertedRows`, `UpdatedRows`, `ProcessingDateTime`,`ProcessingAttemptNumber`,`ProcessingError`,  `ModificationAction`) VALUES (NEW.TestResultNotificationQueueId, NEW.Status, NEW.InsertedRows, NEW.UpdatedRows, NEW.LastProcessingDateTime, NEW.ProcessingAttemptNumber,NEW.LastProcessingError,'INSERT');
END;

CREATE TRIGGER `legacy_questionnaire_delete_trigger` AFTER DELETE ON `Questionnaire` FOR EACH ROW BEGIN
INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `DateAdded`, ModificationAction) VALUES (OLD.QuestionnaireSerNum, OLD.CronLogSerNum, OLD.QuestionnaireControlSerNum, OLD.PatientSerNum, OLD.PatientQuestionnaireDBSerNum, OLD.CompletedFlag, OLD.CompletionDate, NOW(), 'DELETE');
END;

CREATE TRIGGER `legacy_questionnaire_insert_trigger` AFTER INSERT ON `Questionnaire` FOR EACH ROW BEGIN
	INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, 
			`DateAdded`, ModificationAction) 
	VALUES (NEW.QuestionnaireSerNum, NEW.CronLogSerNum, NEW.QuestionnaireControlSerNum, NEW.PatientSerNum, NEW.PatientQuestionnaireDBSerNum, NEW.CompletedFlag, NEW.CompletionDate, 
			NOW(), 'INSERT');
			
			
	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.QuestionnaireSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'EN') EN, getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'FR') FR
	FROM NotificationControl ntc
	WHERE ntc.NotificationType = 'LegacyQuestionnaire';
END;

CREATE TRIGGER `legacy_questionnaire_update_trigger` AFTER UPDATE ON `Questionnaire` FOR EACH ROW BEGIN
INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `DateAdded`, ModificationAction) VALUES (NEW.QuestionnaireSerNum, NEW.CronLogSerNum, NEW.QuestionnaireControlSerNum, NEW.PatientSerNum, NEW.PatientQuestionnaireDBSerNum, NEW.CompletedFlag, NEW.CompletionDate, NOW(), 'UPDATE');
END;

CREATE TRIGGER `notification_control_delete_trigger` AFTER DELETE ON `NotificationControl` FOR EACH ROW BEGIN
   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.NotificationControlSerNum, OLD.Name_EN, OLD.Name_FR, OLD.Description_EN, OLD.Description_FR, OLD.NotificationTypeSerNum, OLD.DateAdded, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');
END;

CREATE TRIGGER `notification_control_insert_trigger` AFTER INSERT ON `NotificationControl` FOR EACH ROW BEGIN
   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.NotificationControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.NotificationTypeSerNum, NEW.DateAdded, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');
END;

CREATE TRIGGER `notification_control_update_trigger` AFTER UPDATE ON `NotificationControl` FOR EACH ROW BEGIN
   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.NotificationControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.NotificationTypeSerNum, NEW.DateAdded, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');
END;

CREATE TRIGGER `notification_delete_trigger` AFTER DELETE ON `Notification` FOR EACH ROW BEGIN
	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
	VALUES (OLD.NotificationSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.NotificationControlSerNum, OLD.RefTableRowSerNum, OLD.ReadStatus, NOW(), 'DELETE', OLD.RefTableRowTitle_EN, OLD.RefTableRowTitle_FR);
END;

CREATE TRIGGER `notification_insert_trigger` AFTER INSERT ON `Notification` FOR EACH ROW BEGIN
	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
	VALUES (NEW.NotificationSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.NotificationControlSerNum, NEW.RefTableRowSerNum, NEW.ReadStatus, NOW(), 'INSERT', NEW.RefTableRowTitle_EN, NEW.RefTableRowTitle_FR);
END;

CREATE TRIGGER `notification_update_trigger` AFTER UPDATE ON `Notification` FOR EACH ROW BEGIN
	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
	VALUES (NEW.NotificationSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.NotificationControlSerNum, NEW.RefTableRowSerNum, NEW.ReadStatus, NOW(), 'UPDATE', NEW.RefTableRowTitle_EN, NEW.RefTableRowTitle_FR);
END;

CREATE TRIGGER `PatientLocation_after_insert` AFTER INSERT ON `PatientLocation` FOR EACH ROW BEGIN
	if (new.CheckedInFlag = 1) then
		update Appointment set Checkin = 1 where AppointmentSerNum = new.AppointmentSerNum;
	end if;
END;

CREATE TRIGGER `patients_for_patients_delete_trigger` AFTER DELETE ON `PatientsForPatients` FOR EACH ROW BEGIN
INSERT INTO `PatientsForPatientsMH`(`PatientsForPatientsSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.PatientsForPatientsSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END;

CREATE TRIGGER `patients_for_patients_insert_trigger` AFTER INSERT ON `PatientsForPatients` FOR EACH ROW BEGIN
	INSERT INTO `PatientsForPatientsMH`(`PatientsForPatientsSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) 
	VALUES (NEW.PatientsForPatientsSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');
	
	
	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.PatientsForPatientsSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR
	FROM NotificationControl ntc 
	WHERE ntc.NotificationType = 'PatientsForPatients';
END;

CREATE TRIGGER `patients_for_patients_update_trigger` AFTER UPDATE ON `PatientsForPatients` FOR EACH ROW BEGIN
INSERT INTO `PatientsForPatientsMH`(`PatientsForPatientsSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.PatientsForPatientsSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END;

CREATE TRIGGER `patient_delete_trigger` AFTER DELETE ON `Patient` FOR EACH ROW BEGIN
INSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (OLD.PatientSerNum,NULL,OLD.SessionId,OLD.PatientAriaSer,OLD.PatientId, OLD.PatientId2, OLD.FirstName,OLD.LastName,OLD.Alias, OLD.Sex, OLD.DateOfBirth, OLD.Age, OLD.TelNum,OLD.EnableSMS,OLD.Email,OLD.Language,OLD.SSN, OLD.AccessLevel,OLD.RegistrationDate, OLD.ConsentFormExpirationDate, OLD.BlockedStatus, OLD.StatusReasonTxt, OLD.DeathDate, NOW(), 'DELETE');
END;

CREATE TRIGGER `patient_insert_trigger` AFTER INSERT ON `Patient` FOR EACH ROW BEGIN
INSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`,`RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.PatientSerNum,NULL,NULL,NEW.PatientAriaSer,NEW.PatientId, NEW.PatientId2, NEW.FirstName,NEW.LastName,NEW.Alias, NEW.Sex, NEW.DateOfBirth, NEW.Age, NEW.TelNum,NEW.EnableSMS,NEW.Email,NEW.Language,NEW.SSN, NEW.AccessLevel,NEW.RegistrationDate, NEW.ConsentFormExpirationDate, NEW.BlockedStatus, NEW.StatusReasonTxt, NEW.DeathDate, NOW(), 'INSERT');
END;

CREATE TRIGGER `patient_update_trigger` AFTER UPDATE ON `Patient` FOR EACH ROW BEGIN
INSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`,`RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.PatientSerNum,NULL,NEW.SessionId,NEW.PatientAriaSer,NEW.PatientId, NEW.PatientId2, NEW.FirstName,NEW.LastName,NEW.Alias, NEW.Sex, NEW.DateOfBirth, NEW.Age, NEW.TelNum,NEW.EnableSMS,NEW.Email,NEW.Language,NEW.SSN, NEW.AccessLevel, NEW.RegistrationDate, NEW.ConsentFormExpirationDate, NEW.BlockedStatus, NEW.StatusReasonTxt, NEW.DeathDate, NOW(), 'UPDATE');
END;

CREATE TRIGGER `post_control_delete_trigger` AFTER DELETE ON `PostControl` FOR EACH ROW BEGIN
   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.PostControlSerNum, OLD.PostType, OLD.PublishFlag, OLD.PostName_FR, OLD.PostName_EN, OLD.Body_FR, OLD.Body_EN, OLD.PublishDate, OLD.Disabled, NOW(), OLD.LastPublished, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');
END;

CREATE TRIGGER `post_control_insert_trigger` AFTER INSERT ON `PostControl` FOR EACH ROW BEGIN
   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.PostControlSerNum, NEW.PostType, NEW.PublishFlag, NEW.PostName_FR, NEW.PostName_EN, NEW.Body_FR, NEW.Body_EN, NEW.PublishDate, NEW.Disabled, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');
END;

CREATE TRIGGER `post_control_update_trigger` AFTER UPDATE ON `PostControl` FOR EACH ROW BEGIN
if NEW.LastPublished <=> OLD.LastPublished THEN
   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.PostControlSerNum, NEW.PostType, NEW.PublishFlag, NEW.PostName_FR, NEW.PostName_EN, NEW.Body_FR, NEW.Body_EN, NEW.PublishDate, NEW.Disabled, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');
END IF;
END;

CREATE TRIGGER `questionnaire_control_delete_trigger` AFTER DELETE ON `QuestionnaireControl` FOR EACH ROW BEGIN
   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (OLD.QuestionnaireControlSerNum, OLD.QuestionnaireDBSerNum, OLD.QuestionnaireName_EN, OLD.QuestionnaireName_FR, OLD.Intro_EN, OLD.Intro_FR, OLD.PublishFlag,NOW(), OLD.LastUpdatedBy, OLD.LastPublished, OLD.SessionId, 'DELETE');
END;

CREATE TRIGGER `questionnaire_control_insert_trigger` AFTER INSERT ON `QuestionnaireControl` FOR EACH ROW BEGIN
   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (NEW.QuestionnaireControlSerNum, NEW.QuestionnaireDBSerNum, NEW.QuestionnaireName_EN, NEW.QuestionnaireName_FR, NEW.Intro_EN, NEW.Intro_FR, NEW.PublishFlag,NOW(), NEW.LastUpdatedBy, NEW.LastPublished, NEW.SessionId, 'INSERT');
END;

CREATE TRIGGER `questionnaire_control_update_trigger` AFTER UPDATE ON `QuestionnaireControl` FOR EACH ROW BEGIN
if NEW.LastPublished <=> OLD.LastPublished THEN
   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (NEW.QuestionnaireControlSerNum, NEW.QuestionnaireDBSerNum, NEW.QuestionnaireName_EN, NEW.QuestionnaireName_FR, NEW.Intro_EN, NEW.Intro_FR, NEW.PublishFlag,NOW(), NEW.LastUpdatedBy, NEW.LastPublished, NEW.SessionId, 'UPDATE');
END IF;
END;

CREATE TRIGGER `txteammessage_delete_trigger` AFTER DELETE ON `TxTeamMessage` FOR EACH ROW BEGIN
INSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  VALUES (OLD.TxTeamMessageSerNum,OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END;

CREATE TRIGGER `txteammessage_insert_trigger` AFTER INSERT ON `TxTeamMessage` FOR EACH ROW BEGIN
	INSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  
	VALUES (NEW.TxTeamMessageSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');

	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.TxTeamMessageSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR
	FROM NotificationControl ntc 
	WHERE ntc.NotificationType = 'TxTeamMessage';
END;

CREATE TRIGGER `txteammessage_update_trigger` AFTER UPDATE ON `TxTeamMessage` FOR EACH ROW BEGIN
INSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  VALUES (NEW.TxTeamMessageSerNum,NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END;

CREATE TRIGGER `update_task_trigger` AFTER UPDATE ON `Task` FOR EACH ROW BEGIN
INSERT INTO `TaskMH`(`TaskSerNum`, `CronLogSerNum`, `PatientSerNum`, `AliasExpressionSerNum`, `SourceDatabaseSerNum`, `TaskAriaSer`, `Status`, `State`, `PrioritySerNum`, `DiagnosisSerNum`, `DueDateTime`, `CreationDate`, `CompletionDate`, `DateAdded`, `LastUpdated`, `ModificationAction`) VALUES (NEW.TaskSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.AliasExpressionSerNum,NEW.SourceDatabaseSerNum,NEW.TaskAriaSer, NEW.Status, NEW.State, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.DueDateTime, NEW.CreationDate, NEW.CompletionDate, NEW.DateAdded,NULL, 'UPDATE');
END;

CREATE TRIGGER `users_delete_trigger` AFTER DELETE ON `Users` FOR EACH ROW BEGIN
INSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`) 
VALUES (OLD.UserSerNum, NULL,OLD.SessionId,OLD.UserType, OLD.UserTypeSerNum, OLD.Username,OLD.Password, NOW(), 'DELETE');
END;

CREATE TRIGGER `users_insert_trigger` AFTER INSERT ON `Users` FOR EACH ROW BEGIN
INSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`) 
VALUES (NEW.UserSerNum, NULL,NEW.SessionId,NEW.UserType,  NEW.UserTypeSerNum, NEW.Username,NEW.Password, NOW(), 'INSERT');
END;

CREATE TRIGGER `users_update_trigger` AFTER UPDATE ON `Users` FOR EACH ROW BEGIN
INSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`) 
VALUES (NEW.UserSerNum, NULL,NEW.SessionId,NEW.UserType, NEW.UserTypeSerNum, NEW.Username,NEW.Password, NOW(), 'UPDATE');
END;

CREATE TRIGGER `test_result_control_delete_trigger` AFTER DELETE ON `TestResultControl` FOR EACH ROW BEGIN
   INSERT INTO `TestResultControlMH`(`TestResultControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `Group_EN`, `Group_FR`, `SourceDatabaseSerNum`, `EducationalMaterialControlSerNum`, `PublishFlag`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `URL_EN`, `URL_FR`, `SessionId`, `ModificationAction`) VALUES (OLD.TestResultControlSerNum, OLD.Name_EN, OLD.Name_FR, OLD.Description_EN, OLD.Description_FR, OLD.Group_EN, OLD.Group_FR, OLD.SourceDatabaseSerNum, OLD.EducationalMaterialControlSerNum, OLD.PublishFlag, NOW(), OLD.LastPublished, OLD.LastUpdatedBy, OLD.URL_EN, OLD.URL_FR, OLD.SessionId, 'DELETE');
END;

CREATE TRIGGER `test_result_control_insert_trigger` AFTER INSERT ON `TestResultControl` FOR EACH ROW BEGIN
   INSERT INTO `TestResultControlMH`(`TestResultControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `Group_EN`, `Group_FR`, `SourceDatabaseSerNum`, `EducationalMaterialControlSerNum`, `PublishFlag`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `URL_EN`, `URL_FR`, `SessionId`, `ModificationAction`) VALUES (NEW.TestResultControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.Group_EN, NEW.Group_FR, NEW.SourceDatabaseSerNum, NEW.EducationalMaterialControlSerNum, NEW.PublishFlag, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.URL_EN, NEW.URL_FR, NEW.SessionId, 'INSERT');
END;

CREATE TRIGGER `test_result_control_update_trigger` AFTER UPDATE ON `TestResultControl` FOR EACH ROW BEGIN
if NEW.LastPublished <=> OLD.LastPublished THEN
   INSERT INTO `TestResultControlMH`(`TestResultControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `Group_EN`, `Group_FR`, `SourceDatabaseSerNum`, `EducationalMaterialControlSerNum`, `PublishFlag`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `URL_EN`, `URL_FR`, `SessionId`, `ModificationAction`) VALUES (NEW.TestResultControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.Group_EN, NEW.Group_FR, NEW.SourceDatabaseSerNum, NEW.EducationalMaterialControlSerNum, NEW.PublishFlag, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.URL_EN, NEW.URL_FR, NEW.SessionId, 'UPDATE');
END IF;
END;

CREATE TRIGGER `test_result_expression_delete_trigger` AFTER DELETE ON `TestResultExpression` FOR EACH ROW BEGIN
   INSERT INTO `TestResultExpressionMH`(`TestResultControlSerNum`,`ExpressionName`,`LastPublished`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (OLD.TestResultControlSerNum, OLD.ExpressionName, OLD.LastPublished, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END;

CREATE TRIGGER `test_result_expression_insert_trigger` AFTER INSERT ON `TestResultExpression` FOR EACH ROW BEGIN
   INSERT INTO `TestResultExpressionMH`(`TestResultControlSerNum`,`ExpressionName`,`LastPublished`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.TestResultControlSerNum, NEW.ExpressionName, NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END;

CREATE TRIGGER `test_result_expression_update_trigger` AFTER UPDATE ON `TestResultExpression` FOR EACH ROW BEGIN
if NEW.LastPublished <=> OLD.LastPublished THEN
   INSERT INTO `TestResultExpressionMH`(`TestResultControlSerNum`,`ExpressionName`,`LastPublished`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.TestResultControlSerNum, NEW.ExpressionName, NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END IF;
END;




