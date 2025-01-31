-- Upgrade script to upgrade from the latest version (January 2022) at the MUHC to the new version (TBD in 2023)

-- enable strict mode
SET SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SET GLOBAL SQL_MODE = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- Update Patient Dashboard --> Patients set name_en = Patients' name_FR = Patients
UPDATE `module` SET `name_EN` = 'Patients', `name_FR` = 'Patients' WHERE `name_EN` = 'Patient Dashboard';

-- Insert Hospital Settings and Clinician Dashboard
INSERT INTO `module` (`ID`, `operation`, `name_EN`, `name_FR`, `description_EN`, `description_FR`, `tableName`, `controlTableName`, `primaryKey`, `iconClass`, `url`, `subModule`, `subModuleMenu`, `core`, `active`, `categoryModuleId`, `publication`, `customCode`, `unique`, `order`, `sqlPublicationList`, `sqlDetails`, `sqlPublicationChartLog`, `sqlPublicationListLog`, `sqlPublicationMultiple`, `sqlPublicationUnique`) VALUES
(25,	3,	'Clinician Dashboard',	'Tableau de bord du clinicien',	'Clinician Dashboard Tools.',	'Outils du tableau de bord du clinicien.',	'',	'',	'',	'fa fa-user-md',	'clinician',	'',	0,	1,	1,	1,	0,	0,	1,	21,	'',	'',	'',	'',	'',	'');

-- Add Clinician Dashboard and Hospital Settings to System Administrator
INSERT INTO `oaRoleModule` (`moduleId`, `oaRoleId`, `access`) VALUES
(24, 36, 3),
(25, 36, 3);

-- Add pathology alias
INSERT INTO `Alias` (`AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `WaitTimeValidity`, `SessionId`) VALUES
('Document',	1,	'Pathologie Chirurgicale Rapport Final',	'Surgical Pathology Final Report',	'<p><b>Qu\'est-ce qu\'un rapport de pathologie?</b></p><p>Un rapport de pathologie est un document médical décrivant l\'examen d\'un tissu par un pathologiste. Le pathologiste est un médecin spécialiste qui travaille en étroite collaboration avec les autres médecins de l\'équipe soignante.</p><p><b>Quelles sont les informations contenues dans un rapport de pathologie?</b></p><p>Tous les rapports de pathologie comprennent des sections consacrées aux informations sur le patient, à la source de l\'échantillon, aux antécédents cliniques et au diagnostic. Les rapports de pathologie chirurgicale (ceux qui décrivent l\'examen d\'échantillons de tissus plus importants tels que les biopsies, les excisions et les résections) comprennent généralement aussi des sections pour les descriptions microscopiques et macroscopiques et les commentaires du pathologiste.</p><p>Cette explication est tirée de la section FAQ du site web <a href=\"https://www.mypathologyreport.ca/fr/pathology-reports-frequently-asked-questions/\" target=\"\">MonRapportPathologique</a>.<!--EndFragment--></p><p><a href=\"https://www.mypathologyreport.ca/fr/pathology-reports-frequently-asked-questions/\" target=\"\">MonRapportPathologique</a> est un outil éducatif créé par des médecins pour aider les patients à lire et à comprendre leurs rapports de pathologie.</p><p>Pour toute autre question ou demande de renseignements, veuillez en discuter avec votre équipe clinique.<br/></p>',	'<p><b>What is a pathology report?</b></p><p>A pathology report is a medical document describing the examination of tissue by a pathologist. A pathologist is a specialist medical doctor who works closely with the other doctors in your healthcare team.<!--EndFragment--></p><p><b>What information is included in a pathology report?</b></p><p>All pathology reports include sections for patient information, specimen source, clinical history, and diagnosis. Surgical pathology reports (those that describe the examination of larger tissue samples such as biopsies, excisions, and resections) will typically also include sections for microscopic and gross descriptions and comments by the pathologist.</p><p>This explanation was taken from the FAQ section of the <a href=\"https://www.mypathologyreport.ca/pathology-reports-frequently-asked-questions/\" target=\"\">MyPathologyReport.ca</a> website.</p><p><a href=\"https://www.mypathologyreport.ca/pathology-reports-frequently-asked-questions/\" target=\"\">MyPathologyReport.ca</a> is an educational tool created by doctors to help patients read and understand their pathology reports.</p><p>For all other questions or inquiries, please discuss them with your clinical team.<br/></p>',	NULL,	NULL,	1,	'#64FFDA',	1,	'kV0AUjLT35');
INSERT INTO `AliasExpression` (`AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, `Description`, `SessionId`) VALUES
(LAST_INSERT_ID(),	4198,	'Pathology',	'Pathology',	'kV0AUjLT35');

UPDATE `module` SET name_EN = 'Opal User Administration', name_FR = 'Administration des utilisateurs', description_EN = 'Manage the user account information', description_FR = 'Gérer les informations du compte utilisateur' WHERE name_EN = 'Patient Administration';

-- Insert alembic tracking table
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
INSERT INTO `alembic_version` (`version_num`) VALUES
('7a189846a0f5');


-- Remove CronLogs
DELETE oaRoleModule FROM oaRoleModule JOIN module ON module.ID = oaRoleModule.moduleId WHERE module.tableName = 'CronLog';

DELETE FROM module WHERE tableName = 'CronLog';

DROP TABLE IF EXISTS cronControlPatient;

DROP TABLE IF EXISTS cronControlAlias;

ALTER TABLE CronLog DROP FOREIGN KEY CronLog_ibfk_1;

ALTER TABLE CronLog DROP CronSerNum;

DROP TABLE IF EXISTS Cron;

-- Add missing NotificationType for lab results
UPDATE `NotificationControl` SET NotificationType = 'NewLabResult' WHERE NotificationTypeSerNum = 9;

-- Add new NotificationType for appointment reminders
INSERT INTO `NotificationTypes` (`NotificationTypeSerNum`, `NotificationTypeId`, `NotificationTypeName`, `DateAdded`, `LastUpdated`) VALUES
(19,	'AppointmentReminder',	'Appointment Reminder',	'2023-11-27 11:39:14',	'2023-11-27 16:39:14');

INSERT INTO `NotificationControl` (`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationType`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `LastUpdated`, `SessionId`) VALUES
(18,	'Appointment Reminder',	'Rappel de rendez-vous',	'$patientName: Reminder for an appointment at the $hospitalEN: $appointmentAliasEN on $appointmentDate at $appointmentTime',	'$patientName: Rappel pour un rendez-vous au $hospitalFR : $appointmentAliasFR le $appointmentDate à $appointmentTime',	'AppointmentReminder',	19,	'2023-11-27 11:39:14',	NULL,	'0000-00-00 00:00:00',	'2023-11-27 16:39:16',	NULL);

-- Update cronjob user role for resource-pending and appointment-pending access via cron container
UPDATE `OAUser` SET oaRoleId=29, `type`=2 where Username='cronjob';

-- Remove Questionnaire notification type to avoid confusion.
-- Currently we are using only LegacyQuestionnaire notification types.
DELETE FROM `NotificationControl` WHERE NotificationControlSerNum=11;

DELETE FROM `NotificationTypes` WHERE NotificationTypeSerNum=13;

-- Update descriptions for the NotificationControl
UPDATE `NotificationControl` SET Description_EN='$patientName: Successfully checked in for your appointment(s) at $getDateTime. You will receive another notification when you are called in to your appointment(s).', Description_FR='$patientName: Enregistrement réussi à votre/vos rendez-vous de $getDateTime. Vous recevrez une autre notification lorsque vous serez appelé(e) à votre/vos rendez-vous.' WHERE NotificationControlSerNum=12;

UPDATE `NotificationControl` SET Description_EN='$patientName: New questionnaire received. Please complete it before seeing your health care provider.', Description_FR='$patientName: Nouveau questionnaire reçu. Veuillez le compléter avant votre rendez-vous avec votre professionnel de la santé.' WHERE NotificationControlSerNum=13;

-- Add generic appointment aliases
INSERT INTO `Alias` (`AliasType`, `AliasUpdate`, `AliasName_EN`, `AliasName_FR`, `AliasDescription_EN`, `AliasDescription_FR`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `WaitTimeValidity`) VALUES
('Appointment', 1, 'RVH Appointment', 'Appointment HRV', '<p>TBD</p>', '<p>ADT</p>', NULL, 28, 1, '#757575', 1),
('Appointment', 1, 'MGH Appointment', 'Appointment HGM', '<p>TBD</p>', '<p>ADT</p>', NULL, NULL, 1, '#757575', 1),
('Appointment', 1, 'MCH Appointment', 'Appointment HEM', '<p>TBD</p>', '<p>ADT</p>', NULL, NULL, 1, '#757575', 1);

-- Add ORMS role with read on Clinician Dashboard
INSERT INTO `oaRole` (`name_EN`, `name_FR`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
('ORMS', 'ORMS', 0, '', '2024-03-19 09:22:20', 'SCMA6024', '2024-03-19 09:22:31', 'SCMA6024');
INSERT INTO `oaRoleModule` (`moduleId`, `oaRoleId`, `access`) VALUES
(25, LAST_INSERT_ID(), 1);

-- Add Medical Records role with read on Patients
INSERT INTO `oaRole` (`name_EN`, `name_FR`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
('Medical Records',	'Dossiers médicaux',	0,	'',	'2024-03-19 09:22:20',	'AGKE6000',	'2024-03-19 09:22:20',	'AGKE6000');
INSERT INTO `oaRoleModule` (`moduleId`, `oaRoleId`, `access`) VALUES
(11, LAST_INSERT_ID(), 1);

-- Update Notification texts pertaining to Educational Materials and rename to 'Reference Materials'
UPDATE `NotificationTypes`
SET
NotificationTypeId='ReferenceMaterial',
NotificationTypeName='Reference Material'
WHERE NotificationTypeSerNum=5;

UPDATE `NotificationControl`
SET
Name_EN='New Reference Material',
Name_FR='Nouveau matériel référence',
Description_EN='$patientName ($institution): New Reference material',
Description_FR='$patientName ($institution): Nouveau matériel référence',
NotificationType='ReferenceMaterial'
WHERE NotificationControlSerNum=7;

