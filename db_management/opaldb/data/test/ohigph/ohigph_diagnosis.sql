-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `Diagnosis` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`, `StageCriteria`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`) VALUES
(7,	54,	1,	'11431',	'R31.9',	'Hematuria, unspecified',	'',	NULL,	NULL,	'2023-03-02 00:00:00',	'CronJob',	'2023-03-21 16:39:16',	'CronJob');

-- Lisa
UPDATE `Diagnosis`
SET `CreationDate` = DATE_ADD(now(), INTERVAL -7 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE `PatientSerNum` = 54;
