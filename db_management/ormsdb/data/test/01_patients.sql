INSERT INTO `Patient` (`PatientSerNum`, `LastName`, `FirstName`, `DateOfBirth`, `Sex`, `SMSAlertNum`, `SMSSignupDate`, `OpalPatient`, `OpalUUID`, `LanguagePreference`, `LastUpdated`, `SMSLastUpdated`) VALUES
(1,	'AAA',	'BBB',	'1970-01-01 00:00:00',	'M',	NULL,	NULL,	1, 'e64f1dab-c289-4ab4-8672-b9a9a5d9e3c3' ,	NULL,	'2022-05-11 05:26:33',	NULL);


INSERT INTO `PatientHospitalIdentifier` (`PatientHospitalIdentifierId`, `PatientId`, `HospitalId`, `MedicalRecordNumber`, `Active`, `DateAdded`, `LastModified`) VALUES
(1,	1,	1,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58');
