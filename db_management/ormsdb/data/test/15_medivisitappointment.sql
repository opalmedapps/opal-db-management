INSERT INTO `MediVisitAppointmentList` (`PatientSerNum`, `ClinicResourcesSerNum`, `ScheduledDateTime`, `ScheduledDate`, `ScheduledTime`, `AppointmentReminderSent`, `AppointmentCodeId`, `AppointId`, `AppointSys`, `Status`, `MedivisitStatus`, `CreationDate`, `AppointmentSerNum`, `LastUpdated`, `LastUpdatedUserIP`) VALUES
-- (1,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'2023A25734012',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	1,	'2023-01-14 10:32:36',	NULL),
-- (2,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'22377010',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	2,	'2023-01-14 10:32:36',	NULL),
-- (3,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'2023A25734050',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	3,	'2023-01-14 10:32:36',	NULL),
-- (4,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'2023A25734054',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	4,	'2023-01-14 10:32:36',	NULL);
(1, 1312, '2024-01-24 05:30:00', '2024-01-24', '05:30:00', 0, 516, '2779788', 'Aria', 'Open',	'Active', '2024-01-24 11:47:30', 1, '2024-01-24 11:48:12', '172.26.125.218'),
(2, 1744, '2023-12-11 08:53:19', '2023-12-11', '08:53:19', 0, 624, 'ORMS-9999996-RVH-1702302799', 'Aria', 'Open',	'Active',  '2023-12-11 08:53:19',2, '2023-12-11 08:58:03', 'lxvmap42.muhcad.muhcfrd.ca'),
(3, 1312, '2023-11-24 18:05:00', '2023-11-24', '18:05:00', 0, 507, '2755877', 'Aria', 'Open',	'Active', '2023-11-24 16:01:16', 3, '2023-11-24 16:02:03', '172.26.125.218'),
(4, 1312, '2023-11-24 17:45:00', '2023-11-24', '17:45:00', 0, 501, '2755876', 'Aria', 'Open',	'Active', '2023-11-24 15:59:53', 4, '2023-11-24 16:00:38', '172.26.125.218'),
(5, 1312, '2023-11-24 17:30:00', '2023-11-24', '17:30:00', 0, 504, '2755875', 'Aria', 'Open',	'Active', '2023-11-24 15:59:05', 5, '2023-11-24 16:00:19', '172.26.125.218'),
(6, 1088, '2022-12-06 15:50:00', '2022-12-06', '15:50:00', 0, 22, '2022A24957753', 'Medivisit', 'Open',	'Active', '2022-12-06 13:17:50', 6, '2022-12-06 13:47:30', '172.26.125.218'),
(7, 2360, '2022-12-06 13:30:00', '2022-12-06', '13:30:00', 0, 105, '2022A24957816', 'Medivisit', 'Open',	'Active', '2022-12-06 13:24:08', 7, '2022-12-06 13:47:30', '172.26.125.218');
UPDATE MediVisitAppointmentList set ScheduledDateTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 2 hour)));
UPDATE MediVisitAppointmentList set ScheduledDate=current_date();
UPDATE MediVisitAppointmentList set ScheduledTime=TIME(DATE_ADD(now(),interval 2 hour));
