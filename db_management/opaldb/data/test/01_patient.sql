INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(51,	0,	'',	'',	'Marge',	'Simpson',	'marge_test',	NULL,	'Female',	'1986-10-01 00:00:00',	0,	15144758941,	0,	'marge@opalmedapps.ca',	'EN',	'SIMM86600199',	'3',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(52,	0,	'',	'',	'Homer',	'Simpson',	'homer_test',	NULL,	'Male',	'1983-05-12 00:00:00',	0,	14381234567,	0,	'homer@opalmedapps.ca',	'FR',	'SIMH83051299',	'3',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	1,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(53,	0,	'',	'',	'Bart',	    'Simpson',	'bart_test',	NULL,	'Other',	'2009-02-23 00:00:00',	0,	61292507111,	0,	'bart@opalmedapps.ca',	'EN',	'SIMB13022399',	'1',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(55,	0,	'',	'',	'Mona',	    'Simpson',	'mona_test',	NULL,	'Female',	'1940-03-15 00:00:00',	0,	15144758941,	0,	'mona@opalmedapps.ca',	'FR',	'SIMM40531599',	'1',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	1,	'Deceased',	'2021-05-29 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL);

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
