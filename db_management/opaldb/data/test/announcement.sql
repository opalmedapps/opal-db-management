INSERT INTO `Announcement` (`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(1,	NULL,	51,	16,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(2,	NULL,	51,	20,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(3,	NULL,	51,	17,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(9,	NULL,	52,	16,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(10,	NULL,	52,	20,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(11,	NULL,	52,	17,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(12,	NULL,	52,	23,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00');

-- Update all Announcement dates and read statuses to make the data more similar to a live environment

-- All Announcements and their Notifications marked as read
-- Marge's data read by Marge
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 51
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 51
  AND NotificationControlSerNum = 5
;

-- Homer's data read by Homer and Marge
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 52
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE PatientSerNum = 52
  AND NotificationControlSerNum = 5
;

-- "No radiotherapy treatments" sent 2 weeks ago
UPDATE Announcement
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE PostControlSerNum = 16
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE NotificationControlSerNum = 5
AND RefTableRowSerNum IN (1, 9)
;

-- "International Day of Medical Physics" sent 1 week ago
UPDATE Announcement
SET DateAdded = DATE_ADD(now(), INTERVAL -7 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE PostControlSerNum = 20
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -7 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE NotificationControlSerNum = 5
AND RefTableRowSerNum IN (2, 10)
;

-- "Radiation Oncology will be Closed" sent 5 days ago
UPDATE Announcement
SET DateAdded = DATE_ADD(now(), INTERVAL -5 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -5 DAY)
WHERE PostControlSerNum = 17
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -5 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -5 DAY)
WHERE NotificationControlSerNum = 5
AND RefTableRowSerNum IN (3, 11)
;

-- "Treatment Delay" sent 2 days ago
UPDATE Announcement
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE PostControlSerNum = 23
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE NotificationControlSerNum = 5
AND RefTableRowSerNum = 12
;
