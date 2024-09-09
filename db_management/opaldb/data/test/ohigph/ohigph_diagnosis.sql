INSERT INTO `Diagnosis` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`, `StageCriteria`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`) VALUES
(3,	53,	1,	'22324',	'C16.9',	'Stomach, NOS',	'',	NULL,	NULL,	'2023-05-12 00:00:00',	'CronJob',	'2023-05-12 16:39:16',	'CronJob'),
(7,	54,	1,	'11431',	'R31.9',	'Hematuria, unspecified',	'',	NULL,	NULL,	'2023-03-02 00:00:00',	'CronJob',	'2023-03-21 16:39:16',	'CronJob');

-- Bart
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -3 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -3 DAY)
WHERE `PatientSerNum` = 53;
-- Lisa
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -7 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE `PatientSerNum` = 54;
