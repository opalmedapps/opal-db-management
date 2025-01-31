-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Dumping data for table OrmsDatabase.Profile: ~32 rows (approximately)
REPLACE INTO `Profile` (`ProfileSer`, `ProfileId`, `Category`, `SpecialityGroupId`, `LastUpdated`) VALUES
(1, 'Oncology PAB', 'PAB', 1, '2020-07-17 00:47:57'),
(2, 'Section A', 'PAB', 1, '2020-07-17 00:50:33'),
(3, 'Section B', 'PAB', 1, '2020-07-17 00:50:33'),
(4, 'Section C', 'PAB', 1, '2020-07-17 00:50:33'),
(5, 'Section D', 'PAB', 1, '2020-07-17 00:50:33'),
(6, 'Section E', 'PAB', 1, '2020-07-17 00:50:33'),
(7, 'Section F', 'PAB', 1, '2020-07-17 00:50:33'),
(8, 'Section G', 'PAB', 1, '2020-07-17 00:50:33'),
(9, 'Section H', 'PAB', 1, '2020-07-17 00:50:33'),
(10, 'Section U', 'PAB', 1, '2020-07-17 00:50:33'),
(15, 'Pharmacy', 'Pharmacy', 1, '2020-07-17 01:58:32'),
(20, 'Receptionist', 'PAB', 1, '2020-07-17 02:12:09'),
(21, 'Oncology Physician', 'Physician', 1, '2020-07-17 02:15:33'),
(22, 'STX 1', 'Treatment Machine', 1, '2020-07-17 02:20:04'),
(23, 'STX 2', 'Treatment Machine', 1, '2020-07-17 02:20:04'),
(24, 'TB 3', 'Treatment Machine', 1, '2020-07-17 02:20:04'),
(25, 'TB 4', 'Treatment Machine', 1, '2020-07-17 02:20:04'),
(26, 'TB 5', 'Treatment Machine', 1, '2020-07-17 02:20:04'),
(27, 'TB 6', 'Treatment Machine', 1, '2020-07-17 02:20:04'),
(28, 'Cyberknife', 'Treatment Machine', 1, '2020-07-17 02:20:04'),
(29, 'CT/MR Sim', 'Treatment Machine', 1, '2020-07-18 04:04:05'),
(30, 'Brachy', 'Treatment Machine', 1, '2020-07-18 04:05:12'),
(31, 'Test Centre', 'PAB', 1, '2020-08-04 16:04:10'),
(32, 'Surgery Receptionist', 'PAB', 3, '2021-04-28 21:35:48'),
(33, 'Surgery Physician', 'Physician', 3, '2021-05-04 21:17:32'),
(34, 'Medicine Receptionist', 'PAB', 2, '2021-05-07 19:03:59'),
(35, 'Medicine Physician', 'Physician', 2, '2021-05-07 19:06:04'),
(36, 'Receptionist (IBD clinic)', 'PAB', 4, '2022-01-24 15:43:39'),
(37, 'IBD Physician', 'Physician', 4, '2022-01-24 15:46:49'),
(39, 'Research Nursing (IBD Clinic)', 'Nurse', 4, '2022-01-24 16:00:29'),
(40, 'Clinical Nursing (IBD Clinic)', 'Nurse', 4, '2022-02-18 19:26:25'),
(41, 'IBD Psychologist', 'Physician', 4, '2022-12-14 16:12:14');
