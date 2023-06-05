INSERT INTO `Patient` (`PatientSerNum`, `LastName`, `FirstName`, `DateOfBirth`, `Sex`, `SMSAlertNum`, `SMSSignupDate`, `OpalPatient`, `OpalUUID`, `LanguagePreference`, `LastUpdated`, `SMSLastUpdated`) VALUES
(1,	'AAA',	'BBB',	'1970-01-01 00:00:00',	'M',	NULL,	NULL,	0, '' ,'',	NULL,	'2022-05-11 05:26:33',	NULL);


INSERT INTO `PatientHospitalIdentifier` (`PatientHospitalIdentifierId`, `PatientId`, `HospitalId`, `MedicalRecordNumber`, `Active`, `DateAdded`, `LastModified`) VALUES
(1,	1,	1,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58');
