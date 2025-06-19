-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
-- rory: treatment guidelines, databank info, lung guidelines
(17,	NULL,	105,	59,	'2023-05-15 08:00:55',	0,	'[]',	'2023-01-12 16:39:17'),
(18,	NULL,	979,	59,	'2023-05-15 08:00:55',	0,	'[]',	'2023-01-12 16:39:17'),
(19,	NULL,	480,	59,	'2023-05-15 08:00:55',	0,	'[]',	'2023-01-12 16:39:17');

-- Treatment guidelines sent 1 day after diagnosis for all

UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -13 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -13 DAY)
WHERE PatientSerNum = 59
AND `EducationalMaterialControlSerNum` = 105;

-- Rory's lung guidelines sent 14 days ago
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -14 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE PatientSerNum IN (59)
AND `EducationalMaterialSerNum` = 19;

-- Remove some notifications
-- Rory has read all their own data
UPDATE `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
AND NotificationControlSerNum = 7;

-- laurie data
INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(20, NULL, 8, 92, '2016-05-06 16:10:21', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-02 10:25:10'),
(21, NULL, 12, 92, '2016-05-06 17:49:11', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-05-16 18:08:10'),
(22, NULL, 10, 92, '2016-06-09 12:20:14', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-21 18:16:39'),
(23, NULL, 13, 92, '2016-06-09 12:20:14', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-21 18:16:17'),
(26, NULL, 179, 92, '2016-06-09 12:45:15', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-16 11:00:30'),
(43, NULL, 208, 92, '2016-10-31 17:00:00', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-11-03 16:05:20'),
(75, NULL, 269, 92, '2017-01-19 13:15:33', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-01-19 14:00:41'),
-- (626, NULL, 640, 92, '2020-01-19 12:31:49', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-01-19 12:32:31'),
(627, NULL, 641, 92, '2020-01-19 13:33:54', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-01-19 13:35:10'),
(785, NULL, 699, 92, '2020-05-08 13:08:40', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-08 13:19:36'),
(1798, NULL, 816, 92, '2020-06-30 09:11:30', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-07-10 10:29:03'),
(2852, NULL, 866, 92, '2020-08-27 11:21:52', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-12-15 01:17:59'),
(3909, NULL, 871, 92, '2020-09-28 16:55:25', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-12-24 14:09:45'),
(13819, NULL, 2341, 92, '2022-09-09 09:22:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-12-19 14:59:58');
-- lauries are all read
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["a51fba18-3810-4808-9238-4d0e487785c8"]'
WHERE PatientSerNum = 92
AND NotificationControlSerNum = 7;

-- Bobby Jones Foundation
INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(100,	NULL,	1000,	93,	'2025-02-18 00:00:00',	0,	'[]',	'2025-02-18 00:00:00'),
(101,	NULL,	1001,	93,	'2025-02-18 00:00:00',	0,	'[]',	'2025-02-18 00:00:00'),
(102,	NULL,	1002,	93,	'2025-02-18 00:00:00',	0,	'[]',	'2025-02-18 00:00:00');

-- Demo Test Data
INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(13823, NULL, 979, 93, '2025-03-05 23:58:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-03-11 08:10:09'),
(13825, NULL, 2349, 94, '2025-03-07 09:50:00', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-03-12 13:34:34'),
(13826, NULL, 2350, 94, '2025-03-07 09:50:04', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-03-12 13:34:32'),
(13827, NULL, 2351, 94, '2025-03-07 09:50:07', 1, '["hIMnEXkedPMxYnXeqNXzphklu4V2"]', '2025-03-11 08:08:11'),
(13832, NULL, 979, 96, '2025-03-12 12:16:01', 1, '["mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-05 11:05:46'),
(13833, NULL, 960, 96, '2025-03-12 12:28:00', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-05 11:05:54'),
(13834, NULL, 105, 96, '2025-03-12 12:42:01', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-05 11:06:05'),
(13835, NULL, 849, 96, '2025-03-12 12:44:00', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-05 11:06:10'),
(13836, NULL, 643, 96, '2025-03-12 12:46:00', 1, '["dR2Cb1Yf0vQb4ywvMoAXw1SxbY93", "mouj1pqpXrYCl994oSm5wtJT3In2", "2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-05 11:06:13'),
(13842, NULL, 979, 99, '2025-05-05 11:50:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2025-05-06 08:27:38'),
(13843, NULL, 979, 100, '2025-05-05 11:50:02', 0, '[]', '2025-05-05 11:50:02'),
(13844, NULL, 979, 101, '2025-05-05 11:50:03', 1, '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-08 10:28:38'),
(13845, NULL, 2370, 99, '2025-05-07 12:50:00', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2025-05-07 13:09:24'),
(13846, NULL, 2371, 99, '2025-05-07 12:50:02', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2025-05-07 13:09:22'),
(13847, NULL, 2379, 99, '2025-05-07 12:50:04', 1, '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]', '2025-05-07 13:09:20'),
(13848, NULL, 2370, 101, '2025-05-07 12:50:05', 1, '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]', '2025-05-07 13:05:49'),
(13849, NULL, 2387, 100, '2025-05-08 16:32:00', 1, '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]', '2025-05-09 08:58:37'),
(13850, NULL, 105, 103, '2025-05-21 13:58:01', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:31'),
(13852, NULL, 979, 103, '2025-05-21 13:58:02', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:39'),
(13853, NULL, 979, 102, '2025-05-21 14:06:00', 1, '["hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:25'),
(13854, NULL, 105, 102, '2025-05-21 14:08:01', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:21'),
(13855, NULL, 960, 102, '2025-05-21 14:08:01', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:12:23'),
(13856, NULL, 849, 102, '2025-05-21 14:10:01', 1, '["OPWj4Cj5iRfgva4b3HGtVGjvuk13", "hSJdAae7xWNwnemd2YypQSVfoOb2"]', '2025-05-21 15:13:22');

-- DatabankConsent study sent to all 1 day ago
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -1 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -1 DAY)
WHERE `EducationalMaterialControlSerNum` = 979;

-- Set all other educational material sent 2 weeks ago
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -14 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -14 DAY)
WHERE `EducationalMaterialControlSerNum` NOT IN (979, 105, 480);
