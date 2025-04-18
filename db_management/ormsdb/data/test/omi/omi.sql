-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `Patient` (`PatientSerNum`, `LastName`, `FirstName`, `DateOfBirth`, `Sex`, `SMSAlertNum`, `SMSSignupDate`, `OpalPatient`, `OpalUUID`, `LanguagePreference`, `LastUpdated`, `SMSLastUpdated`) VALUES
(1,	'Simpson', 'Marge',	'1986-10-01 00:00:00',	'F',	'15144758941',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(2,	'Simpson', 'Homer',	'1983-05-12 00:00:00',	'M',	'14381234567',	NULL,	1, 'aa772608-9501-4799-9b52-661f6eeacc79' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(3,	'Simpson', 'Bart',	'1986-10-01 00:00:00',	'M',	'61292507111',	NULL,	1, '2345e93a-d7f9-49b0-820d-70d0a663753b' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(5,	'Simpson', 'Mona',	'1940-03-15 00:00:00',	'F',	'15144758941',	NULL,	1, 'f8f20abc-ec24-496d-bb8c-25af1853e4fb' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(6,	'Flintstone', 'Fred',	'1960-08-01 00:00:00',	'M',	'15144758941',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(7,	'Flintstone', 'Pebbles',	'2015-02-22 00:00:00',	'F',	'14381234567',	NULL,	1, '8586479c-4960-4ade-b534-04b06392f380' ,	NULL,	'2022-05-11 05:26:33',	NULL),
(8,	'Addams', 'Wednesday',	'2009-02-13 00:00:00',	'F',	'14381234567',	NULL,	0, '' ,	NULL,	'2024-02-19 05:26:33',	NULL),
(41050, 'HENDREN', 'LAURIE', '1958-12-13 00:00:00', 'F', '5144415642', '2022-01-21 21:13:32', 1, '8586479c-4960-4ade-b534-04b06392f380', 'English', '2022-05-09 18:06:15', NULL),
(9, "O'Brien", 'Rory', '1972-06-11 00:00:00', 'O', '5557654321', '2022-01-21 21:13:32', 1, '8586479c-4960-4ade-b534-04b06392f380', 'English', '2022-05-09 18:06:15', NULL);



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
(11, 1,	4,	'0389731',	1,	'2022-05-11 01:46:58',	'2022-05-11 01:46:58'),
(12, 41050, 2, '5024737', 1, '2022-01-21 21:13:32', '2022-01-21 21:13:32'),
(13, 41050, 1, '1092300', 1, '2022-01-21 21:13:32', '2022-01-21 21:13:32'),
(14, 9, 1, '9999989', 1, '2022-01-21 21:13:32', '2022-01-21 21:13:32');


-- Note that for every entry in the MediVisitAppointmentList there must be a corresponding entry in SmsAppointments with a matching ClinicResourcesSerNum
--   This is needed for sms functionality in ORMs, and might cause errors with Opal checkins if not added
INSERT INTO `MediVisitAppointmentList` (`PatientSerNum`, `ClinicResourcesSerNum`, `ScheduledDateTime`, `ScheduledDate`, `ScheduledTime`, `AppointmentReminderSent`, `AppointmentCodeId`, `AppointId`, `AppointSys`, `Status`, `MedivisitStatus`, `CreationDate`, `AppointmentSerNum`, `LastUpdated`, `LastUpdatedUserIP`) VALUES
(1, 1312, '2024-01-24 05:30:00', '2024-01-24', '05:30:00', 0, 516, '2024A21342134', 'MEDIVISIT', 'Open',	'Active', '2024-01-24 11:47:30', 1, '2024-01-24 11:48:12', '0.0.0.0'),
(2, 1744, '2023-12-11 08:53:19', '2023-12-11', '08:53:19', 0, 624, '219505', 'Aria', 'Open',	'Active',  '2023-12-11 08:53:19',2, '2023-12-11 08:58:03', '0.0.0.0'),
(3, 1312, '2023-11-24 18:05:00', '2023-11-24', '18:05:00', 0, 507, '209498', 'Aria', 'Open',	'Active', '2023-11-24 16:01:16', 3, '2023-11-24 16:02:03', '0.0.0.0'),
(6, 1088, '2022-12-06 15:50:00', '2022-12-06', '15:50:00', 0, 22, '219506', 'Aria', 'Open',	'Active', '2022-12-06 13:17:50', 6, '2022-12-06 13:47:30', '0.0.0.0'),
(7, 2360, '2022-12-06 13:30:00', '2022-12-06', '13:30:00', 0, 105, '209499', 'Aria', 'Open',	'Active', '2022-12-06 13:24:08', 7, '2022-12-06 13:47:30', '0.0.0.0'),
(9, 1312, '2022-12-06 13:30:00', '2022-12-06', '13:30:00', 0, 137, '5474351E', 'ERDV', 'Completed',	'Active', '2022-12-06 13:24:08', 8, '2022-12-06 13:47:30', '0.0.0.0'),
(9, 1312, '2022-12-06 13:30:00', '2022-12-06', '13:30:00', 0, 138, '5474352E', 'ERDV', 'Open',	'Active', '2022-12-06 13:24:08', 9, '2022-12-06 13:47:30', '0.0.0.0'),
(9, 1312, '2022-12-06 13:30:00', '2022-12-06', '13:30:00', 0, 139, '5474353E', 'ERDV', 'Open',	'Active', '2022-12-06 13:24:08', 10, '2022-12-06 13:47:30', '0.0.0.0');

UPDATE MediVisitAppointmentList set
ScheduledDateTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 2 hour))),
ScheduledDate=current_date(),
ScheduledTime=TIME(DATE_ADD(now(),interval 2 hour));

UPDATE MediVisitAppointmentList set
ScheduledDateTime=DATE_SUB(NOW(), INTERVAL 7 DAY),
ScheduledDate=DATE_SUB(now(),interval 7 day),
ScheduledTime=TIME(DATE_SUB(now(),interval 7 day))
where PatientSerNum=9 and AppointmentSerNum=8;

UPDATE MediVisitAppointmentList set
ScheduledDateTime=DATE_ADD(NOW(), INTERVAL 7 DAY),
ScheduledDate=DATE_ADD(now(),interval 7 day),
ScheduledTime=TIME(DATE_ADD(now(),interval 7 day))
where PatientSerNum=9 and AppointmentSerNum=10;

-- laurie data
INSERT INTO `MediVisitAppointmentList` (`PatientSerNum`, `ClinicResourcesSerNum`, `ScheduledDateTime`, `ScheduledDate`, `ScheduledTime`, `AppointmentReminderSent`, `AppointmentCodeId`, `AppointId`, `AppointSys`, `Status`, `MedivisitStatus`, `CreationDate`, `AppointmentSerNum`, `LastUpdated`, `LastUpdatedUserIP`) VALUES
(41050, 1209, '2016-09-22 10:00:00', '2016-09-22', '10:00:00', 0, 108, '2016A16300611', 'MEDIVISIT', 'Open', NULL, '2016-05-27 00:00:00', 656782, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2016-09-23 15:00:00', '2016-09-23', '15:00:00', 0, 22, '2016A16709725', 'MEDIVISIT', 'Open', NULL, '2016-09-22 00:00:00', 656783, '2022-01-21 19:44:59', NULL),
(41050, 1224, '2016-10-21 08:30:00', '2016-10-21', '08:30:00', 0, 270, '2016A16812608', 'MEDIVISIT', 'Completed', NULL, '2016-10-13 00:00:00', 656784, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2016-11-09 14:00:00', '2016-11-09', '14:00:00', 0, 22, '2016A16814078', 'MEDIVISIT', 'Open', NULL, '2016-10-20 00:00:00', 656785, '2022-01-21 19:44:59', NULL),
(41050, 1224, '2016-11-11 09:15:00', '2016-11-11', '09:15:00', 0, 42, '2016A16814148', 'MEDIVISIT', 'Completed', NULL, '2016-10-20 00:00:00', 656786, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2016-11-22 11:20:00', '2016-11-22', '11:20:00', 0, 23, '2016A16929513', 'MEDIVISIT', 'Open', NULL, '2016-11-11 00:00:00', 656787, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2016-12-01 08:45:00', '2016-12-01', '08:45:00', 0, 22, '2016A16895567', 'MEDIVISIT', 'Open', NULL, '2016-09-22 00:00:00', 656788, '2022-01-21 19:44:59', NULL),
(41050, 1224, '2016-12-02 10:00:00', '2016-12-02', '10:00:00', 0, 42, '2016A16895576', 'MEDIVISIT', 'Completed', NULL, '2016-11-10 00:00:00', 656789, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2016-12-19 12:15:00', '2016-12-19', '12:15:00', 0, 22, '2016A16979200', 'MEDIVISIT', 'Open', NULL, '2016-12-02 00:00:00', 656790, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2016-12-21 10:15:00', '2016-12-21', '10:15:00', 0, 23, '2016A17043941', 'MEDIVISIT', 'Completed', NULL, '2016-12-20 00:00:00', 656791, '2022-01-21 19:44:59', NULL),
(41050, 1221, '2016-12-21 11:15:00', '2016-12-21', '11:15:00', 0, 351, '2016A17043934', 'MEDIVISIT', 'Completed', NULL, '2016-12-20 00:00:00', 656792, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2016-12-27 08:05:00', '2016-12-27', '08:05:00', 0, 22, '2016A16981176', 'MEDIVISIT', 'Completed', NULL, '2016-12-02 00:00:00', 656793, '2022-01-21 19:44:59', NULL),
(41050, 1224, '2016-12-27 10:15:00', '2016-12-27', '10:15:00', 0, 42, '2016A17059128', 'MEDIVISIT', 'Completed', NULL, '2016-12-02 00:00:00', 656794, '2022-01-21 19:44:59', NULL),
(41050, 1221, '2017-01-06 00:00:00', '2017-01-06', '00:00:00', 0, 351, '2016A17061460', 'MEDIVISIT', 'Open', NULL, '2016-12-27 00:00:00', 656795, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2017-01-06 13:45:00', '2017-01-06', '13:45:00', 0, 22, '2016A17054072', 'MEDIVISIT', 'Open', NULL, '2016-12-21 00:00:00', 656796, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2017-01-17 08:35:00', '2017-01-17', '08:35:00', 0, 22, '2017A17068829', 'MEDIVISIT', 'Completed', NULL, '2017-01-03 00:00:00', 656797, '2022-01-21 19:44:59', NULL),
(41050, 1224, '2017-01-18 09:30:00', '2017-01-18', '09:30:00', 0, 42, '2017A17069618', 'MEDIVISIT', 'Completed', NULL, '2017-01-03 00:00:00', 656798, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2017-02-02 10:45:00', '2017-02-02', '10:45:00', 0, 23, '2017A17159039', 'MEDIVISIT', 'Open', NULL, '2017-01-25 00:00:00', 656799, '2022-01-21 19:44:59', NULL),
(41050, 1224, '2017-02-08 13:30:00', '2017-02-08', '13:30:00', 0, 42, '2017A17129720', 'MEDIVISIT', 'Completed', NULL, '2017-01-18 00:00:00', 656800, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2017-02-27 08:45:00', '2017-02-27', '08:45:00', 0, 22, '2017A17214693', 'MEDIVISIT', 'Completed', NULL, '2017-02-07 00:00:00', 656801, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2017-03-31 08:35:00', '2017-03-31', '08:35:00', 0, 22, '2017A1537580', 'MEDIVISIT', 'Open', NULL, '0000-00-00 00:00:00', 656802, '2022-01-21 19:44:59', NULL),
(41050, 1209, '2017-03-31 09:40:00', '2017-03-31', '09:40:00', 0, 108, '2017A1537581', 'MEDIVISIT', 'Open', NULL, '0000-00-00 00:00:00', 656803, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2017-04-07 12:20:00', '2017-04-07', '12:20:00', 0, 23, '2017A17086803', 'MEDIVISIT', 'Completed', NULL, '2017-01-06 00:00:00', 656804, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2017-09-29 11:45:00', '2017-09-29', '11:45:00', 0, 23, '2017A17951602', 'MEDIVISIT', 'Completed', NULL, '2017-04-07 00:00:00', 656805, '2022-01-21 19:44:59', NULL),
(41050, 1170, '2017-09-29 13:25:00', '2017-09-29', '13:25:00', 0, 184, '2017A17951597', 'MEDIVISIT', 'Completed', NULL, '0000-00-00 00:00:00', 656806, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-03-02 12:15:00', '2018-03-02', '12:15:00', 0, 23, '2017A18450919', 'MEDIVISIT', 'Cancelled', NULL, '2017-09-29 00:00:00', 656807, '2022-01-21 19:44:59', NULL),
(41050, 1170, '2018-03-02 13:05:00', '2018-03-02', '13:05:00', 0, 184, '2017A18450908', 'MEDIVISIT', 'Cancelled', NULL, '0000-00-00 00:00:00', 656808, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-05-11 07:15:00', '2018-05-11', '07:15:00', 0, 21, '2018A18874683', 'MEDIVISIT', 'Completed', NULL, '2018-05-10 00:00:00', 656809, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-05-11 09:15:00', '2018-05-11', '09:15:00', 0, 246, '2018A18849425', 'MEDIVISIT', 'Completed', NULL, '2018-04-27 00:00:00', 656810, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-05-17 10:35:00', '2018-05-17', '10:35:00', 0, 23, '2018A18860779', 'MEDIVISIT', 'Open', NULL, '2018-05-08 00:00:00', 656811, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-05-18 11:30:00', '2018-05-18', '11:30:00', 0, 46, '2018A18860759', 'MEDIVISIT', 'Completed', NULL, '2018-05-08 00:00:00', 656812, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-05-24 10:20:00', '2018-05-24', '10:20:00', 0, 23, '2018A18860792', 'MEDIVISIT', 'Open', NULL, '2018-05-08 00:00:00', 656813, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-05-25 09:15:00', '2018-05-25', '09:15:00', 0, 46, '2018A18860769', 'MEDIVISIT', 'Completed', NULL, '2018-05-08 00:00:00', 656814, '2022-01-21 19:44:59', NULL),
(41050, 1079, '2018-05-25 11:15:00', '2018-05-25', '11:15:00', 0, 1, '2018A18880469', 'MEDIVISIT', 'Open', NULL, '2018-05-11 00:00:00', 656815, '2022-01-21 19:44:59', NULL),
(41050, 916, '2018-06-06 09:10:00', '2018-06-06', '09:10:00', 0, 113, '2018A18860650', 'MEDIVISIT', 'Cancelled', NULL, '2018-05-08 00:00:00', 656816, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-06-08 07:30:00', '2018-06-08', '07:30:00', 0, 21, '2018A18929503', 'MEDIVISIT', 'Completed', NULL, '2018-05-08 00:00:00', 656817, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-06-08 09:30:00', '2018-06-08', '09:30:00', 0, 46, '2018A18860825', 'MEDIVISIT', 'Completed', NULL, '2018-05-08 00:00:00', 656818, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-06-15 09:30:00', '2018-06-15', '09:30:00', 0, 21, '2018A18928735', 'MEDIVISIT', 'Completed', NULL, '2018-05-25 00:00:00', 656819, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-06-15 11:45:00', '2018-06-15', '11:45:00', 0, 46, '2018A19006210', 'MEDIVISIT', 'Completed', NULL, '2018-05-25 00:00:00', 656820, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-06-18 07:05:00', '2018-06-18', '07:05:00', 0, 21, '2018A18928744', 'MEDIVISIT', 'Completed', NULL, '2018-05-25 00:00:00', 656821, '2022-01-21 19:44:59', NULL),
(41050, 916, '2018-06-18 08:00:00', '2018-06-18', '08:00:00', 0, 152, '2018A18928526', 'MEDIVISIT', 'Completed', NULL, '2018-05-25 00:00:00', 656822, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-06-21 07:15:00', '2018-06-21', '07:15:00', 0, 21, '2018A18928740', 'MEDIVISIT', 'Completed', NULL, '2018-05-25 00:00:00', 656823, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-06-21 09:30:00', '2018-06-21', '09:30:00', 0, 46, '2018A19028073', 'MEDIVISIT', 'Completed', NULL, '2018-05-25 00:00:00', 656824, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-07-12 09:30:00', '2018-07-12', '09:30:00', 0, 21, '2018A19106166', 'MEDIVISIT', 'Completed', NULL, '2018-07-11 00:00:00', 656825, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-07-12 12:15:00', '2018-07-12', '12:15:00', 0, 46, '2018A19077818', 'MEDIVISIT', 'Completed', NULL, '2018-06-18 00:00:00', 656826, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-07-18 07:05:00', '2018-07-18', '07:05:00', 0, 21, '2018A19068555', 'MEDIVISIT', 'Cancelled', NULL, '2018-07-03 00:00:00', 656827, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-07-19 12:30:00', '2018-07-19', '12:30:00', 0, 46, '2018A19068547', 'MEDIVISIT', 'Completed', NULL, '2018-07-03 00:00:00', 656828, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-08-08 07:30:00', '2018-08-08', '07:30:00', 0, 21, '2018A19112225', 'MEDIVISIT', 'Completed', NULL, '2018-07-13 00:00:00', 656829, '2022-01-21 19:44:59', NULL),
(41050, 916, '2018-08-08 08:30:00', '2018-08-08', '08:30:00', 0, 113, '2018A19105248', 'MEDIVISIT', 'Completed', NULL, '2018-07-11 00:00:00', 656830, '2022-01-21 19:44:59', NULL),
(41050, 1079, '2018-09-07 10:15:00', '2018-09-07', '10:15:00', 0, 165, '2018A19138105', 'MEDIVISIT', 'Completed', NULL, '2018-05-25 00:00:00', 656831, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-10-15 07:50:00', '2018-10-15', '07:50:00', 0, 23, '2018A19308321', 'MEDIVISIT', 'Completed', NULL, '2018-09-07 00:00:00', 656832, '2022-01-21 19:44:59', NULL),
(41050, 916, '2018-10-15 08:50:00', '2018-10-15', '08:50:00', 0, 135, '2018A19308318', 'MEDIVISIT', 'Completed', NULL, '2018-09-07 00:00:00', 656833, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-11-15 10:00:00', '2018-11-15', '10:00:00', 0, 23, '2018A19308344', 'MEDIVISIT', 'Completed', NULL, '2018-09-07 00:00:00', 656834, '2022-01-21 19:44:59', NULL),
(41050, 1079, '2018-11-16 09:00:00', '2018-11-16', '09:00:00', 0, 1, '2018A19308338', 'MEDIVISIT', 'Open', NULL, '2018-09-07 00:00:00', 656836, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-11-20 15:30:00', '2018-11-20', '15:30:00', 0, 22, '2018A19578587', 'MEDIVISIT', 'Open', NULL, '2018-11-16 00:00:00', 656837, '2022-01-21 19:44:59', NULL),
(41050, 916, '2018-11-21 08:10:00', '2018-11-21', '08:10:00', 0, 108, '2018A19578588', 'MEDIVISIT', 'Completed', NULL, '2018-11-16 00:00:00', 656838, '2022-01-21 19:44:59', NULL),
(41050, 1170, '2018-11-23 14:00:00', '2018-11-23', '14:00:00', 0, 184, '2018A19578612', 'MEDIVISIT', 'Completed', NULL, '0000-00-00 00:00:00', 656839, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-12-11 13:00:00', '2018-12-11', '13:00:00', 0, 22, '2018A19666116', 'MEDIVISIT', 'Open', NULL, '2018-10-15 00:00:00', 656840, '2022-01-21 19:44:59', NULL),
(41050, 917, '2018-12-12 13:50:00', '2018-12-12', '13:50:00', 0, 113, '2018A19600575', 'MEDIVISIT', 'Completed', NULL, '2018-10-15 00:00:00', 656841, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-12-17 13:15:00', '2018-12-17', '13:15:00', 0, 247, '2018A19606629', 'MEDIVISIT', 'Completed', NULL, '2018-11-22 00:00:00', 656842, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-12-21 08:50:00', '2018-12-21', '08:50:00', 0, 22, '2018A19701832', 'MEDIVISIT', 'Completed', NULL, '2018-11-16 00:00:00', 656843, '2022-01-21 19:44:59', NULL),
(41050, 1081, '2018-12-21 10:00:00', '2018-12-21', '10:00:00', 0, 103, '2018A19640507', 'MEDIVISIT', 'Completed', NULL, '2018-11-16 00:00:00', 656844, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-12-27 13:30:00', '2018-12-27', '13:30:00', 0, 21, '2018A19698021', 'MEDIVISIT', 'Completed', NULL, '2018-12-14 00:00:00', 656845, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-12-27 15:30:00', '2018-12-27', '15:30:00', 0, 250, '2018A19698022', 'MEDIVISIT', 'Completed', NULL, '2018-12-14 00:00:00', 656846, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2018-12-28 08:45:00', '2018-12-28', '08:45:00', 0, 21, '2018A19731454', 'MEDIVISIT', 'Completed', NULL, '2018-12-27 00:00:00', 656847, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2018-12-28 10:15:00', '2018-12-28', '10:15:00', 0, 47, '2018A19731444', 'MEDIVISIT', 'Completed', NULL, '2018-12-27 00:00:00', 656848, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-01-08 09:20:00', '2019-01-08', '09:20:00', 0, 22, '2018A19693453', 'MEDIVISIT', 'Completed', NULL, '2018-12-14 00:00:00', 656849, '2022-01-21 19:44:59', NULL),
(41050, 916, '2019-01-08 10:20:00', '2019-01-08', '10:20:00', 0, 152, '2018A19693452', 'MEDIVISIT', 'Completed', NULL, '2018-12-14 00:00:00', 656850, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-01-10 13:30:00', '2019-01-10', '13:30:00', 0, 47, '2018A19698026', 'MEDIVISIT', 'Completed', NULL, '2018-12-14 00:00:00', 656851, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-01-17 11:00:00', '2019-01-17', '11:00:00', 0, 22, '2019A19759984', 'MEDIVISIT', 'Completed', NULL, '2019-01-09 00:00:00', 656852, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-01-17 13:00:00', '2019-01-17', '13:00:00', 0, 47, '2019A19759965', 'MEDIVISIT', 'Completed', NULL, '2019-01-09 00:00:00', 656853, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-01-29 09:00:00', '2019-01-29', '09:00:00', 0, 22, '2019A19834567', 'MEDIVISIT', 'Completed', NULL, '2019-01-09 00:00:00', 656854, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-01-29 10:00:00', '2019-01-29', '10:00:00', 0, 353, '2019A19834571', 'MEDIVISIT', 'Completed', NULL, '2019-01-25 00:00:00', 656855, '2022-01-21 19:44:59', NULL),
(41050, 916, '2019-01-29 13:10:00', '2019-01-29', '13:10:00', 0, 113, '2019A19759921', 'MEDIVISIT', 'Completed', NULL, '2019-01-09 00:00:00', 656856, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-01-31 08:45:00', '2019-01-31', '08:45:00', 0, 47, '2019A19759973', 'MEDIVISIT', 'Completed', NULL, '2019-01-09 00:00:00', 656857, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-02-01 08:20:00', '2019-02-01', '08:20:00', 0, 22, '2018A19723084', 'MEDIVISIT', 'Completed', NULL, '2018-12-21 00:00:00', 656858, '2022-01-21 19:44:59', NULL),
(41050, 1081, '2019-02-01 09:30:00', '2019-02-01', '09:30:00', 0, 103, '2018A19723073', 'MEDIVISIT', 'Completed', NULL, '2018-12-21 00:00:00', 656859, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-02-14 07:30:00', '2019-02-14', '07:30:00', 0, 22, '2019A19861532', 'MEDIVISIT', 'Completed', NULL, '2019-02-01 00:00:00', 656860, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-02-14 09:30:00', '2019-02-14', '09:30:00', 0, 47, '2019A19861526', 'MEDIVISIT', 'Completed', NULL, '2019-01-30 00:00:00', 656861, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-02-15 12:50:00', '2019-02-15', '12:50:00', 0, 21, '2018A19761664', 'MEDIVISIT', 'Completed', NULL, '2018-12-17 00:00:00', 656862, '2022-01-21 19:44:59', NULL),
(41050, 1170, '2019-02-15 13:50:00', '2019-02-15', '13:50:00', 0, 184, '2018A19761665', 'MEDIVISIT', 'Completed', NULL, '0000-00-00 00:00:00', 656863, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-03-05 08:00:00', '2019-03-05', '08:00:00', 0, 22, '2019A19861542', 'MEDIVISIT', 'Completed', NULL, '2019-01-30 00:00:00', 656865, '2022-01-21 19:44:59', NULL),
(41050, 916, '2019-03-05 08:50:00', '2019-03-05', '08:50:00', 0, 152, '2019A19940776', 'MEDIVISIT', 'Completed', NULL, '2019-01-30 00:00:00', 656866, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-03-05 13:30:00', '2019-03-05', '13:30:00', 0, 47, '2019A19940773', 'MEDIVISIT', 'Completed', NULL, '2019-02-01 00:00:00', 656867, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-03-22 09:45:00', '2019-03-22', '09:45:00', 0, 22, '2019A19974125', 'MEDIVISIT', 'Completed', NULL, '2019-03-05 00:00:00', 656868, '2022-01-21 19:44:59', NULL),
(41050, 970, '2019-03-22 11:00:00', '2019-03-22', '11:00:00', 0, 103, '2019A19976036', 'MEDIVISIT', 'Completed', NULL, '2019-02-25 00:00:00', 656869, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-03-22 11:45:00', '2019-03-22', '11:45:00', 0, 47, '2019A19974118', 'MEDIVISIT', 'Completed', NULL, '2019-03-05 00:00:00', 656870, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-03-29 11:05:00', '2019-03-29', '11:05:00', 0, 22, '2019A20039919', 'MEDIVISIT', 'Completed', NULL, '2019-03-22 00:00:00', 656871, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-03-29 14:00:00', '2019-03-29', '14:00:00', 0, 47, '2019A20039914', 'MEDIVISIT', 'Completed', NULL, '2019-03-22 00:00:00', 656872, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-04-01 10:15:00', '2019-04-01', '10:15:00', 0, 353, '2019A20067019', 'MEDIVISIT', 'Completed', NULL, '2019-04-01 00:00:00', 656873, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-04-10 08:00:00', '2019-04-10', '08:00:00', 0, 22, '2019A20040478', 'MEDIVISIT', 'Completed', NULL, '2019-03-22 00:00:00', 656874, '2022-01-21 19:44:59', NULL),
(41050, 916, '2019-04-10 10:00:00', '2019-04-10', '10:00:00', 0, 113, '2019A20067024', 'MEDIVISIT', 'Completed', NULL, '2019-03-22 00:00:00', 656875, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-04-12 07:30:00', '2019-04-12', '07:30:00', 0, 21, '2019A20112018', 'MEDIVISIT', 'Completed', NULL, '2019-04-11 00:00:00', 656876, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-04-12 08:30:00', '2019-04-12', '08:30:00', 0, 47, '2019A20040480', 'MEDIVISIT', 'Completed', NULL, '2019-03-22 00:00:00', 656877, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-04-18 10:35:00', '2019-04-18', '10:35:00', 0, 22, '2019A20112063', 'MEDIVISIT', 'Open', NULL, '2019-04-11 00:00:00', 656878, '2022-01-21 19:44:59', NULL),
(41050, 1222, '2019-04-19 09:30:00', '2019-04-19', '09:30:00', 0, 47, '2019A20112061', 'MEDIVISIT', 'Completed', NULL, '2019-04-11 00:00:00', 656879, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-05-01 09:45:00', '2019-05-01', '09:45:00', 0, 22, '2019A20112093', 'MEDIVISIT', 'Completed', NULL, '2019-04-11 00:00:00', 656880, '2022-01-21 19:44:59', NULL),
(41050, 916, '2019-05-01 10:50:00', '2019-05-01', '10:50:00', 0, 113, '2019A20112079', 'MEDIVISIT', 'Completed', NULL, '2019-04-11 00:00:00', 656881, '2022-01-21 19:44:59', NULL),
(41050, 1081, '2019-05-10 09:00:00', '2019-05-10', '09:00:00', 0, 103, '2019A20208082', 'MEDIVISIT', 'Completed', NULL, '2019-05-08 00:00:00', 656882, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-05-17 07:45:00', '2019-05-17', '07:45:00', 0, 23, '2019A20216204', 'MEDIVISIT', 'Completed', NULL, '2019-05-10 00:00:00', 656883, '2022-01-21 19:44:59', NULL),
(41050, 1081, '2019-05-17 09:00:00', '2019-05-17', '09:00:00', 0, 103, '2019A20216185', 'MEDIVISIT', 'Cancelled', NULL, '2019-05-10 00:00:00', 656884, '2022-01-21 19:44:59', NULL),
(41050, 1088, '2019-05-27 08:20:00', '2019-05-27', '08:20:00', 0, 22, '2019A20195148', 'MEDIVISIT', 'Open', NULL, '2019-05-06 00:00:00', 656885, '2022-01-21 19:44:59', NULL),
(41050, 916, '2019-05-27 09:20:00', '2019-05-27', '09:20:00', 0, 135, '2019A20195142', 'MEDIVISIT', 'Open', NULL, '2019-05-06 00:00:00', 656886, '2022-01-21 19:44:59', NULL);
