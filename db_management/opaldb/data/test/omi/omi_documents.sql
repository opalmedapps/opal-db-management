-- Documents: Pathology && Clinical Notes
-- Filestore must have these pdfs inserted separately (and readable by the listener) for the chart Clinical Reports section to function properly

-- Bart
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(5,	NULL,	53,	1,	'56190000000000039165511',	8408,	890,	'2023-08-22 10:35:00',	890,	'2023-08-29 10:35:00',	'',	'Y',	'',	'bart_2009Feb23_pathology.pdf',	'bart_2009Feb23_pathology.pdf',	890,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -5 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -5 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -5 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -5 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -5 DAY)
WHERE PatientSerNum = 53;

-- Homer
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(6,	NULL,	52,	1,	'56190000000000039165512',	8408,	890,	'2022-06-13 9:15:00',	890,	'2022-06-20 09:15:00',	'',	'Y',	'',	'homer_1983May12_pathology.pdf',	'homer_1983May12_pathology.pdf',	890,	'2022-06-20 09:16:00',	'T',	'Transfer successful',	'',	'2023-06-21 9:38:26',	0,	'[]',	'2023-06-21 9:38:26');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -8 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -8 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -8 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -8 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -8 DAY)
WHERE PatientSerNum = 52;

-- Marge
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(7,	NULL,	51,	1,	'56190000000000039165513',	8408,	890,	'2021-11-28 11:52:00',	890,	'2021-12-05 11:52:00',	'',	'Y',	'',	'marge_1986Oct01_pathology_1.pdf',	'marge_1986Oct01_pathology_1.pdf',	890,	'2021-12-05 11:53:00',	'T',	'Transfer successful',	'',	'2021-12-06 11:53:00',	0,	'[]',	'2021-12-06 11:53:00');
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(8,	NULL,	51,	1,	'56190000000000039165514',	8408,	890,	'2023-04-12 10:26:00',	890,	'2023-04-19 10:26:00',	'',	'Y',	'',	'marge_1986Oct01_pathology_2.pdf',	'marge_1986Oct01_pathology_2.pdf',	890,	'2023-04-19 10:27:00',	'T',	'Transfer successful',	'',	'2023-04-20 10:27:00',	0,	'[]',	'2023-04-20 10:27:00');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -2 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -2 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -2 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -2 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE PatientSerNum = 51;


-- We add those records here to manually insert `Clinical Notes` documents for hospital-specific `omi` demo purposes
-- Bart
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(9,	NULL,	53,	1,	'56190000000000039165515',	99,	891,	'2023-08-22 10:35:00',	891,	'2023-08-29 10:35:00',	'',	'Y',	'',	'bart_2009Feb23_note_mch.pdf',	'bart_2009Feb23_note_mch.pdf',	891,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -5 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -5 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -5 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -5 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -5 DAY)
WHERE PatientSerNum = 53;
-- Homer
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(10,	NULL,	52,	1,	'56190000000000039165516',	99,	892,	'2023-08-22 10:35:00',	892,	'2023-08-29 10:35:00',	'',	'Y',	'',	'homer_1983May12_note_mgh.pdf',	'homer_1983May12_note_mgh.pdf',	892,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -3 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -3 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -3 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -3 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -3 DAY)
WHERE PatientSerNum = 52;

-- Marge
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(11,	NULL,	51,	1,	'56190000000000039165517',	99,	893,	'2023-08-22 10:35:00',	893,	'2023-08-29 10:35:00',	'',	'Y',	'',	'marge_1986Oct01_note_rvh.pdf',	'marge_1986Oct01_note_rvh.pdf',	893,	'2023-08-29 10:36:00',	'T',	'Transfer successful',	'',	'2023-08-30 10:36:00',	0,	'[]',	'2023-08-30 10:36:00');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -1 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -1 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -1 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -1 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -1 DAY)
WHERE PatientSerNum = 51;


UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE
    `PatientSerNum` = 51
;
UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["PyKlcbRpMLVm8lVnuopFnFOHO4B3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE
    `PatientSerNum` = 52
;
UPDATE `Document`
SET `ReadStatus` = 1,
    `ReadBy` = '["SipDLZCcOyTYj7O3C8HnWLalb4G3", "QXmz5ANVN3Qp9ktMlqm2tJ2YYBz2"]'
WHERE
    `PatientSerNum` = 53
;
