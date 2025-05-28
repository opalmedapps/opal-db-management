-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `TxTeamMessage` (`TxTeamMessageSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(4,	NULL,	59,	13,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(7, NULL, 92, 13, '2016-12-29 12:15:33', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-12-29 12:18:18'),
(16, NULL, 92, 22, '2016-12-29 14:25:36', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-12-29 14:37:42'),
(28, NULL, 92, 28, '2017-07-26 11:16:16', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-07-26 14:24:34'),
(58, NULL, 92, 47, '2017-11-30 14:27:22', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-11-30 16:20:33'),
(73, NULL, 92, 52, '2018-01-26 14:27:44', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-01-26 18:55:02'),
(75, NULL, 92, 53, '2018-02-21 09:53:01', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-02-21 15:03:57'),
(645, NULL, 92, 201, '2020-04-15 18:22:43', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-02 16:59:56'),
(1773, NULL, 92, 210, '2020-06-30 14:38:46', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-07-02 10:04:21'),
(7205, NULL, 92, 850, '2022-06-20 16:24:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2024-03-24 17:19:54'),
(7206, NULL, 93, 1092, '2025-03-07 09:56:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-03-07 10:45:55'),
(7207, NULL, 94, 1092, '2025-03-07 09:56:02', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-03-11 08:07:58'),
(7209, NULL, 96, 1092, '2025-03-12 12:14:01', 1, '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-05 11:05:43'),
(7210, NULL, 59, 1092, '2025-03-12 12:48:00', 1, '["mouj1pqpXrYCl994oSm5wtJT3In2"]', '2025-03-12 12:51:31'),
(7211, NULL, 99, 1092, '2025-05-05 11:52:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2025-05-06 08:27:35'),
(7212, NULL, 100, 1092, '2025-05-05 11:52:02', 1, '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]', '2025-05-06 11:39:13'),
(7213, NULL, 101, 1092, '2025-05-05 11:52:02', 1, '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-06 11:42:42'),
(7214, NULL, 103, 1092, '2025-05-21 14:00:01', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:28'),
(7215, NULL, 102, 1092, '2025-05-21 14:10:01', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:06');

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
UPDATE TxTeamMessage
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE PostControlSerNum = 13 and PatientSerNum=59
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE NotificationControlSerNum = 4
AND RefTableRowSerNum IN (4)  and PatientSerNum=59
;
UPDATE TxTeamMessage
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE PostControlSerNum = 1092
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE NotificationControlSerNum = 4
AND RefTableRowSerNum >= 7205 and RefTableRowSerNum <= 7215
;
