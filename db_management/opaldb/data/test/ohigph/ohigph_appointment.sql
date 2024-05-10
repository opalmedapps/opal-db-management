INSERT INTO `Appointment` (`AppointmentSerNum`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `CheckinUsername`, `ChangeRequest`, `DateAdded`, `ReadStatus`, `ReadBy`, `SessionId`, `LastUpdated`) VALUES

-- marge
-- (217542,	174,	NULL,	51,	2,	217542,	0,	1,	'Open',	'Active',	'2023-04-06 22:00:00',	'2023-04-06 22:10:00',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00',	10,	'',	'',	0,	'',	0,	'2021-08-06 10:40:31',	0,	'[]',	'',	'2023-01-12 16:39:17'),

-- bart
(209498,	147,	NULL,	53,	2,	209498,	0,	3,	'Open',	'Active',	'2023-06-01 17:00:00',	'2023-06-01 17:10:00',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00',	10,	'',	'',	0,	'',	0,	'2021-06-01 10:46:24',	0,	'[]',	'',	'2023-01-12 16:39:17'),

-- lisa consult && follow up
(219506,	8789,	NULL,	54,	2,	219506,	0,	7,	'Completed',	'Active',	'2023-04-25 14:00:00',	'2023-04-25 14:10:00',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00',	10,	'',	'',	1,	'',	0,	'2021-08-25 10:22:33',	1,	'["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]',	'',	'2023-01-12 16:39:17'),
(219507,	9046,	NULL,	54,	2,	219507,	0,	7,	'Open',	'Active',	'2023-04-25 14:00:00',	'2023-04-25 14:10:00',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00',	10,	'',	'',	0,	'',	0,	'2021-08-25 10:22:33',	0,	'[]',	'',	'2023-01-12 16:39:17');

UPDATE Appointment set ScheduledStartTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 2 hour)));
UPDATE Appointment set ScheduledEndTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 3 hour)));
UPDATE Appointment set DateAdded=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 1 minute)));
-- Move bart's to later
UPDATE Appointment set ScheduledStartTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 6 hour))) where PatientSerNum=53;
UPDATE Appointment set ScheduledEndTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 7 hour))) where PatientSerNum=53;
UPDATE Appointment set DateAdded=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 1 minute))) where PatientSerNum=53;
-- Make Lisas consult appointment older
UPDATE Appointment set
ScheduledStartTime=DATE_ADD(now(), INTERVAL -14 DAY),
ScheduledEndTime=DATE_ADD(now(), INTERVAL -14 DAY),
DateAdded=DATE_ADD(now(), INTERVAL -14 DAY)
where PatientSerNum=54
and AppointmentSerNum=219506;
-- Lisas follow up appointment newer and unread
UPDATE Appointment set
ScheduledStartTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 3 hour))),
ScheduledEndTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 4 hour))),
DateAdded=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 1 minute)))
where PatientSerNum=54
and AppointmentSerNum=219507;
