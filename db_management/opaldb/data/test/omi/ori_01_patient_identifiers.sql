-- OPAL RESEARCH INSTITUTION

-- additional records for secondary test patient family (Flintstones) and Addamms
INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(56,	0,	'',	'',	'Fred',	'Flintstone',	'fred_test',	NULL,	'Male',	'1960-08-01 00:00:00',	0,	5144758941,	0,	'fred@opalmedapps.ca',	'EN',	'FLIF60080199',	'3',	DATE_ADD(NOW(), INTERVAL -2 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -2 MONTH)),
(57,	0,	'',	'',	'Pebbles',	'Flintstone',	'pebbles_test',	NULL,	'Female',	CONCAT(DATE_FORMAT(DATE_SUB(NOW(), INTERVAL -9 YEAR), '%Y'), '-02-01 00:00:00'),	0,	4381234567,	0,	'pebbles@opalmedapps.ca',	'EN',	'FLIP15022299',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(58,	0,	'',	'',	'Wednesday',	'Addams',	'wednesday_test',	NULL,	'Female',	CONCAT(DATE_FORMAT(DATE_SUB(NOW(), INTERVAL -15 YEAR), '%Y'), '-02-13 00:00:00'),	0,	4381234567,	0,	'wednesday@opalmedapps.ca',	'EN',	'ADAW09021399',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL);
UPDATE `Patient` SET `Age` = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), `DateOfBirth`)), '%Y') + 0;

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(56,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(57,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(58,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0);

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(9, 56, 'RVH',  '9999998',  1),
(10,	57,	'MCH',	'9999999',	1),
(11,	58,	'RVH',	'9999991',	1);

INSERT INTO `Users` (`UserSerNum`, `UserType`, `UserTypeSerNum`, `Username`, `Password`, `SessionId`, `LastUpdated`) VALUES
(5,	'Patient',	56,	'ZYHAjhNy6hhr4tOW8nFaVEeKngt1',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59');
