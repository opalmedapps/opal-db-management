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
(3,	52,	'MGH',	'9999996',	1),
(4,	53,	'MCH',	'9999996',	1),
(5,	54,	'MCH',	'9999993',	1),
(6,	55,	'RVH',	'9999993',	1);

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


-- We add those records here to manually insert documents for hospital-specific `muhc` demo purposes
-- Bart
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(5,	NULL,	53,	1,	'56190000000000039165511',	99,	890,	'2023-06-01 12:36:00',	890,	'2023-06-08 12:35:00',	'',	'Y',	'',	'bart_2009Feb23_pathology.pdf',	'bart_2009Feb23_pathology.pdf',	890,	'2023-06-08 12:36:00',	'T',	'Transfer successful',	'',	'2023-06-09 16:38:26',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17');
-- Homer
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(6,	NULL,	52,	1,	'56190000000000039165512',	99,	890,	'2023-06-01 12:36:00',	890,	'2023-06-08 12:35:00',	'',	'Y',	'',	'homer_1983May12_pathology.pdf',	'homer_1983May12_pathology.pdf',	890,	'2023-06-08 12:36:00',	'T',	'Transfer successful',	'',	'2023-06-09 16:38:26',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17');
-- Marge
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(7,	NULL,	51,	1,	'56190000000000039165513',	99,	890,	'2023-06-01 12:36:00',	890,	'2023-06-08 12:35:00',	'',	'Y',	'',	'marge_1986Oct01_pathology_1.pdf',	'marge_1986Oct01_pathology_1.pdf',	890,	'2023-06-08 12:36:00',	'T',	'Transfer successful',	'',	'2023-06-09 16:38:26',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17');
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(8,	NULL,	51,	1,	'56190000000000039165514',	99,	890,	'2023-06-01 12:36:00',	890,	'2023-06-08 12:35:00',	'',	'Y',	'',	'marge_1986Oct01_pathology_2.pdf',	'marge_1986Oct01_pathology_2.pdf',	890,	'2023-06-08 12:36:00',	'T',	'Transfer successful',	'',	'2023-06-09 16:38:26',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17');

-- We insert staff that are defined in the documents added in the `Document` insert query above to make sure
-- the doctor referred to in the document exists in the test data
INSERT INTO `Staff` (`StaffSerNum`, `SourceDatabaseSerNum`, `StaffId`, `FirstName`, `LastName`, `LastUpdated`) VALUES
(890,	1,	'1300         ',	'John               ',	'Frink                        ',	'2015-08-07 00:15:57');
