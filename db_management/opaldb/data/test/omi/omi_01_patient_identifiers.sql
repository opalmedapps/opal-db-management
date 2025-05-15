-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- OPAL MEDICAL INSTITUTION

INSERT INTO `Hospital_Identifier_Type` (`Hospital_Identifier_Type_Id`, `Code`, `ADT_Web_Service_Code`, `Description_EN`, `Description_FR`) VALUES
(1,	'ODH',	'MR_PCS',	'Opal Demo Hospital (ODH)',	"Hôpital démo d\'Opal (HDO)");

-- Some dates are calculated relative to current to maintain constant age
INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(51,	0,	'',	'',	'Marge',	'Simpson',	'marge_test',	NULL,	'Female',
CONCAT(DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -36 YEAR), '%Y'), '-10-01') - INTERVAL (DATE_FORMAT(NOW(), '%m%d') < '1001') YEAR,	0,	5551234567,	0,	'marge@opalmedapps.ca',	'EN',	'SIMM86600199',	'3',	DATE_ADD(NOW(), INTERVAL -2 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -2 MONTH)),
(52,	0,	'',	'',	'Homer',	'Simpson',	'homer_test',	NULL,	'Male',
CONCAT(DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -39 YEAR), '%Y'), '-05-12') - INTERVAL (DATE_FORMAT(NOW(), '%m%d') < '0512') YEAR,	0,	5557654321,	0,	'homer@opalmedapps.ca',	'EN',	'SIMH83051299',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	1,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 MONTH)),
(53,	0,	'',	'',	'Bart',	    'Simpson',	'bart_test',	NULL,	'Other',
CONCAT(DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -14 YEAR), '%Y'), '-02-23') - INTERVAL (DATE_FORMAT(NOW(), '%m%d') < '0223') YEAR,	0,	61292507111,	0,	'bart@opalmedapps.ca',	'EN',	'SIMB13022399',	'3',	DATE_ADD(NOW(), INTERVAL -14 DAY),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -14 DAY)),
(55,	0,	'',	'',	'Mona',	    'Simpson',	'mona_test',	NULL,	'Female', '1940-03-15 00:00:00',	0,	5144758941,	0,	'mona@opalmedapps.ca',	'EN',	'SIMM40531599',	'1',	DATE_ADD(NOW(), INTERVAL -1 YEAR),	'2019-01-01 00:00:00',	1,	'Deceased',	DATE_ADD(CURRENT_DATE(), INTERVAL -2 YEAR),	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 YEAR)),
(59,	0,	'',	'',	'Rory',	"O\'Brien",	'rory_test',	NULL,	'Other',
CONCAT(DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -52 YEAR), '%Y'), '-06-11') - INTERVAL (DATE_FORMAT(NOW(), '%m%d') < '0611') YEAR,	0,	5557654321,	0,	'rory@opalmedapps.ca',	'EN',	'OBRR72061199',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	1,	'',	'0000-00-00 00:00:00',	'',	'2024-09-09 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -1 MONTH)),
(92, 43235, '1092300', '5024737', 'Laurie', 'Opal', 'Pointer Lady', '', 'Female', '1958-12-13 00:00:00', 64, 5144415642, 1, 'laurie@opalmedapps.ca', 'EN', 'OPAL58621325', '3', '2018-01-01 00:00:00', '2019-01-01 00:00:00', 0, 'Unlocked by Johns Request', '2019-05-27 00:00:00', '', '2024-04-18 17:59:43', 0, NULL, NULL),
(93,    0,  '', '', 'John',    'Smith',     'bobby_jones_foundation', NULL, 'Male', '1985-01-01 00:00:00', 40, 0, 0, 'john@opalmedapps.ca', 'EN', '', '3', '2025-01-01 00:00:00', '2025-01-01 00:00:00', 0, '', '0000-00-00 00:00:00', '', '2025-02-13 17:59:43', 1, 1,	DATE_ADD(NOW(), INTERVAL -1 YEAR));

UPDATE `Patient` SET `Age` = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), `DateOfBirth`)), '%Y') + 0 where PatientSerNum <> 92;

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(51,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(52,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(53,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(55,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(59,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(92,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(93,	1,	'2025-02-13 00:56:01',	'2025-02-13 08:56:01',	0);

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(1,	51,	'ODH',	'9999996',	1),
(2,	52,	'ODH',	'9999997',	1),
(4,	53,	'ODH',	'9999995',	1),
(6,	55,	'ODH',	'9999993',	1),
(13, 92, 'ODH',	'1092300',	1),
(14, 59, 'ODH',	'9999989',	1),
(15, 93, 'ODH',	'9999994',	1);

INSERT INTO `Users` (`UserSerNum`, `UserType`, `UserTypeSerNum`, `Username`, `Password`, `SessionId`, `LastUpdated`) VALUES
(1,	'Patient',	51,	'QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(2,	'Patient',	52,	'PyKlcbRpMLVm8lVnuopFnFOHO4B3',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(3,	'Patient',	53,	'SipDLZCcOyTYj7O3C8HnWLalb4G3',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(4,	'Patient',	55,	'61DXBRwLCmPxlaUoX6M1MP9DiEl1',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(6,	'Patient',	92,	'a51fba18-3810-4808-9238-4d0e487785c8',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(7,	'Patient',	59,	'mouj1pqpXrYCl994oSm5wtJT3In2',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59'),
(8,	'Patient',	93,	'hIMnEXkedPMxYnXeqNXzphklu4V2',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2025-01-01 16:24:59');
