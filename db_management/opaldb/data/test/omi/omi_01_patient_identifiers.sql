-- OPAL MEDICAL INSTITUTION

INSERT INTO `Hospital_Identifier_Type` (`Hospital_Identifier_Type_Id`, `Code`, `ADT_Web_Service_Code`, `Description_EN`, `Description_FR`) VALUES
(1,	'RVH',	'MR_PCS',	'Opal General Hospital 1 (RVH)',	'Hôpital général Opal 1 (HRV)'),
(2,	'MGH',	'MG_PCS',	'Opal General Hospital 2 (MGH)',	'Hôpital général Opal 2 (HGM)'),
(3,	'MCH',	'MC_ADT',	"Opal Children\'s Hospital",	"L\'Hôpital Opal pour enfants"),
(4,	'LAC',	'LC_ADT',	'Opal General Hospital 3 (LAC)',	'Hôpital général Opal 3 (LAC)'),
(5,	'CRE',	'CR_ADT',	'Opal General Hospital 4 (CRE)',	'Hôpital général Opal 4 (CRE)');

INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(51,	0,	'',	'',	'Marge',	'Simpson',	'marge_test',	NULL,	'Female',
CONCAT(DATE_FORMAT(DATE_SUB(NOW(), INTERVAL -36 YEAR), '%Y'), '-10-01 00:00:00'),	0,	15144758941,	0,	'marge@opalmedapps.ca',	'EN',	'SIMM86600199',	'3',	DATE_ADD(NOW(), INTERVAL -2 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -2 MONTH)),
(52,	0,	'',	'',	'Homer',	'Simpson',	'homer_test',	NULL,	'Male',
CONCAT(DATE_FORMAT(DATE_SUB(NOW(), INTERVAL -39 YEAR), '%Y'), '-05-12 00:00:00'),	0,	14381234567,	0,	'homer@opalmedapps.ca',	'EN',	'SIMH83051299',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	1,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 MONTH)),
(53,	0,	'',	'',	'Bart',	    'Simpson',	'bart_test',	NULL,	'Other',
CONCAT(DATE_FORMAT(DATE_SUB(NOW(), INTERVAL -14 YEAR), '%Y'), '-02-23 00:00:00'),	0,	61292507111,	0,	'bart@opalmedapps.ca',	'EN',	'SIMB13022399',	'3',	DATE_ADD(NOW(), INTERVAL -14 DAY),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -14 DAY)),
(55,	0,	'',	'',	'Mona',	    'Simpson',	'mona_test',	NULL,	'Female', '1940-03-15 00:00:00',	0,	15144758941,	0,	'mona@opalmedapps.ca',	'EN',	'SIMM40531599',	'1',	DATE_ADD(NOW(), INTERVAL -1 YEAR),	'2019-01-01 00:00:00',	1,	'Deceased',	DATE_ADD(NOW(), INTERVAL -2 YEAR),	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 YEAR)),
(92, 43235, '1092300', '5024737', 'Laurie', 'Hendren', 'Pointer Lady', '', 'Female', '1958-12-13 00:00:00', 64, 5144415642, 1, 'laurie@opalmedapps.ca', 'EN', 'HENL58621319', '3', '2018-01-01 00:00:00', '2019-01-01 00:00:00', 0, 'Unlock by Johns Request', '2019-05-27 00:00:00', '', '2024-04-18 17:59:43', 0, NULL, NULL);

UPDATE `Patient` SET `Age` = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), `DateOfBirth`)), '%Y') + 0 where PatientSerNum <> 92;

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(51,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(52,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(53,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(55,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(92,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0);

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(1,	51,	'RVH',	'9999996',	1),
(2,	52,	'RVH',	'9999997',	1),
(3,	52,	'MGH',	'9999998',	1),
(4,	53,	'MCH',	'9999996',	1),
(6,	55,	'RVH',	'9999993',	1),
(7,	55,	'MCH',	'5407383',	1),
(8,	51,	'LAC',	'0389731',	1),
(12, 92, 'MGH',	'5024737',	1),
(13, 92, 'RVH',	'1092300',	1);

INSERT INTO `Users` (`UserSerNum`, `UserType`, `UserTypeSerNum`, `Username`, `Password`, `SessionId`, `LastUpdated`) VALUES
(1,	'Patient',	51,	'QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(2,	'Patient',	52,	'PyKlcbRpMLVm8lVnuopFnFOHO4B3',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(3,	'Patient',	53,	'SipDLZCcOyTYj7O3C8HnWLalb4G3',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(4,	'Patient',	55,	'61DXBRwLCmPxlaUoX6M1MP9DiEl1',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(6,	'Patient',	92,	'a51fba18-3810-4808-9238-4d0e487785c8',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59');

-- We add two sets of Security Answers to test Django's migration scripts, they aren't actually accessed in OpalDB anymore.
INSERT INTO `SecurityAnswer` (`SecurityQuestionSerNum`, `PatientSerNum`, `AnswerText`, `CreationDate`, `LastUpdated`) VALUES
(1,	53,	'5ed4c7167f059c5b864fd775f527c5a88794f9f823fea73c6284756b31a08faf6f9f950473c5aa7cdb99c56bc7807517fe4c4a0bd67318bcaec508592dd6d917',	'2018-11-08 12:37:55',	'2020-12-07 00:46:00'),
(2,	53,	'f3b49c229cc474b3334dd4a3bbe827a866cbf6d6775cde7a5c42da24b4f15db8c0e564c4ff20754841c2baa9dafffc2caa02341010456157b1de9b927f24a1e6',	'2018-11-08 12:38:23',	'2019-01-11 02:45:19'),
(5,	53,	'a7dbabba9a0371fbdb92724a5ca66401e02069089b1f3a100374e61f934fe9e959215ae0327de2bc064a9dfc351c4d64ef89bd47e95be0198a1f466c3518cc1d',	'2018-11-08 12:38:47',	'2019-01-11 02:45:32'),
(1,	55,	'5ed4c7167f059c5b864fd775f527c5a88794f9f823fea73c6284756b31a08faf6f9f950473c5aa7cdb99c56bc7807517fe4c4a0bd67318bcaec508592dd6d917',	'2018-11-08 12:37:55',	'2020-12-07 00:46:00'),
(2,	55,	'f3b49c229cc474b3334dd4a3bbe827a866cbf6d6775cde7a5c42da24b4f15db8c0e564c4ff20754841c2baa9dafffc2caa02341010456157b1de9b927f24a1e6',	'2018-11-08 12:38:23',	'2019-01-11 02:45:19'),
(5,	55,	'a7dbabba9a0371fbdb92724a5ca66401e02069089b1f3a100374e61f934fe9e959215ae0327de2bc064a9dfc351c4d64ef89bd47e95be0198a1f466c3518cc1d',	'2018-11-08 12:38:47',	'2019-01-11 02:45:32');
