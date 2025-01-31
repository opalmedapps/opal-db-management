-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `Diagnosis` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`, `StageCriteria`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`) VALUES
(4,	56,	1,	'22325',	'C34.10',	'Upper lobe, lung',	'',	NULL,	NULL,	'2023-05-12 00:00:00',	'CronJob',	'2023-05-12 16:39:16',	'CronJob'),
(5,	57,	1,	'22326',	'C69.6a',	'Orbit, NOS',	'',	NULL,	NULL,	'2023-05-12 00:00:00',	'CronJob',	'2023-05-12 16:39:16',	'CronJob'),
(6,	58,	1,	'39325',	'C71.9',	'Ca of brain, unspecified',	'',	NULL,	NULL,	'2022-02-12 00:00:00',	'CronJob',	'2022-02-12 16:39:16',	'CronJob');
-- Fred
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -7 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE `PatientSerNum` = 56;
-- Pebbles
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -7 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE `PatientSerNum` = 57;
-- Wednesday
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -7 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE `PatientSerNum` = 58;
