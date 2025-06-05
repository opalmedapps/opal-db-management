-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `Announcement` (`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(11,	NULL,	59,	16,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
(12,	NULL,	59,	23,	'2000-01-01 00:00:00',	0,	'[]',	'2000-01-01 00:00:00'),
-- Add all of Laurie's data, all set to read
(8, NULL, 92, 16, '2016-05-06 17:24:41', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-05-16 18:08:44'),
(9, NULL, 92, 17, '2016-05-06 17:24:41', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-05-16 18:08:30'),
(10, NULL, 92, 20, '2016-11-04 08:00:56', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-11-04 15:50:18'),
(30, NULL, 92, 23, '2017-04-05 12:47:59', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-04-05 16:09:05'),
(195, NULL, 92, 46, '2017-11-30 14:26:48', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-11-30 16:19:47'),
(223, NULL, 92, 51, '2017-12-20 16:41:28', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-12-20 18:25:59'),
(235, NULL, 92, 54, '2018-03-29 12:24:23', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-03-29 13:53:43'),
(263, NULL, 92, 63, '2018-05-15 17:25:41', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-05-15 17:30:59'),
(280, NULL, 92, 82, '2018-08-01 13:54:01', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-08-09 11:07:13'),
(325, NULL, 92, 114, '2018-11-07 11:33:59', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-11-07 14:01:40'),
(360, NULL, 92, 117, '2018-11-07 17:59:46', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-11-07 18:02:46'),
(395, NULL, 92, 118, '2018-11-23 14:31:04', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-11-23 14:31:34'),
(452, NULL, 92, 127, '2018-12-20 17:15:54', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-12-20 18:27:18'),
(535, NULL, 92, 154, '2019-04-18 13:08:50', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2019-04-18 18:37:10'),
(665, NULL, 92, 155, '2019-05-17 17:48:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2019-05-17 17:48:45'),
(2845, NULL, 92, 174, '2019-10-09 08:02:31', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2019-10-09 08:43:43'),
(3948, NULL, 92, 187, '2020-02-07 12:17:55', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-02-07 12:18:25'),
(4739, NULL, 92, 190, '2020-03-04 12:41:31', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-03-04 12:42:31'),
(4740, NULL, 92, 191, '2020-03-04 14:04:46', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-03-04 14:06:26'),
(5576, NULL, 92, 192, '2020-03-16 14:44:06', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-03-16 14:45:28'),
(6486, NULL, 92, 204, '2020-05-08 13:25:06', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-15 14:20:36'),
(7412, NULL, 92, 206, '2020-05-16 11:50:38', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-16 12:44:21'),
(8343, NULL, 92, 236, '2020-12-04 16:12:39', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-12-15 09:25:07'),
(9351, NULL, 92, 288, '2020-12-15 15:17:11', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-12-24 14:07:58'),
(10364, NULL, 92, 316, '2020-12-23 14:45:12', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-12-24 14:08:02'),
(11391, NULL, 92, 667, '2021-04-01 11:07:31', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2021-04-01 11:11:16'),
(12588, NULL, 92, 703, '2021-06-22 11:35:49', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-01-31 12:11:15'),
(13873, NULL, 92, 767, '2021-10-04 11:24:02', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-01-31 12:11:15'),
(15283, NULL, 92, 786, '2022-01-13 08:37:51', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-01-31 12:11:15'),
(16808, NULL, 92, 798, '2022-01-20 13:08:28', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-01-31 12:11:15'),
(18361, NULL, 92, 807, '2022-01-22 18:50:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-01-31 12:11:15'),
(19914, NULL, 92, 821, '2022-03-02 16:16:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-05-03 09:07:45'),
(21571, NULL, 92, 861, '2022-08-02 10:28:04', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-08-14 15:36:47'),
(23760, NULL, 92, 863, '2022-08-15 12:30:04', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2023-03-14 12:17:39'),
(26020, NULL, 92, 1028, '2023-10-20 16:08:02', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2023-10-20 16:08:02'),
(30366, NULL, 92, 1077, '2024-03-04 15:31:02', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2024-03-24 17:20:28'),
(35014, NULL, 92, 1091, '2024-05-27 12:43:02', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2024-05-27 12:43:02'),
(35023, NULL, 92, 1096, '2025-05-08 11:35:07', 0, '[]', '2025-05-08 11:35:07'),
(35024, NULL, 93, 1096, '2025-05-08 11:35:08', 0, '[]', '2025-05-08 11:35:08'),
(35025, NULL, 94, 1096, '2025-05-08 11:35:08', 0, '[]', '2025-05-08 11:35:08'),
(35026, NULL, 95, 1096, '2025-05-08 11:35:09', 0, '[]', '2025-05-08 11:35:09'),
(35027, NULL, 96, 1096, '2025-05-08 11:35:09', 0, '[]', '2025-05-08 11:35:09'),
(35028, NULL, 97, 1096, '2025-05-08 11:35:14', 0, '[]', '2025-05-08 11:35:14'),
(35029, NULL, 98, 1096, '2025-05-08 11:35:14', 0, '[]', '2025-05-08 11:35:14'),
(35030, NULL, 99, 1096, '2025-05-08 11:35:14', 0, '[]', '2025-05-08 11:35:14'),
(35031, NULL, 100, 1096, '2025-05-08 11:35:15', 1, '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]', '2025-05-09 09:02:19'),
(35032, NULL, 101, 1096, '2025-05-08 11:35:16', 0, '[]', '2025-05-08 11:35:16'),
(35034, NULL, 102, 1096, '2025-05-21 14:10:01', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:02'),
(35033, NULL, 103, 1096, '2025-05-21 14:00:01', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:38');

-- lauries are all read
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["a51fba18-3810-4808-9238-4d0e487785c8"]'
WHERE PatientSerNum = 92
AND NotificationControlSerNum = 5;

-- Update all Announcement dates and read statuses to make the data more similar to a live environment
-- Rorys data read by rory
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
  AND NotificationControlSerNum = 5
;

-- "Radiation Oncology will be Closed" sent 2 weeks ago
UPDATE Announcement
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE PostControlSerNum = 17
AND PatientSerNum <> 92
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE NotificationControlSerNum = 5
AND RefTableRowSerNum = 11
AND PatientSerNum <> 92
;

-- "Treatment Delay" sent 2 days ago
UPDATE Announcement
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE PostControlSerNum = 23
AND PatientSerNum <> 92
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE NotificationControlSerNum = 5
AND RefTableRowSerNum = 12
AND PatientSerNum <> 92
;

-- "Road closure notice" sent 2 days ago
UPDATE Announcement
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE PostControlSerNum = 1096
;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE NotificationControlSerNum = 5
AND RefTableRowSerNum <= 35033 and RefTableRowSerNum >= 35014
;
