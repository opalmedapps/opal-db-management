INSERT INTO `MediVisitAppointmentList` (`PatientSerNum`, `ClinicResourcesSerNum`, `ScheduledDateTime`, `ScheduledDate`, `ScheduledTime`, `AppointmentReminderSent`, `AppointmentCodeId`, `AppointId`, `AppointSys`, `Status`, `MedivisitStatus`, `CreationDate`, `AppointmentSerNum`, `LastUpdated`, `LastUpdatedUserIP`) VALUES
(1,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'2023A25734012',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	1,	'2023-01-14 10:32:36',	NULL),
(2,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'22377010',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	2,	'2023-01-14 10:32:36',	NULL),
(3,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'2023A25734050',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	3,	'2023-01-14 10:32:36',	NULL),
(4,	1,	'2023-06-29 18:09:00',	'2023-06-29',	'18:09:00',	0,	1,	'2023A25734054',	'Medivisit',	'Open',	'Active',	'2023-01-30 00:00:00',	4,	'2023-01-14 10:32:36',	NULL);

UPDATE MediVisitAppointmentList set ScheduledDateTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 2 hour)));
UPDATE MediVisitAppointmentList set ScheduledDate=current_date();
UPDATE MediVisitAppointmentList set ScheduledTime=TIME(DATE_ADD(now(),interval 2 hour));
