-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Legacy (deleted) test patients are kept until all their remaining data in QuestionnaireDB is cleaned up
-- Otherwise, data linked to certain patientIds will be orphaned
REPLACE INTO `patient` (`ID`, `hospitalId`, `externalId`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
(1, -1, 51, 1, '', '2025-01-01 00:00:00', 'TEST_DATA_MARGE_DELETED', '2025-01-01 00:00:00', 'TEST_DATA'),
(2, -1, 52, 1, '', '2025-01-01 00:00:00', 'TEST_DATA_HOMER_DELETED', '2025-01-01 00:00:00', 'TEST_DATA'),
(3, -1, 53, 1, '', '2025-01-01 00:00:00', 'TEST_DATA_BART_DELETED', '2025-01-01 00:00:00', 'TEST_DATA'),
(5, -1, 55, 1, '', '2025-01-01 00:00:00', 'TEST_DATA_MONA_DELETED', '2025-01-01 00:00:00', 'TEST_DATA'),
(6, -1, 56, 1, '', '2025-01-01 00:00:00', 'TEST_DATA_FRED_DELETED', '2025-01-01 00:00:00', 'TEST_DATA'),
(7, -1, 57, 1, '', '2025-01-01 00:00:00', 'TEST_DATA_PEBBLES_DELETED', '2025-01-01 00:00:00', 'TEST_DATA'),
(8, -1, 58, 1, '', '2025-01-01 00:00:00', 'TEST_DATA_WEDNESDAY_DELETED', '2025-01-01 00:00:00', 'TEST_DATA'),

-- Laurie and Rory's patient rows are in reverse order in this database, as opposed to OpalDB.Patient
(9, -1, 92, 0, '', '2025-01-01 00:00:00', 'TEST_DATA_LAURIE', '2025-01-01 00:00:00', 'TEST_DATA'),
(10, -1, 59, 0, '', '2025-01-01 00:00:00', 'TEST_DATA_RORY', '2025-01-01 00:00:00', 'TEST_DATA');

-- Update all timestamps to the current time
UPDATE `patient`
SET
`creationDate` = now(),
`lastUpdated` = now();

-- All remaining patients are synced in order, automatically, via the DB event SyncPublishQuestionnaire that runs periodically
