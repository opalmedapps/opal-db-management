INSERT INTO `TxTeamMessage` (`TxTeamMessageSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(1,	NULL,	51,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(2,	NULL,	52,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(3,	NULL,	53,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00');

-- Update all TxTeamMessage dates to make the data more similar to a live environment

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
