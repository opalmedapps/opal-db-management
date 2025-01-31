-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Documents: Pathology && Clinical Notes
-- Filestore must have these pdfs inserted separately (and readable by the listener) for the chart Clinical Reports section to function properly

-- Fred Pathology
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(12,	NULL,	56,	1,	'56190000000000039165518',	8408,	890,	'2023-11-03 12:35:00',	890,	'2023-11-03 12:35:00',	'',	'Y',	'',	'fred_2023Nov03_pathology_rvh.pdf',	'fred_2023Nov03_pathology_rvh.pdf',	890,	'2023-11-03 14:35:00',	'T',	'Transfer successful',	'',	'2023-11-03 14:35:00',	0,	'[]',	'2023-11-03 14:35:00');
-- Pebbles Pathology
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(13,	NULL,	57,	1,	'56190000000000039165519',	8408,	890,	'2023-10-29 12:35:00',	890,	'2023-10-29 12:35:00',	'',	'Y',	'',	'pebbles_2023Oct29_pathology_mch.pdf',	'pebbles_2023Oct29_pathology_mch.pdf',	890,	'2023-10-29 14:35:00',	'T',	'Transfer successful',	'',	'2023-10-29 14:35:00',	0,	'[]',	'2023-10-29 14:35:00');

-- We add those records here to manually insert `Clinical Notes` documents for hospital-specific `omi` demo purposes
-- Pebbles Note
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(14,	NULL,	57,	1,	'56190000000000039165520',	99,	891,	'2023-10-14 12:36:00',	891,	'2023-10-14 12:36:00',	'',	'Y',	'',	'pebbles_2023Oct14_note_mch.pdf',	'pebbles_2023Oct14_note_mch.pdf',	891,	'2023-10-14 15:36:00',	'T',	'Transfer successful',	'',	'2023-10-14 15:36:00',	0,	'[]',	'2023-10-14 15:36:00');
-- Fred Note
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(15,	NULL,	56,	1,	'56190000000000039165521',	99,	892,	'2023-10-21 12:35:00',	892,	'2023-10-21 12:35:00',	'',	'Y',	'',	'fred_2023Oct21_note_rvh.pdf',	'fred_2023Oct21_note_rvh.pdf',	892,	'2023-10-21 15:35:00',	'T',	'Transfer successful',	'',	'2023-10-21 15:35:00',	0,	'[]',	'2023-10-21 15:35:00');

-- Wednesday Pathology
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(16,	NULL,	58,	1,	'56190000000000039165520',	8408,	890,	'2024-02-19 12:35:00',	890,	'2024-02-19 12:35:00',	'',	'Y',	'',	'wednesday_2024Feb19_pathology_rvh.pdf',	'wednesday_2024Feb19_pathology_rvh.pdf',	890,	'2024-02-19 14:35:00',	'T',	'Transfer successful',	'',	'2024-02-19 14:35:00',	0,	'[]',	'2024-02-19 14:35:00');

-- Fred and pebbles 4 days ago
UPDATE `Document`
SET `CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -4 DAY),
    `DateAdded` = DATE_ADD(now(), INTERVAL -4 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -4 DAY)
WHERE `PatientSerNum` IN (56, 57)
;

-- Wednesday 15 days ago
UPDATE `Document`
SET `CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -15 DAY),
    `DateAdded` = DATE_ADD(now(), INTERVAL -15 DAY),
    `LastUpdated` = DATE_ADD(now(), INTERVAL -15 DAY)
WHERE `PatientSerNum` = 58
;


-- pebbles docs read by fred
UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE
    `PatientSerNum` = 57
;

-- freds docs read by fred
UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["ZYHAjhNy6hhr4tOW8nFaVEeKngt1"]'
WHERE
    `PatientSerNum` = 56
;
