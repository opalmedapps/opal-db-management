-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- TODO: globally applicable?

INSERT INTO `StatusAlias` (`StatusAliasSerNum`, `SourceDatabaseSerNum`, `Name`, `Expression`, `DateAdded`, `LastUpdated`) VALUES
(1,	1,	'Scheduled Time',	'Open',	'2018-02-15 15:20:50',	'2018-02-16 01:20:50'),
(2,	1,	'Completed Time',	'Completed',	'2018-02-15 15:22:02',	'2018-02-16 01:22:02'),
(3,	1,	'Completed Time',	'Manually Completed',	'2018-02-15 15:22:02',	'2018-02-16 01:22:02'),
(4,	1,	'Completed Time',	'Pt. CompltFinish',	'2018-02-15 15:24:29',	'2018-02-16 01:24:29'),
(5,	2,	'Scheduled Time',	'Open',	'2018-02-15 15:24:29',	'2018-02-16 01:24:29'),
(6,	2,	'Completed Time',	'Completed',	'2018-02-15 15:24:58',	'2018-02-16 01:24:58'),
(7,	1,	'Cancelled Time',	'Cancelled- Patient No-Show',	'2018-03-27 12:20:46',	'2018-03-27 20:20:46'),
(8,	1,	'Cancelled Time',	'Cancelled',	'2018-03-27 12:20:46',	'2018-03-27 20:20:46');
