INSERT INTO `Patient` (`PatientSerNum`, `LastName`, `FirstName`, `DateOfBirth`, `Sex`, `SMSAlertNum`, `SMSSignupDate`, `OpalPatient`, `OpalUUID`, `LanguagePreference`, `LastUpdated`, `SMSLastUpdated`) VALUES
(1,	'Simpson', 'Marge',	'1986-10-01 00:00:00',	'F',	'15144758941',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(3,	'Simpson', 'Bart',	'1986-10-01 00:00:00',	'M',	'61292507111',	NULL,	1, '2345e93a-d7f9-49b0-820d-70d0a663753b' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(4,	'Simpson', 'Lisa',	'2014-05-09 00:00:00',	'F',	'61292507111',	NULL,	1, 'f8f20abc-ec24-496d-bb8c-25af1853e4fb' ,	NULL,	'2022-05-11 05:26:33',	NULL);

INSERT INTO `PatientHospitalIdentifier` (`PatientHospitalIdentifierId`, `PatientId`, `HospitalId`, `MedicalRecordNumber`, `Active`, `DateAdded`, `LastModified`) VALUES
(1,	1,	1,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(4,	3,	3,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(5,	4,	3,	'9999993',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(11, 1,	4,	'0389731',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58');

-- Note that for every entry in the MediVisitAppointmentList there must be a corresponding entry in SmsAppointments with a matching ClinicResourcesSerNum
--   This is needed for sms functionality in ORMs, and might cause errors with Opal checkins if not added
INSERT INTO `MediVisitAppointmentList` (`PatientSerNum`, `ClinicResourcesSerNum`, `ScheduledDateTime`, `ScheduledDate`, `ScheduledTime`, `AppointmentReminderSent`, `AppointmentCodeId`, `AppointId`, `AppointSys`, `Status`, `MedivisitStatus`, `CreationDate`, `AppointmentSerNum`, `LastUpdated`, `LastUpdatedUserIP`) VALUES
(1, 1312, '2024-01-24 05:30:00', '2024-01-24', '05:30:00', 0, 516, '2024A21342134', 'MEDIVISIT', 'Open',	'Active', '2024-01-24 11:47:30', 1, '2024-01-24 11:48:12', '0.0.0.0'),
(3, 1312, '2023-11-24 18:05:00', '2023-11-24', '18:05:00', 0, 507, '209498', 'Aria', 'Open',	'Active', '2023-11-24 16:01:16', 3, '2023-11-24 16:02:03', '0.0.0.0'),
(4, 1312, '2023-11-24 17:45:00', '2023-11-24', '17:45:00', 0, 501, '219507', 'Aria', 'Open',	'Active', '2023-11-24 15:59:53', 4, '2023-11-24 16:00:38', '0.0.0.0');
UPDATE MediVisitAppointmentList set ScheduledDateTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 2 hour)));
UPDATE MediVisitAppointmentList set ScheduledDate=current_date();
UPDATE MediVisitAppointmentList set ScheduledTime=TIME(DATE_ADD(now(),interval 2 hour));
