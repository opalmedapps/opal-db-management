-- We add those records here to manually insert `Clinical Notes` documents  for hospital-specific `chusj` demo purposes
-- ReadBy field can be added to the list separated by comma e.g. [\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]
-- Bart
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(5,	NULL,	53,	1,	'56190000000000039165511',	99,	894,	'2023-06-01 12:36:00',	894,	'2023-06-08 12:35:00',	'',	'Y',	'',	'bart_2009Feb23_note_chusj.pdf',	'bart_2009Feb23_note_chusj.pdf',	894,	'2023-06-08 12:36:00',	'T',	'Transfer successful',	'',	'2023-06-09 16:38:26',	0,	'[]',	'2023-01-12 16:39:17');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -5 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -5 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -5 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -5 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -5 DAY)
WHERE PatientSerNum = 53;

-- Lisa
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(6,	NULL,	54,	1,	'56190000000000039165512',	99,	894,	'2023-06-01 12:36:00',	894,	'2023-06-08 12:35:00',	'',	'Y',	'',	'lisa_2014May09_note_chusj.pdf',	'lisa_2014May09_note_chusj.pdf',	894,	'2023-06-08 12:36:00',	'T',	'Transfer successful',	'',	'2023-06-09 16:38:26',	0,	'[]',	'2023-01-12 16:39:17');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -7 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -7 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -7 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -7 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE PatientSerNum = 54;
