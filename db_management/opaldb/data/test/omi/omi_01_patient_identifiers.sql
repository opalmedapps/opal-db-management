-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- OPAL MEDICAL INSTITUTION

INSERT INTO `Hospital_Identifier_Type` (`Hospital_Identifier_Type_Id`, `Code`, `ADT_Web_Service_Code`, `Description_EN`, `Description_FR`) VALUES
(1,	'ODH',	'MR_PCS',	'Opal Demo Hospital (ODH)',	"Hôpital démo d\'Opal (HDO)");

-- Test patients used for testing the SQL scripts to avoid violating foreign key constraints
-- (in line with what the insert_test_data command inserts)

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
FROM (
    SELECT 54 AS n UNION ALL
    SELECT 59 UNION ALL
    SELECT 92 UNION ALL
    SELECT 93 UNION ALL
    SELECT 94 UNION ALL
    SELECT 96 UNION ALL
    SELECT 99 UNION ALL
    SELECT 100 UNION ALL
    SELECT 102 UNION ALL
    SELECT 103
) AS numbers;
