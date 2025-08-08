-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `TxTeamMessage` (`TxTeamMessageSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(7, NULL, 92, 13, '2016-12-29 12:15:33', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-12-29 12:18:18'),
(16, NULL, 92, 22, '2016-12-29 14:25:36', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-12-29 14:37:42'),
(28, NULL, 92, 28, '2017-07-26 11:16:16', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-07-26 14:24:34'),
(58, NULL, 92, 47, '2017-11-30 14:27:22', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-11-30 16:20:33'),
(73, NULL, 92, 52, '2018-01-26 14:27:44', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-01-26 18:55:02'),
(75, NULL, 92, 53, '2018-02-21 09:53:01', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2018-02-21 15:03:57'),
(645, NULL, 92, 201, '2020-04-15 18:22:43', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-02 16:59:56'),
(1773, NULL, 92, 210, '2020-06-30 14:38:46', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-07-02 10:04:21'),
(7205, NULL, 92, 850, '2022-06-20 16:24:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2024-03-24 17:19:54'),
(7206, NULL, 93, 1092, '2025-04-17 13:50:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-04-17 13:50:00'),
(7207, NULL, 94, 1092, '2025-05-14 13:50:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-05-14 13:50:00'),
(7209, NULL, 96, 1092, '2025-04-11 12:16:01', 1, '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-04-11 12:16:01'),
(7210, NULL, 59, 1092, '2025-04-02 14:40:13', 1, '["mouj1pqpXrYCl994oSm5wtJT3In2"]', '2025-04-02 14:40:13'),
(7211, NULL, 99, 1092, '2019-01-10 12:50:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2019-01-10 12:50:00'),
(7212, NULL, 100, 1092, '2025-02-15 15:38:00', 1, '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]', '2025-02-15 15:38:00'),
(7213, NULL, 101, 1092, '2025-04-25 15:38:07', 1, '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-04-25 15:38:07'),
(7214, NULL, 103, 1092, '2025-04-02 13:00:00', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-02 13:00:00'),
(7215, NULL, 102, 1092, '2025-04-11 12:00:00', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-04-11 12:00:00');

-- Update all TxTeamMessage added dates to make the data more similar to a live environment
UPDATE `TxTeamMessage`
SET DateAdded = DATE_ADD(DateAdded, INTERVAL ((WEEK(CURDATE()) - WEEK('2025-06-08')) * 7) DAY),
    LastUpdated = DateAdded;

-- lauries are all read
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["a51fba18-3810-4808-9238-4d0e487785c8"]'
WHERE PatientSerNum = 92
AND NotificationControlSerNum = 4;

UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -14 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE NotificationControlSerNum = 4
AND RefTableRowSerNum >= 7205 and RefTableRowSerNum <= 7215
;
