INSERT INTO `TxTeamMessage` (`TxTeamMessageSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(1,	NULL,	51,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(2,	NULL,	52,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(3,	NULL,	53,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(4,	NULL,	59,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(7, NULL, 92, 13, '2016-12-29 12:15:33', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-12-29 12:18:18'),
(16, NULL, 92, 22, '2016-12-29 14:25:36', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-12-29 14:37:42'),
(28, NULL, 92, 28, '2017-07-26 11:16:16', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-07-26 14:24:34'),
(58, NULL, 92, 47, '2017-11-30 14:27:22', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-11-30 16:20:33'),
(73, NULL, 92, 52, '2018-01-26 14:27:44', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-01-26 18:55:02'),
(75, NULL, 92, 53, '2018-02-21 09:53:01', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-02-21 15:03:57'),
(645, NULL, 92, 201, '2020-04-15 18:22:43', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-02 16:59:56'),
(1773, NULL, 92, 210, '2020-06-30 14:38:46', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-07-02 10:04:21'),
(7205, NULL, 92, 850, '2022-06-20 16:24:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2024-03-24 17:19:54');


-- Update all TxTeamMessage dates and read statuses to make the data more similar to a live environment

-- All TxTeamMessages and their Notifications marked as read
-- Marge's data read by Marge
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 51
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 51
  AND NotificationControlSerNum = 4
;

-- Homer's data read by Homer and Marge
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 52
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 52
  AND NotificationControlSerNum = 4
;

-- Bart's data read by Bart and Marge
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["SipDLZCcOyTYj7O3C8HnWLalb4G3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 53
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["SipDLZCcOyTYj7O3C8HnWLalb4G3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 53
  AND NotificationControlSerNum = 4
;

-- Welcome Message sent 4 weeks ago
UPDATE TxTeamMessage
SET DateAdded = DATE_ADD(now(), INTERVAL -28 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -28 DAY)
WHERE PostControlSerNum = 13
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -28 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -28 DAY)
WHERE NotificationControlSerNum = 4
AND RefTableRowSerNum IN (1, 2, 3)
;

-- lauries are all read
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["a51fba18-3810-4808-9238-4d0e487785c8"]'
WHERE PatientSerNum = 92
AND NotificationControlSerNum = 4;

-- Rory's data read by Rory
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
  AND NotificationControlSerNum = 4
;
