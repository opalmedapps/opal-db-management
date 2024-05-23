-- INSERT INTO `Questionnaire` (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `DateAdded`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `SessionId`, `LastUpdated`) VALUES
-- -- all get: esas-r
-- (1,	NULL,	42,	51,	'2000-01-01 00:00:00',	184,	0,	NULL,	'',	'2000-01-01 00:00:00'),
-- (2,	NULL,	42,	52,	'2000-01-01 00:00:00',	190,	0,	NULL,	'',	'2000-01-01 00:00:00'),
-- (3,	NULL,	42,	53,	'2000-01-01 00:00:00',	207,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- -- marge: breast, preop completed
-- (4,	NULL,	155,	51,	'2000-01-01 00:00:00',	5354,	1,	NULL,	'',	'2000-01-01 00:00:00'),
-- (5,	NULL,	156,	51,	'2000-01-01 00:00:00',	5355,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- -- homer: QOL head and neck
-- (6,	NULL,	108,	52,	'2000-01-01 00:00:00',	3457,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- -- all get databank consent questionnaire except lisa
-- (8,	85504,	157,	51,	'2000-01-01 00:00:00',	5359,	0,	NULL,	'',	'2000-01-01 00:00:00'),
-- (9,	85504,	157,	52,	'2000-01-01 00:00:00',	5360,	0,	NULL,	'',	'2000-01-01 00:00:00'),
-- (10,	85504,	157,	53,	'2000-01-01 00:00:00',	5361,	0,	NULL,	'',	'2000-01-01 00:00:00'),
-- (11,	85504,	157,	55,	'2000-01-01 00:00:00',	5362,	0,	NULL,	'',	'2000-01-01 00:00:00'),
-- (12,	85504,	157,	56,	'2000-01-01 00:00:00',	5363,	0,	NULL,	'',	'2000-01-01 00:00:00'),
-- (13,	85504,	157,	57,	'2000-01-01 00:00:00',	5364,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- -- fred: GAD7
-- (14,	85504,	50,	56,	'2000-01-01 00:00:00',	5365,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- -- add an esas for lisa
-- (15,	NULL,	42,	54,	'2000-01-01 00:00:00',	208,	0,	NULL,	'',	'2000-01-01 00:00:00');

-- -- Update all Questionnaire dates to make the data more similar to a live environment

-- -- ESAS-r sent today
-- UPDATE Questionnaire
-- SET DateAdded = now(),
--     LastUpdated = now()
-- WHERE QuestionnaireControlSerNum = 42;
-- UPDATE Notification
-- SET DateAdded = now(),
--     LastUpdated = now()
-- WHERE NotificationControlSerNum = 13
-- AND RefTableRowSerNum in (1, 2, 3, 15);

-- -- Breast Recon: Preop complete 2 weeks ago; Postop sent 3 days ago
-- UPDATE Questionnaire
-- SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY),
--     CompletionDate = DATE_ADD(now(), INTERVAL -13 DAY)
-- WHERE QuestionnaireControlSerNum = 155;
-- UPDATE Notification
-- SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
-- WHERE NotificationControlSerNum = 13
-- AND RefTableRowSerNum = 4;

-- UPDATE Questionnaire
-- SET DateAdded = DATE_ADD(now(), INTERVAL -3 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -3 DAY)
-- WHERE QuestionnaireControlSerNum = 156;
-- UPDATE Notification
-- SET DateAdded = DATE_ADD(now(), INTERVAL -3 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -3 DAY)
-- WHERE NotificationControlSerNum = 13
-- AND RefTableRowSerNum = 5;

-- -- H&N Quality sent yesterday
-- UPDATE Questionnaire
-- SET DateAdded = DATE_ADD(now(), INTERVAL -1 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -1 DAY)
-- WHERE QuestionnaireControlSerNum = 108;
-- UPDATE Notification
-- SET DateAdded = DATE_ADD(now(), INTERVAL -1 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -1 DAY)
-- WHERE NotificationControlSerNum = 13
-- AND RefTableRowSerNum = 6;

-- -- Databank Consent sent 2 days ago
-- UPDATE Questionnaire
-- SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
-- WHERE QuestionnaireControlSerNum = 157;
-- UPDATE Notification
-- SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
-- WHERE NotificationControlSerNum = 13
-- AND RefTableRowSerNum IN (8, 9, 10, 11, 12, 13);

-- -- GAD7 sent 7 days ago
-- UPDATE Questionnaire
-- SET DateAdded = DATE_ADD(now(), INTERVAL -7 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -7 DAY)
-- WHERE QuestionnaireControlSerNum = 50;
-- UPDATE Notification
-- SET DateAdded = DATE_ADD(now(), INTERVAL -7 DAY),
--     LastUpdated = DATE_ADD(now(), INTERVAL -7 DAY)
-- WHERE NotificationControlSerNum = 13
-- AND RefTableRowSerNum = 14;

-- -- Set Marge's preop notification to `Read` following the insert operation trigger
-- UPDATE Notification
-- SET ReadStatus = 1,
--     ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
-- WHERE
--     PatientSerNum = 51
-- AND NotificationControlSerNum = 13
-- AND RefTableRowSerNum = 4;
