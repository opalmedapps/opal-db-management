-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- OHIG PEDIATRIC INSTITUTION

INSERT INTO `Hospital_Identifier_Type` (`Hospital_Identifier_Type_Id`, `Code`, `ADT_Web_Service_Code`, `Description_EN`, `Description_FR`) VALUES
(1,	'CHUSJ',	'CHUSJ',	'OHIG Pediatric Hospital',	'Hôpital Pédiatrique OHIG');

INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(51,	0,	'',	'',	'Marge',	'Simpson',	'marge_test',	NULL,	'Female',	CONCAT(DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -36 YEAR), '%Y'), '-10-01') - INTERVAL (DATE_FORMAT(NOW(), '%m%d') < '1001') YEAR,	0,	5551234567,	0,	'marge@opalmedapps.ca',	'EN',	'',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 MONTH)),
(53,	0,	'',	'',	'Bart',	    'Simpson',	'bart_test',	NULL,	'Other',	CONCAT(DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -14 YEAR), '%Y'), '-02-23') - INTERVAL (DATE_FORMAT(NOW(), '%m%d') < '0223') YEAR,	0,	61292507111,	0,	'bart@opalmedapps.ca',	'EN',	'SIMB13022399',	'3',	DATE_ADD(NOW(), INTERVAL -7 DAY),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -7 DAY)),
(54,	0,	'',	'',	'Lisa',	    'Simpson',	'lisa_test',	NULL,	'Female',	CONCAT(DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -8 YEAR), '%Y'), '-05-09') - INTERVAL (DATE_FORMAT(NOW(), '%m%d') < '0509') YEAR,	0,	61292507111,	0,	'lisa@opalmedapps.ca',	'EN',	'SIML14550999',	'3',	DATE_ADD(NOW(), INTERVAL -1 DAY),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL);

UPDATE `Patient` SET `Age` = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), `DateOfBirth`)), '%Y') + 0;

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(53,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(54,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0);

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(4,	53,	'CHUSJ',	'9999996',	1),
(5,	54,	'CHUSJ',	'9999993',	1);

INSERT INTO `Users` (`UserSerNum`, `UserType`, `UserTypeSerNum`, `Username`, `Password`, `SessionId`, `LastUpdated`) VALUES
(1,	'Caregiver',	51,	'QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(3,	'Patient',	    53,	'SipDLZCcOyTYj7O3C8HnWLalb4G3',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59');
