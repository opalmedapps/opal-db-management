INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES

-- marge end of treatment note, follow up
(1,	NULL,	51,	1,	'04690000000000019640101107',	91,	305,	'2023-02-27 13:18:00',	305,	'2023-03-29 13:17:00',	'Y',	'N',	'wrong document',	'442074.pdf',	'442074.pdf',	305,	'2023-04-29 13:17:00',	'T',	'Transfer successful',	'',	'2023-03-16 17:02:13',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17'),
(2,	1136871,	51,	1,	'561900000000000391653634',	5562,	306,	'2023-03-16 12:57:53',	756,	'2023-03-16 12:57:32',	'',	'Y',	'',	'2020Q3/1189865.pdf',	'2020Q3/1189865.pdf',	756,	'2023-03-16 12:57:55',	'T',	'Transfer successful',	'',	'2023-03-16 12:59:32',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17'),

-- homer consultation
(3,	NULL,	52,	1,	'561900000000000391651712',	99,	306,	'2023-03-12 14:08:00',	306,	'2023-03-12 13:56:00',	'Y',	'Y',	'',	'752377.pdf',	'752379.pdf',	306,	'2023-04-12 13:58:00',	'T',	'Transfer successful',	'',	'2023-04-12 14:00:27',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17'),

-- bart consultation
(4,	NULL,	53,	1,	'56190000000000039165510',	99,	306,	'2023-06-01 12:36:00',	756,	'2023-06-08 12:35:00',	'',	'Y',	'',	'677560.pdf',	'677560.pdf',	756,	'2023-06-08 12:36:00',	'T',	'Transfer successful',	'',	'2023-06-09 16:38:26',	1,	'[\"1zdi45eWjPhc0lHRyjMtVV9gGhH3\"]',	'2023-01-12 16:39:17');
