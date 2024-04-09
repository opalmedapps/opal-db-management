INSERT INTO `Appointment` (`AppointmentSerNum`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `CheckinUsername`, `ChangeRequest`, `DateAdded`, `ReadStatus`, `ReadBy`, `SessionId`, `LastUpdated`) VALUES

-- fred
(219506,	37,	NULL,	56,	2,	219506,	0,	4,	'Open',	'Active',	'2023-04-25 14:00:00',	'2023-04-25 14:10:00',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00',	10,	'',	'',	0,	'',	0,	'2021-08-25 10:22:33',	0,	'[]',	'',	'2023-01-12 16:39:17'),

-- pebbles
(209499,	24,	NULL,	57,	2,	209499,	0,	5,	'Open',	'Active',	'2023-06-01 17:00:00',	'2023-06-01 17:10:00',	'0000-00-00 00:00:00',	'0000-00-00 00:00:00',	10,	'',	'',	0,	'',	0,	'2021-06-01 10:46:24',	0,	'[]',	'',	'2023-01-12 16:39:17');

-- Move fred's to later
UPDATE Appointment set ScheduledStartTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 5 hour))) where PatientSerNum=56;
UPDATE Appointment set ScheduledEndTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 7 hour))) where PatientSerNum=56;
UPDATE Appointment set DateAdded=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 1 minute))) where PatientSerNum=56;
-- Move pebbles's to later
UPDATE Appointment set ScheduledStartTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 6 hour))) where PatientSerNum=57;
UPDATE Appointment set ScheduledEndTime=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 8 hour))) where PatientSerNum=57;
UPDATE Appointment set DateAdded=concat(current_date(),' ',TIME(DATE_ADD(now(),interval 1 minute))) where PatientSerNum=57;
