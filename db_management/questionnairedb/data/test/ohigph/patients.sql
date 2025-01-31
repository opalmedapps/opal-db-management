-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Marge, Bart, Lisa
INSERT INTO `patient` (`ID`, `hospitalId`, `externalId`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
(1,	-1,	51,	0,	'',	'2024-05-10 12:35:11',	'QUESTIONNAIRE_V2_AUTO_SYNC',	'2024-05-10 08:35:11',	'QUESTIONNAIRE_V2_AUTO_SYNC'),
(3,	-1,	53,	0,	'',	'2024-05-10 12:35:11',	'QUESTIONNAIRE_V2_AUTO_SYNC',	'2024-05-10 08:35:11',	'QUESTIONNAIRE_V2_AUTO_SYNC'),
(4,	-1,	54,	0,	'',	'2024-05-10 12:35:11',	'QUESTIONNAIRE_V2_AUTO_SYNC',	'2024-05-10 08:35:11',	'QUESTIONNAIRE_V2_AUTO_SYNC');

UPDATE `patient`
SET
`creationDate` = now(),
`lastUpdated` = now();
