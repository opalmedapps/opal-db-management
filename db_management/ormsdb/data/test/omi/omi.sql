INSERT INTO `Patient` (`PatientSerNum`, `LastName`, `FirstName`, `DateOfBirth`, `Sex`, `SMSAlertNum`, `SMSSignupDate`, `OpalPatient`, `OpalUUID`, `LanguagePreference`, `LastUpdated`, `SMSLastUpdated`) VALUES
(1,	'Simpson', 'Marge',	'1986-10-01 00:00:00',	'F',	'15144758941',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(2,	'Simpson', 'Homer',	'1983-05-12 00:00:00',	'M',	'14381234567',	NULL,	1, 'aa772608-9501-4799-9b52-661f6eeacc79' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(3,	'Simpson', 'Bart',	'1986-10-01 00:00:00',	'M',	'61292507111',	NULL,	1, '2345e93a-d7f9-49b0-820d-70d0a663753b' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(5,	'Simpson', 'Mona',	'1940-03-15 00:00:00',	'F',	'15144758941',	NULL,	1, 'f8f20abc-ec24-496d-bb8c-25af1853e4fb' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(6,	'Flintstone', 'Fred',	'1960-08-01 00:00:00',	'M',	'15144758941',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(7,	'Flintstone', 'Pebbles',	'2015-02-22 00:00:00',	'F',	'14381234567',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(8,	'Addams', 'Wednesday',	'2009-02-13 00:00:00',	'F',	'14381234567',	NULL,	0, '' ,	NULL,	'2024-02-19 05:26:33',	NULL);


INSERT INTO `PatientHospitalIdentifier` (`PatientHospitalIdentifierId`, `PatientId`, `HospitalId`, `MedicalRecordNumber`, `Active`, `DateAdded`, `LastModified`) VALUES
(1,	1,	1,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(2,	2,	1,	'9999997',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(3,	2,	2,	'9999998',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(4,	3,	3,	'9999996',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(6,	5,	1,	'9999993',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(7,	6,	1,	'9999998',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(8,	7,	3,	'9999999',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(9,	5,	3,	'5407383',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(10, 8,	1,	'9999991',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(11, 1,	4,	'0389731',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58');

-- Note that for every entry in the MediVisitAppointmentList there must be a corresponding entry in SmsAppointments with a matching ClinicResourcesSerNum
--   This is needed for sms functionality in ORMs, and might cause errors with Opal checkins if not added
INSERT INTO `MediVisitAppointmentList` (`PatientSerNum`, `ClinicResourcesSerNum`, `ScheduledDateTime`, `ScheduledDate`, `ScheduledTime`, `AppointmentReminderSent`, `AppointmentCodeId`, `AppointId`, `AppointSys`, `Status`, `MedivisitStatus`, `CreationDate`, `AppointmentSerNum`, `LastUpdated`, `LastUpdatedUserIP`) VALUES
(1, 1312, '2024-01-24 05:30:00', '2024-01-24', '05:30:00', 0, 516, '217542', 'Aria', 'Open',	'Active', '2024-01-24 11:47:30', 1, '2024-01-24 11:48:12', '0.0.0.0'),
(2, 1744, '2023-12-11 08:53:19', '2023-12-11', '08:53:19', 0, 624, '219505', 'Aria', 'Open',	'Active',  '2023-12-11 08:53:19',2, '2023-12-11 08:58:03', '0.0.0.0'),
(3, 1312, '2023-11-24 18:05:00', '2023-11-24', '18:05:00', 0, 507, '209498', 'Aria', 'Open',	'Active', '2023-11-24 16:01:16', 3, '2023-11-24 16:02:03', '0.0.0.0'),
(6, 1088, '2022-12-06 15:50:00', '2022-12-06', '15:50:00', 0, 22, '219506', 'Aria', 'Open',	'Active', '2022-12-06 13:17:50', 6, '2022-12-06 13:47:30', '0.0.0.0'),
(7, 2360, '2022-12-06 13:30:00', '2022-12-06', '13:30:00', 0, 105, '209499', 'Aria', 'Open',	'Active', '2022-12-06 13:24:08', 7, '2022-12-06 13:47:30', '0.0.0.0');
UPDATE MediVisitAppointmentList set ScheduledDateTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 2 hour)));
UPDATE MediVisitAppointmentList set ScheduledDate=current_date();
UPDATE MediVisitAppointmentList set ScheduledTime=TIME(DATE_ADD(now(),interval 2 hour));
