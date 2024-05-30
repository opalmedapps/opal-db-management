INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
-- all get: treatment guidelines,
(1,	NULL,	105,	51,	'2023-02-05 08:00:55',	0,	'[]',	'2023-01-12 16:39:17'),
(2,	NULL,	105,	52,	'2023-03-14 08:00:55',	0,	'[]',	'2023-01-12 16:39:17'),
(3,	NULL,	105,	53,	'2023-05-15 08:00:55',	0,	'[]',	'2023-01-12 16:39:17'),

-- marge: intro to breast cancer, covid care guide,fertility preservation for women
(4,	NULL,	960,	51,	'2023-02-15 16:31:26',	0,	'[]',	'2023-01-12 16:39:17'),
(5,	NULL,	849,	51,	'2023-02-21 14:57:18',	0,	'[]',	'2023-01-12 16:39:17'),
(6,	NULL,	643,	51,	'2023-03-30 10:20:11',	0,	'[]',	'2023-01-12 16:39:17'),

-- homer: covid care guide, fertility preservation for men
(7,	NULL,	849,	52,	'2023-03-14 14:57:18',	0,	'[]',	'2023-01-12 16:39:17'),
(8,	NULL,	642,	52,	'2023-04-05 10:11:54',	0,	'[]',	'2023-01-12 16:39:17'),

-- fred: fertility preservation for men
(9,	NULL,	642,	56,	'2023-10-05 10:11:54',	0,	'[]',	'2023-01-12 16:39:17'),

-- pebbles: treatment guidelines
(10,	NULL,	105,	57,	'2023-10-15 08:00:55',	0,	'[]',	'2023-01-12 16:39:17'),

-- all get Databank Information and Consent Factsheet
(11,	NULL,	979,	51,	'2024-01-05 08:00:55',	0,	'[]',	'2024-01-05 08:00:55'),
(12,	NULL,	979,	52,	'2024-01-05 08:00:55',	0,	'[]',	'2024-01-05 08:00:55'),
(13,	NULL,	979,	53,	'2024-01-05 08:00:55',	0,	'[]',	'2024-01-05 08:00:55'),
(14,	NULL,	979,	55,	'2024-01-05 08:00:55',	0,	'[]',	'2024-01-05 08:00:55'),
(15,	NULL,	979,	56,	'2024-01-05 08:00:55',	0,	'[]',	'2024-01-05 08:00:55'),
(16,	NULL,	979,	57,	'2024-01-05 08:00:55',	0,	'[]',	'2024-01-05 08:00:55');


-- Treatment guidelines sent 1 day after diagnosis for all
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -6 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -6 DAY)
WHERE PatientSerNum = 51
AND `EducationalMaterialControlSerNum` = 105;

UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -11 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -11 DAY)
WHERE PatientSerNum = 52
AND `EducationalMaterialControlSerNum` = 105;

UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -2 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE PatientSerNum = 53
AND `EducationalMaterialControlSerNum` = 105;

UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -6 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -6 DAY)
WHERE PatientSerNum = 57
AND `EducationalMaterialControlSerNum` = 105;

-- Marge's extra materials sent last week
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -6 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -6 DAY)
WHERE PatientSerNum = 51
AND `EducationalMaterialSerNum` IN (4, 5, 6);

-- Homers extra materials all sent 10 days ago
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -10 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -10 DAY)
WHERE PatientSerNum = 52
AND `EducationalMaterialSerNum` IN (7, 8);

-- Fred's extra materials sent 5 days ago
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -5 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -5 DAY)
WHERE PatientSerNum = 56
AND `EducationalMaterialSerNum` IN (9);

-- DatabankConsent study sent to all 1 day ago
UPDATE `EducationalMaterial`
SET `DateAdded` = DATE_ADD(now(), INTERVAL -1 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -1 DAY)
WHERE `EducationalMaterialControlSerNum` = 979;


-- Remove some notifications
-- Marge read all her own materials
UPDATE  `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE `EducationalMaterialSerNum` IN (1, 4, 5, 6, 11);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (1, 4, 5, 6, 11);
-- Homer and Marge read homer's materials
UPDATE  `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE `EducationalMaterialSerNum` IN (2, 7, 8, 12);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (2, 7, 8, 12);
-- Bart and Marge read his materials
UPDATE  `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["SipDLZCcOyTYj7O3C8HnWLalb4G3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE `EducationalMaterialSerNum` IN (3, 13);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["SipDLZCcOyTYj7O3C8HnWLalb4G3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (3, 13);
-- Fred's data read by Fred
UPDATE  `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE `EducationalMaterialSerNum` IN (9, 15);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (9, 15);
-- Pebbles' data read by Fred
UPDATE  `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE `EducationalMaterialSerNum` IN (10, 16);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (10, 16);


-- laurie data
INSERT INTO `EducationalMaterial` (`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(17, NULL, 8, 92, '2016-05-06 16:10:21', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-02 10:25:10'),
(18, NULL, 12, 92, '2016-05-06 17:49:11', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-05-16 18:08:10'),
(19, NULL, 10, 92, '2016-06-09 12:20:14', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-21 18:16:39'),
(20, NULL, 13, 92, '2016-06-09 12:20:14', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-21 18:16:17'),
(26, NULL, 179, 92, '2016-06-09 12:45:15', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-06-16 11:00:30'),
(43, NULL, 208, 92, '2016-10-31 17:00:00', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2016-11-03 16:05:20'),
(75, NULL, 269, 92, '2017-01-19 13:15:33', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2017-01-19 14:00:41'),
(626, NULL, 640, 92, '2020-01-19 12:31:49', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-01-19 12:32:31'),
(627, NULL, 641, 92, '2020-01-19 13:33:54', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-01-19 13:35:10'),
(785, NULL, 699, 92, '2020-05-08 13:08:40', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-05-08 13:19:36'),
(1798, NULL, 816, 92, '2020-06-30 09:11:30', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-07-10 10:29:03'),
(2852, NULL, 866, 92, '2020-08-27 11:21:52', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-12-15 01:17:59'),
(3909, NULL, 871, 92, '2020-09-28 16:55:25', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2020-12-24 14:09:45'),
(13819, NULL, 2341, 92, '2022-09-09 09:22:05', 1, '["a51fba18-3810-4808-9238-4d0e487785c8"]', '2022-12-19 14:59:58');
