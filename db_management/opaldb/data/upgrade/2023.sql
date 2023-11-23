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
(LAST_INSERT_ID(),	4363,	'Pathology',	'Pathology',	'kV0AUjLT35');

UPDATE `module` SET name_EN = 'Opal User Administration', name_FR = 'Administration des utilisateurs', description_EN = 'Manage the user account information', description_FR = 'Gérer les informations du compte utilisateur' WHERE name_EN = 'Patient Administration';

-- TODO: add databank consent form

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

INSERT INTO `EducationalMaterialTOC` (`EducationalMaterialControlSerNum`, `OrderNum`, `ParentSerNum`, `DateAdded`) VALUES (404, 1, 643, '2019-06-06 10:44:21');

UPDATE EducationalMaterialControl SET
URL_EN = 'http://muhcguides.com/module/prostate/en/what-is-the-prostate',
URL_FR = 'http://muhcguides.com/module/prostate/fr/what-is-the-prostate',
URLType_EN = 'website',
URLType_FR = 'website'
WHERE EducationalMaterialControlSerNum = 643;

UPDATE EducationalMaterialControl SET
URL_EN = 'https://www.depdocs.com/opal/educational/fertility/Q&A/q17_en.php',
URL_FR = 'https://www.depdocs.com/opal/educational/fertility/Q&A/q17_fr.php',
URLType_EN = 'website',
URLType_FR = 'website'
WHERE EducationalMaterialControlSerNum = 642;

INSERT INTO `EducationalMaterialControl` (`EducationalMaterialControlSerNum`, `EducationalMaterialType_EN`, `EducationalMaterialType_FR`, `EducationalMaterialCategoryId`, `PublishFlag`, `Name_EN`, `Name_FR`, `URL_EN`, `URL_FR`, `URLType_EN`, `URLType_FR`, `ShareURL_EN`, `ShareURL_FR`, `PhaseInTreatmentSerNum`, `ParentFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `LastUpdated`, `deleted`, `SessionId`) VALUES
(644,	'Booklet',	'Brochure',	1,	1,	'Brochure — Kids after Cancer?',	'Brochure — Des enfants après le cancer?',	'https://www.depdocs.com/opal/educational/fertility/fertility_educate_brochure/Kids_After_Cancer_Men.pdf',	'https://www.depdocs.com/opal/educational/fertility/fertility_educate_brochure/Des_enfants_apres_le_cancer_hommes.pdf',	'pdf',	'pdf',	'https://www.depdocs.com/opal/educational/fertility/fertility_educate_brochure/Kids_After_Cancer_Men.pdf',	'https://www.depdocs.com/opal/educational/fertility/fertility_educate_brochure/Des_enfants_apres_le_cancer_hommes.pdf',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:18:02',	'2020-02-15 02:26:48',	0,	'WceMOf0ovB'),
(645,	'Video',	'Vidéo',	1,	1,	'Detailed video: The fertility preservation process for men',	'Vidéo détaillée: Le processus de préservation de la fertilité pour les hommes',	'https://www.youtube.com/embed/cNygcyDNzCY',	'https://www.youtube.com/embed/ngttCVjkLfY',	'website',	'website',	'https://www.youtube.com/watch?v=cNygcyDNzCY',	'https://www.youtube.com/watch?v=ngttCVjkLfY',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:18:02',	'2020-02-15 02:27:13',	0,	'WceMOf0ovB'),
(646,	'Booklet',	'Brochure',	1,	1,	'Referral Form',	'Formulaire de référence',	'https://www.depdocs.com/opal/educational/fertility/Fertility_Preservation_Referral/Référence_fertilité_Fertility_referral.pdf',	'https://www.depdocs.com/opal/educational/fertility/Fertility_Preservation_Referral/Référence_fertilité_Fertility_referral.pdf',	'pdf',	'pdf',	'https://www.depdocs.com/opal/educational/fertility/Fertility_Preservation_Referral/Référence_fertilité_Fertility_referral.pdf',	'https://www.depdocs.com/opal/educational/fertility/Fertility_Preservation_Referral/Référence_fertilité_Fertility_referral.pdf',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:18:02',	'2020-02-15 02:27:22',	0,	'WceMOf0ovB'),
(647,	'Booklet',	'Brochure',	1,	1,	'Frequently Asked Questions',	'Foire aux questions',	'',	'',	NULL,	NULL,	'',	'',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:18:02',	'2020-02-15 02:27:46',	0,	'WceMOf0ovB'),
(648,	'Booklet',	'Brochure',	1,	1,	'About this educational material package',	'À propos de ce paquet de matériel éducatif',	'https://www.depdocs.com/opal/educational/fertility/female_fertility_brochure/About_Fertility_Preservation_En.php',	'https://www.depdocs.com/opal/educational/fertility/female_fertility_brochure/About_Fertility_Preservation_Fr.php',	'website',	'website',	'',	'',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:14:28',	'2020-02-15 02:22:36',	0,	'WceMOf0ovB'),
(649,	'Booklet',	'Brochure',	1,	1,	'Brochure — Kids after Cancer?',	'Brochure — Des enfants après le cancer?',	'https://www.depdocs.com/opal/educational/fertility/female_fertility_brochure/Kids_After_Cancer_Women.pdf',	'https://www.depdocs.com/opal/educational/fertility/female_fertility_brochure/Des_enfants_apres_le_cancer_femmes.pdf',	'pdf',	'pdf',	'https://www.depdocs.com/opal/educational/fertility/female_fertility_brochure/Kids_After_Cancer_Women.pdf',	'https://www.depdocs.com/opal/educational/fertility/female_fertility_brochure/Des_enfants_apres_le_cancer_femmes.pdf',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:18:02',	'2020-02-15 02:26:48',	0,	'WceMOf0ovB'),
(650,	'Video',	'Vidéo',	1,	1,	'Detailed video: The fertility preservation process for women',	'Vidéo détaillée: Le processus de préservation de la fertilité pour les femmes',	'https://www.youtube.com/embed/POqONVyEZv0',	'https://www.youtube.com/embed/HqXepsD7Oug',	'website',	'website',	'https://www.youtube.com/watch?v=POqONVyEZv0',	'https://www.youtube.com/watch?v=HqXepsD7Oug',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:18:02',	'2020-02-15 02:27:13',	0,	'WceMOf0ovB'),
(651,	'Booklet',	'Brochure',	1,	1,	'Frequently Asked Questions',	'Foire aux questions',	'',	'',	NULL,	NULL,	'',	'',	1,	1,	'2020-02-14 11:14:28',	16,	'2020-02-14 11:18:02',	'2020-02-15 02:27:46',	0,	'WceMOf0ovB');

