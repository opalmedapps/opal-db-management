INSERT INTO `Questionnaire` (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `DateAdded`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `SessionId`, `LastUpdated`) VALUES
-- all get: esas-r
(1,	1,	42,	51,	'2000-01-01 00:00:00',	184,	0,	NULL,	'',	'2000-01-01 00:00:00'),
(2,	1,	42,	52,	'2000-01-01 00:00:00',	190,	0,	NULL,	'',	'2000-01-01 00:00:00'),
(3,	1,	42,	53,	'2000-01-01 00:00:00',	207,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- marge: breast, preop completed
(4,	1,	155,	51,	'2000-01-01 00:00:00',	5354,	1,	NULL,	'',	'2000-01-01 00:00:00'),
(5,	1,	156,	51,	'2000-01-01 00:00:00',	5355,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- homer: QOL head and neck
(6,	1,	108,	52,	'2000-01-01 00:00:00',	3457,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- all get databank consent questionnaire except lisa
(8,	1,	157,	51,	'2000-01-01 00:00:00',	5359,	0,	NULL,	'',	'2000-01-01 00:00:00'),
(9,	1,	157,	52,	'2000-01-01 00:00:00',	5360,	0,	NULL,	'',	'2000-01-01 00:00:00'),
(10,	1,	157,	53,	'2000-01-01 00:00:00',	5361,	0,	NULL,	'',	'2000-01-01 00:00:00');
-- Update all Questionnaire dates to make the data more similar to a live environment

-- ESAS-r sent today
UPDATE Questionnaire
SET DateAdded = now(),
    LastUpdated = now()
WHERE QuestionnaireControlSerNum = 42;
UPDATE Notification
SET DateAdded = now(),
    LastUpdated = now()
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum in (1, 2, 3);

-- Breast Recon: Preop complete 2 weeks ago; Postop sent 3 days ago
UPDATE Questionnaire
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY),
    CompletionDate = DATE_ADD(now(), INTERVAL -13 DAY)
WHERE QuestionnaireControlSerNum = 155;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum = 4;

UPDATE Questionnaire
SET DateAdded = DATE_ADD(now(), INTERVAL -3 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -3 DAY)
WHERE QuestionnaireControlSerNum = 156;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -3 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -3 DAY)
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum = 5;

-- H&N Quality sent yesterday
UPDATE Questionnaire
SET DateAdded = DATE_ADD(now(), INTERVAL -1 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -1 DAY)
WHERE QuestionnaireControlSerNum = 108;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -1 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -1 DAY)
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum = 6;

-- Databank Consent sent 2 days ago
UPDATE Questionnaire
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE QuestionnaireControlSerNum = 157;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum IN (8, 9, 10);

-- Set Marge's preop notification to `Read` following the insert operation trigger
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE
    PatientSerNum = 51
AND NotificationControlSerNum = 13
AND RefTableRowSerNum = 4;


-- laurie data
INSERT INTO `Questionnaire` (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `DateAdded`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `SessionId`, `LastUpdated`) VALUES
(33, NULL, 3, 92, '2017-10-13 11:23:46', 218, 1, '2017-10-21 13:46:54', '', '2017-10-21 13:46:56'),
(64, NULL, 6, 92, '2018-02-20 15:29:23', 225, 1, '2018-02-24 20:37:17', '', '2018-02-24 20:36:30'),
(67, NULL, 3, 92, '2018-02-21 09:25:48', 234, 1, '2018-03-16 17:10:02', '', '2018-03-16 17:08:45'),
(68, NULL, 4, 92, '2018-02-21 09:25:49', 302, 1, '2018-05-16 14:30:20', '', '2018-05-16 14:27:50'),
(71, NULL, 3, 92, '2018-02-22 00:03:12', 307, 1, '2018-05-16 16:45:24', '', '2018-05-16 16:42:53'),
(72, NULL, 4, 92, '2018-02-22 00:03:13', 301, 1, '2018-05-16 14:29:18', '', '2018-05-16 14:26:47'),
(81, NULL, 7, 92, '2018-03-19 17:42:34', 1036, 1, '2020-05-08 16:15:31', '', '2020-05-08 16:15:32'),
(156, NULL, 7, 92, '2018-04-16 00:03:50', 289, 1, '2018-04-20 17:42:44', '', '2018-04-20 17:40:40'),
(184, NULL, 6, 92, '2018-04-23 00:03:57', 297, 1, '2018-05-10 13:42:33', '', '2018-05-10 13:40:10'),
(195, NULL, 7, 92, '2018-04-30 00:03:56', 295, 1, '2018-05-07 12:10:34', '', '2018-05-07 12:08:15'),
(236, NULL, 4, 92, '2018-06-02 00:01:57', 448, 1, '2019-05-08 15:04:04', '', '2019-05-08 15:04:04'),
(251, NULL, 6, 92, '2018-06-08 07:10:45', 973, 1, '2020-01-16 13:30:23', '', '2020-01-16 13:30:23'),
(256, NULL, 7, 92, '2018-06-11 00:02:05', 1050, 1, '2020-03-11 13:40:57', '', '2020-03-11 13:40:41'),
(278, NULL, 7, 92, '2018-06-25 00:01:40', 499, 1, '2019-06-06 14:19:38', '', '2019-06-06 14:19:38'),
(284, NULL, 4, 92, '2018-07-02 00:01:53', 343, 1, '2018-11-15 15:37:13', '', '2018-11-15 15:38:11'),
(285, NULL, 7, 92, '2018-07-02 00:01:59', 490, 1, '2019-06-04 17:31:31', '', '2019-06-04 20:31:32'),
(296, NULL, 7, 92, '2018-07-09 00:02:27', 345, 1, '2018-11-23 14:09:41', '', '2018-11-23 14:10:28'),
(309, NULL, 6, 92, '2018-07-19 08:53:31', 366, 1, '2018-12-04 11:54:01', '', '2018-12-04 11:54:01'),
(318, NULL, 4, 92, '2018-08-02 00:08:01', 421, 1, '2019-04-04 18:39:55', '', '2019-04-04 18:39:55'),
(326, NULL, 6, 92, '2018-08-08 07:44:14', 334, 1, '2018-10-18 13:46:12', '', '2018-10-18 13:44:46'),
(361, NULL, 7, 92, '2018-11-23 14:26:52', 347, 1, '2018-11-23 14:32:49', '', '2018-11-23 14:33:34'),
(611, NULL, 15, 92, '2019-05-14 14:50:05', 498, 1, '2019-06-06 14:18:38', '', '2019-06-06 14:18:38'),
(739, NULL, 6, 92, '2019-05-22 00:00:00', 842, 1, '2019-10-31 14:52:15', '', '2019-10-31 14:52:16'),
(743, NULL, 12, 92, '2019-05-22 13:27:15', 846, 1, '2019-11-06 08:22:12', '', '2019-11-06 08:22:12'),
(1299, NULL, 26, 92, '2019-10-04 08:47:52', 909, 1, '2019-12-04 14:40:40', '', '2019-12-04 14:40:40'),
(2003, NULL, 24, 92, '2019-11-26 09:41:33', 908, 1, '2019-12-04 14:35:56', '', '2019-12-04 14:39:26');
-- lauries are all read
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["a51fba18-3810-4808-9238-4d0e487785c8"]'
WHERE PatientSerNum = 92
AND NotificationControlSerNum = 13;

