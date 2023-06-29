INSERT INTO `Patient` (`PatientSerNum`, `LastName`, `FirstName`, `DateOfBirth`, `Sex`, `SMSAlertNum`, `SMSSignupDate`, `OpalPatient`, `OpalUUID`, `LanguagePreference`, `LastUpdated`, `SMSLastUpdated`) VALUES
(1,	'Marge',	'Simpson',	'1986-10-01 00:00:00',	'F',	'15144758941',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(2,	'Homer',	'Simpson',	'1983-05-12 00:00:00',	'M',	'14381234567',	NULL,	1, 'aa772608-9501-4799-9b52-661f6eeacc79' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(3,	'Bart',	'Simpson',	'1986-10-01 00:00:00',	'M',	'61292507111',	NULL,	1, '2345e93a-d7f9-49b0-820d-70d0a663753b' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(4,	'Lisa',	'Simpson',	'2014-05-09 00:00:00',	'F',	'61292507111',	NULL,	1, 'f8f20abc-ec24-496d-bb8c-25af1853e4fb' ,	NULL,	'2022-05-11 05:26:33',	NULL);


INSERT INTO `PatientHospitalIdentifier` (`PatientHospitalIdentifierId`, `PatientId`, `HospitalId`, `MedicalRecordNumber`, `Active`, `DateAdded`, `LastModified`) VALUES
(1,	1,	1,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(2,	2,	1,	'9999997',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(3,	2,	2,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(4,	3,	3,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(5,	4,	3,	'9999993',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58');
