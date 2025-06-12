-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Fake patients used for testing the SQL scripts to avoid violating foreign key constraints

USE OpalDB;

INSERT INTO `Patient` (
    `PatientSerNum`,
    `FirstName`,
    `LastName`,
    `Sex`,
    `DateOfBirth`,
    `Email`,
    `Language`,
    `SSN`,
    `TestUser`
)
WITH RECURSIVE numbers AS (
    SELECT 1 as n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 200
)
SELECT
    n,
    'First Name',
    CONCAT('Test ', n),
    'Female',
    NOW(),
    CONCAT('email', n, '@test.com'),
    'EN',
    CONCAT('SSN', n),
    1
FROM numbers;
