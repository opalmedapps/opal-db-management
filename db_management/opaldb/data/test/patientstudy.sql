-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `patientStudy` (`ID`, `patientId`, `studyId`, `consentStatus`, `readStatus`, `lastUpdated`) VALUES
(1,	51,	1,	1,	0,	'2023-01-12 16:39:16'),
(2,	52,	2,	1,	1,	'2023-01-12 16:39:16'),
(3,	53,	3,	2,	1,	'2023-01-12 16:39:16'),
(4,	51,	4,	3,	1,	'2023-01-12 16:39:16'),
(5,	52,	5,	4,	1,	'2023-01-12 16:39:16'),
(6,	53,	6,	1,	0,	'2023-01-12 16:39:16'),
(7,	51,	7,	1,	0,	'2023-01-12 16:39:16'),
-- test databank consent study for all simpson characters
(8,	51,	8,	1,	0,	'2023-09-22 14:42:00'),
(9,	52,	8,	1,	0,	'2023-09-22 14:42:00'),
(10,	55,	8,	1,	0,	'2023-09-22 14:42:00'),
(12,	53,	8,	1,	0,	'2023-09-22 14:42:00'),
-- finalized databank consent
(13,	55,	9,	1,	0,	'2023-12-20 13:56:47'),
(15,	53,	9,	1,	0,	'2023-12-20 13:56:47'),
(16,	56,	9,	1,	0,	'2023-12-20 13:56:47'),
(17,	51,	9,	1,	0,	'2023-12-20 13:56:47'),
(18,	52,	9,	1,	0,	'2023-12-20 13:56:47'),
(19,	57,	9,	1,	0,	'2023-12-20 13:56:47');
