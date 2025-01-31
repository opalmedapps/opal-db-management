INSERT INTO `Diagnosis` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`, `StageCriteria`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`) VALUES
(1,	51,	1,	'13956',	'C50.1',	'Ca of central portion of breast',	'',	NULL,	NULL,	'2023-02-01 00:00:00',	'CronJob',	'2023-02-02 16:39:16',	'CronJob'),
(2,	52,	1,	'23314',	'C07',	'Ca of parotid gland',	'',	NULL,	NULL,	'2023-03-02 00:00:00',	'CronJob',	'2023-03-21 16:39:16',	'CronJob'),
(3,	53,	1,	'22324',	'C16.9',	'Stomach, NOS',	'',	NULL,	NULL,	'2023-05-12 00:00:00',	'CronJob',	'2023-05-12 16:39:16',	'CronJob'),
(7,	92,	1,	'22824',	'C50.8',	'Overlapping Ca of  breast',	'',	'IIB',	'T2, pN1a, M0',	'2014-03-12 00:00:00',	'CronJob',	'2018-03-27 12:54:54',	'CronJob'),
(8,	92,	1,	'33208',	'C79.5',	'Secondary Ca of bone and bone marrow',	'',	NULL,	NULL,	'2016-09-28 00:00:00',	'CronJob',	'2016-01-21 18:59:22',	'CronJob'),
(9,	59,	1,	'33209',	'C34.10',	'Upper lobe, lung',	'',	NULL,	NULL,	'2023-05-12 00:00:00',	'CronJob',	'2023-05-12 16:39:16',	'CronJob');

-- Marge
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -7 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE `PatientSerNum` = 51;
-- Homer
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -12 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -12 DAY)
WHERE `PatientSerNum` = 52;
-- Bart
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -3 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -3 DAY)
WHERE `PatientSerNum` = 53;
-- Rory
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -12 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -12 DAY)
WHERE `PatientSerNum` = 59;
