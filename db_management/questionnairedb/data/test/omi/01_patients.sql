-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

REPLACE INTO `patient` (`ID`, `hospitalId`, `externalId`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
(9, -1, 92, 0, '', now(), 'TEST_DATA_LAURIE', now(), 'TEST_DATA'),
(10, -1, 59, 0, '', now(), 'TEST_DATA_RORY', now(), 'TEST_DATA'),
(11, -1, 93, 0, '', now(), 'TEST_DATA_JOHN', now(), 'TEST_DATA'),
(12, -1, 94, 0, '', now(), 'TEST_DATA_RICHARD', now(), 'TEST_DATA'),
(13, -1, 96, 0, '', now(), 'TEST_DATA_CARA', now(), 'TEST_DATA'),
(14, -1, 99, 0, '', now(), 'TEST_DATA_VALERIE', now(), 'TEST_DATA'),
(17, -1, 102, 0, '', now(), 'TEST_DATA_KATHY', now(), 'TEST_DATA'),
(18, -1, 103, 0, '', now(), 'TEST_DATA_MIKE', now(), 'TEST_DATA');
