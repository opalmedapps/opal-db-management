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
WHERE `EducationalMaterialSerNum` IN (1, 4, 5, 6);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (1, 4, 5, 6);
-- Homer and Marge read homer's materials
UPDATE  `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE `EducationalMaterialSerNum` IN (2, 7, 8);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (2, 7, 8);
-- Bart and Marge read his materials
UPDATE  `EducationalMaterial`
SET ReadStatus = 1,
    ReadBy = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE `EducationalMaterialSerNum` IN (3);
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["SipDLZCcOyTYj7O3C8HnWLalb4G3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE NotificationControlSerNum = 7
AND RefTableRowSerNum in (3);
