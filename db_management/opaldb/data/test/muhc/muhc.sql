INSERT INTO `Hospital_Identifier_Type` (`Hospital_Identifier_Type_Id`, `Code`, `ADT_Web_Service_Code`, `Description_EN`, `Description_FR`) VALUES
(1,	'RVH',	'MR_PCS',	'Royal Victoria Hospital',	'Hôpital Royal Victoria'),
(2,	'MGH',	'MG_PCS',	'Montreal General Hospital',	'Hôpital Général de Montréal'),
(3,	'MCH',	'MC_ADT',	"Montreal Children's Hospital",	'Hôpital de Montréal pour enfants'),
(4,	'LAC',	'LC_ADT',	'Lachine Hospital',	'Hôpital de Lachine');

INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(51,	0,	'',	'',	'Marge',	'Simpson',	'marge_test',	NULL,	'Female',	'1986-10-01 00:00:00',	0,	15144758941,	0,	'marge@opalmedapps.ca',	'EN',	'SIMM86600199',	'3',	DATE_ADD(NOW(), INTERVAL -2 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -2 MONTH)),
(52,	0,	'',	'',	'Homer',	'Simpson',	'homer_test',	NULL,	'Male',	'1983-05-12 00:00:00',	0,	14381234567,	0,	'homer@opalmedapps.ca',	'EN',	'SIMH83051299',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	1,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 MONTH)),
(53,	0,	'',	'',	'Bart',	    'Simpson',	'bart_test',	NULL,	'Other',	'2009-02-23 00:00:00',	0,	61292507111,	0,	'bart@opalmedapps.ca',	'EN',	'SIMB13022399',	'3',	DATE_ADD(NOW(), INTERVAL -14 DAY),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -14 DAY)),
(54,	0,	'',	'',	'Lisa',	    'Simpson',	'lisa_test',	NULL,	'Female',	'2014-05-09 00:00:00',	0,	61292507111,	0,	'lisa@opalmedapps.ca',	'EN',	'SIML14550999',	'3',	DATE_ADD(NOW(), INTERVAL -7 DAY),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(55,	0,	'',	'',	'Mona',	    'Simpson',	'mona_test',	NULL,	'Female',	'1940-03-15 00:00:00',	0,	15144758941,	0,	'mona@opalmedapps.ca',	'EN',	'SIMM40531599',	'1',	DATE_ADD(NOW(), INTERVAL -1 YEAR),	'2019-01-01 00:00:00',	1,	'Deceased',	'2021-05-29 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 YEAR));

UPDATE `Patient` SET `Age` = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), `DateOfBirth`)), '%Y') + 0;

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(51,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(52,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(53,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(54,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(55,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0);

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(1,	51,	'RVH',	'9999996',	1),
(2,	52,	'RVH',	'9999997',	1),
(3,	52,	'MGH',	'9999998',	1),
(4,	53,	'MCH',	'9999996',	1),
(5,	54,	'MCH',	'9999993',	1),
(6,	55,	'RVH',	'9999993',	1),
(7,	55,	'MCH',	'5407383',	1);

INSERT INTO `Users` (`UserSerNum`, `UserType`, `UserTypeSerNum`, `Username`, `Password`, `SessionId`, `LastUpdated`) VALUES
(1,	'Patient',	51,	'QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(2,	'Patient',	52,	'PyKlcbRpMLVm8lVnuopFnFOHO4B3',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(3,	'Patient',	53,	'SipDLZCcOyTYj7O3C8HnWLalb4G3',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(4,	'Patient',	55,	'61DXBRwLCmPxlaUoX6M1MP9DiEl1',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59');

-- We add two sets of Security Answers to test Django's migration scripts, they aren't actually accessed in OpalDB anymore.
INSERT INTO `SecurityAnswer` (`SecurityQuestionSerNum`, `PatientSerNum`, `AnswerText`, `CreationDate`, `LastUpdated`) VALUES
(1,	53,	'5ed4c7167f059c5b864fd775f527c5a88794f9f823fea73c6284756b31a08faf6f9f950473c5aa7cdb99c56bc7807517fe4c4a0bd67318bcaec508592dd6d917',	'2018-11-08 12:37:55',	'2020-12-07 00:46:00'),
(2,	53,	'f3b49c229cc474b3334dd4a3bbe827a866cbf6d6775cde7a5c42da24b4f15db8c0e564c4ff20754841c2baa9dafffc2caa02341010456157b1de9b927f24a1e6',	'2018-11-08 12:38:23',	'2019-01-11 02:45:19'),
(5,	53,	'a7dbabba9a0371fbdb92724a5ca66401e02069089b1f3a100374e61f934fe9e959215ae0327de2bc064a9dfc351c4d64ef89bd47e95be0198a1f466c3518cc1d',	'2018-11-08 12:38:47',	'2019-01-11 02:45:32'),
(1,	55,	'5ed4c7167f059c5b864fd775f527c5a88794f9f823fea73c6284756b31a08faf6f9f950473c5aa7cdb99c56bc7807517fe4c4a0bd67318bcaec508592dd6d917',	'2018-11-08 12:37:55',	'2020-12-07 00:46:00'),
(2,	55,	'f3b49c229cc474b3334dd4a3bbe827a866cbf6d6775cde7a5c42da24b4f15db8c0e564c4ff20754841c2baa9dafffc2caa02341010456157b1de9b927f24a1e6',	'2018-11-08 12:38:23',	'2019-01-11 02:45:19'),
(5,	55,	'a7dbabba9a0371fbdb92724a5ca66401e02069089b1f3a100374e61f934fe9e959215ae0327de2bc064a9dfc351c4d64ef89bd47e95be0198a1f466c3518cc1d',	'2018-11-08 12:38:47',	'2019-01-11 02:45:32');

-- Insert required Alias, AliasExpression, Source, and Doctors first before documents to avoid Foreign Key error
INSERT INTO `SourceDatabase` (`SourceDatabaseSerNum`, `SourceDatabaseName`, `Enabled`) VALUES
(1,	'Aria',	1);
INSERT INTO `Alias` (`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `WaitTimeValidity`, `LastTransferred`, `LastUpdatedBy`, `LastUpdated`, `SessionId`) VALUES
(12,	'Document',	1,	'Note de consultation en radio-oncologie',	'Radiation Oncology Consultation Note',	'<p>La note de consultation en radio-oncologie est un document que votre radio-oncologue ou un(e) stagiaire en radio-oncologie a préparé lors de votre rendez-vous de consultation. Elle résume le rendez-vous et contient typiquement les éléments suivants:</p><p style=\"font-size: 14px;\">- Votre histoire médicale</p><p style=\"font-size: 14px;\">- Vos symptômes actuels</p><p style=\"font-size: 14px;\">- Vos médicaments actuels et vos allergies</p><p style=\"font-size: 14px;\">- Les résultats d\'examens sanguins, radiologiques ou autres examens clé</p><p style=\"font-size: 14px;\">- Un résumé de votre cas médical et un plan pour des examens supplémentaires, des traitements ou pour un suivi</p><p style=\"font-size: 14px;\">Ce document est habituellement envoyé au médecin qui vous a référé à notre service et à votre médecin de famille, si vous avez fourni son nom à notre équipe. <span style=\"font-size: 14px;float: none;\">Vous pouvez aussi fournir une copie de cette note aux professionnels de la santé que vous verrez dans le futur.</span><!--EndFragment--><br/><br/></p><p></p>',	'<p style=\"font-size: 14px;\"></p><p>This radiation oncology consultation note is a document that your radiation oncologist or the trainee in radiation oncology has prepared after your consultation appointment with them. It details the appointment and typically contains elements such as:</p><p>- Why you were referred to our service and by whom</p><p>- Your previous medical issues</p><p>- Your current symptoms</p><p>- Your current medications and allergies</p><p>- Key results of your blood tests, radiology examinations and other tests</p><p>- A summary of your medical case and a plan for further tests, treatment or follow-up</p><p>This document is usually sent to the physician that referred you to our service and to your family physician, if you provided her/his name to our team. You may also provide a copy of this note to medical professionals you see in the future.</p><p></p>',	NULL,	NULL,	1,	'#FFECB3',	1,	'2021-09-30 00:56:01',	NULL,	'2019-06-12 17:25:34',	'IpHHxGhoeq'),
(464,	'Document',	1,	'Pathologie Chirurgicale Rapport Final',	'Surgical Pathology Final Report',	'<p><b>Qu\'est-ce qu\'un rapport de pathologie?</b></p><p>Un rapport de pathologie est un document médical décrivant l\'examen d\'un tissu par un pathologiste. Le pathologiste est un médecin spécialiste qui travaille en étroite collaboration avec les autres médecins de l\'équipe soignante.</p><p><b>Quelles sont les informations contenues dans un rapport de pathologie?</b></p><p>Tous les rapports de pathologie comprennent des sections consacrées aux informations sur le patient, à la source de l\'échantillon, aux antécédents cliniques et au diagnostic. Les rapports de pathologie chirurgicale (ceux qui décrivent l\'examen d\'échantillons de tissus plus importants tels que les biopsies, les excisions et les résections) comprennent généralement aussi des sections pour les descriptions microscopiques et macroscopiques et les commentaires du pathologiste.</p><p>Cette explication est tirée de la section FAQ du site web <a href=\"https://www.mypathologyreport.ca/fr/pathology-reports-frequently-asked-questions/\" target=\"\">MonRapportPathologique</a>.<!--EndFragment--></p><p><a href=\"https://www.mypathologyreport.ca/fr/pathology-reports-frequently-asked-questions/\" target=\"\">MonRapportPathologique</a> est un outil éducatif créé par des médecins pour aider les patients à lire et à comprendre leurs rapports de pathologie.</p><p>Pour toute autre question ou demande de renseignements, veuillez en discuter avec votre équipe clinique.<br/></p>',	'<p><b>What is a pathology report?</b></p><p>A pathology report is a medical document describing the examination of tissue by a pathologist. A pathologist is a specialist medical doctor who works closely with the other doctors in your healthcare team.<!--EndFragment--></p><p><b>What information is included in a pathology report?</b></p><p>All pathology reports include sections for patient information, specimen source, clinical history, and diagnosis. Surgical pathology reports (those that describe the examination of larger tissue samples such as biopsies, excisions, and resections) will typically also include sections for microscopic and gross descriptions and comments by the pathologist.</p><p>This explanation was taken from the FAQ section of the <a href=\"https://www.mypathologyreport.ca/pathology-reports-frequently-asked-questions/\" target=\"\">MyPathologyReport.ca</a> website.</p><p><a href=\"https://www.mypathologyreport.ca/pathology-reports-frequently-asked-questions/\" target=\"\">MyPathologyReport.ca</a> is an educational tool created by doctors to help patients read and understand their pathology reports.</p><p>For all other questions or inquiries, please discuss them with your clinical team.<br/></p>',	NULL,	NULL,	1,	'#64FFDA',	1,	'2019-01-01 00:00:00',	3,	'2023-08-21 11:40:11',	'kV0AUjLT35');
INSERT INTO `masterSourceAlias` (`ID`, `externalId`, `code`, `description`, `type`, `source`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
(4198, '487', 'Pathology', 'Pathology', 3, 1, 0, '', '2022-01-21 20:45:48', 'MIGRATION_MASTER_SOURCE_2021', '2022-01-21 20:45:48', 'MIGRATION_MASTER_SOURCE_2021');
INSERT INTO `AliasExpression` (`AliasExpressionSerNum`, `AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `LastUpdated`, `SessionId`) VALUES
(99,	12,	NULL,	'RO - Consult',	'RO - Consult',	'2021-09-30 00:56:01',	NULL,	'2018-10-19 23:55:39',	NULL),
(8408,	464,	4198,	'Pathology',	'Pathology',	'2019-01-01 00:00:00',	3,	'2023-08-21 11:02:36',	'kV0AUjLT35');

INSERT INTO `Staff` (`StaffSerNum`, `SourceDatabaseSerNum`, `StaffId`, `FirstName`, `LastName`, `LastUpdated`) VALUES
(890,	1,	'1300',	'John',	'Frink', '2023-06-08 12:35:00'),
(891,	1,	'1301',	'',	'Velimirovic', '2023-06-08 12:35:00'),
(892,	1,	'1302',	'Juan',	'Riviera', '2023-06-08 12:35:00'),
(893,	1,	'1303',	'',	'Hibbert', '2023-06-08 12:35:00'),
(894,	1,	'1304',	'John',	'Thurmond', '2023-06-08 12:35:00');

-- Documents: Pathology && Clinical Notes
-- Filestore must have these pdfs inserted separately (and readable by the listener) for the chart Clinical Reports section to function properly

-- Bart
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(5,	NULL,	53,	1,	'56190000000000039165511',	8408,	890,	'2023-08-22 10:35:00',	890,	'2023-08-29 10:35:00',	'',	'Y',	'',	'bart_2009Feb23_pathology.pdf',	'bart_2009Feb23_pathology.pdf',	890,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');
-- Homer
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(6,	NULL,	52,	1,	'56190000000000039165512',	8408,	890,	'2022-06-13 9:15:00',	890,	'2022-06-20 09:15:00',	'',	'Y',	'',	'homer_1983May12_pathology.pdf',	'homer_1983May12_pathology.pdf',	890,	'2022-06-20 09:16:00',	'T',	'Transfer successful',	'',	'2023-06-21 9:38:26',	0,	'[]',	'2023-06-21 9:38:26');
-- Marge
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(7,	NULL,	51,	1,	'56190000000000039165513',	8408,	890,	'2021-11-28 11:52:00',	890,	'2021-12-05 11:52:00',	'',	'Y',	'',	'marge_1986Oct01_pathology_1.pdf',	'marge_1986Oct01_pathology_1.pdf',	890,	'2021-12-05 11:53:00',	'T',	'Transfer successful',	'',	'2021-12-06 11:53:00',	0,	'[]',	'2021-12-06 11:53:00');
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(8,	NULL,	51,	1,	'56190000000000039165514',	8408,	890,	'2023-04-12 10:26:00',	890,	'2023-04-19 10:26:00',	'',	'Y',	'',	'marge_1986Oct01_pathology_2.pdf',	'marge_1986Oct01_pathology_2.pdf',	890,	'2023-04-19 10:27:00',	'T',	'Transfer successful',	'',	'2023-04-20 10:27:00',	0,	'[]',	'2023-04-20 10:27:00');

-- We add those records here to manually insert `Clinical Notes` documents for hospital-specific `muhc` demo purposes
-- Bart
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(9,	NULL,	53,	1,	'56190000000000039165515',	99,	891,	'2023-08-22 10:35:00',	891,	'2023-08-29 10:35:00',	'',	'Y',	'',	'bart_2009Feb23_note_mch.pdf',	'bart_2009Feb23_note_mch.pdf',	891,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');

-- Homer
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(10,	NULL,	52,	1,	'56190000000000039165516',	99,	892,	'2023-08-22 10:35:00',	892,	'2023-08-29 10:35:00',	'',	'Y',	'',	'homer_1983May12_note_mgh.pdf',	'homer_1983May12_note_mgh.pdf',	892,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');
-- Marge
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(11,	NULL,	51,	1,	'56190000000000039165517',	99,	893,	'2023-08-22 10:35:00',	893,	'2023-08-29 10:35:00',	'',	'Y',	'',	'marge_1986Oct01_note_rvh.pdf',	'marge_1986Oct01_note_rvh.pdf',	893,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');



UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE
    `PatientSerNum` = 51
;
UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE
    `PatientSerNum` = 52
;
UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["SipDLZCcOyTYj7O3C8HnWLalb4G3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE
    `PatientSerNum` = 53
;
