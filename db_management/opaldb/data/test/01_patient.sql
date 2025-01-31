INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(51,	45676,	'9999996',	'',	'Marge',	'Simpson',	'marge_test',	NULL,	'Female',	'1986-10-01 00:00:00',	0,	15144758941,	0,	'marge@opalmedapps.ca',	'EN',	'SIMM86600199',	'3',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(52,	45677,	'9999997',	'',	'Homer',	'Simpson',	'homer_test',	NULL,	'Male',	'1983-05-12 00:00:00',	0,	14381234567,	0,	'homer@opalmedapps.ca',	'FR',	'SIMH83051299',	'3',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	1,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(53,	45678,	'9999998',	'',	'Bart',	    'Simpson',	'bart_test',	NULL,	'Other',	'2009-02-23 00:00:00',	0,	61292507111,	0,	'bart@opalmedapps.ca',	'EN',	'SIMB13022399',	'1',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL),
(55,	45680,	'9999993',	'',	'Mona',	    'Simpson',	'mona_test',	NULL,	'Female',	'1940-03-15 00:00:00',	0,	15144758941,	0,	'mona@opalmedapps.ca',	'FR',	'SIMM40531599',	'1',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	1,	'Deceased',	'2021-05-29 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL);

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

INSERT INTO `SecurityAnswer` (`SecurityQuestionSerNum`, `PatientSerNum`, `AnswerText`, `CreationDate`, `LastUpdated`) VALUES
(1,	55,	'5ed4c7167f059c5b864fd775f527c5a88794f9f823fea73c6284756b31a08faf6f9f950473c5aa7cdb99c56bc7807517fe4c4a0bd67318bcaec508592dd6d917',	'2018-11-08 12:37:55',	'2020-12-07 00:46:00'),
(2,	55,	'f3b49c229cc474b3334dd4a3bbe827a866cbf6d6775cde7a5c42da24b4f15db8c0e564c4ff20754841c2baa9dafffc2caa02341010456157b1de9b927f24a1e6',	'2018-11-08 12:38:23',	'2019-01-11 02:45:19'),
(5,	55,	'a7dbabba9a0371fbdb92724a5ca66401e02069089b1f3a100374e61f934fe9e959215ae0327de2bc064a9dfc351c4d64ef89bd47e95be0198a1f466c3518cc1d',	'2018-11-08 12:38:47',	'2019-01-11 02:45:32');
