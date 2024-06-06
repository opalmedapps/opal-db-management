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
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -2 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -2 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -2 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -2 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE PatientSerNum = 51 AND DocumentSerNum = 7;

INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(8,	NULL,	51,	1,	'56190000000000039165514',	8408,	890,	'2023-04-12 10:26:00',	890,	'2023-04-19 10:26:00',	'',	'Y',	'',	'marge_1986Oct01_pathology_2.pdf',	'marge_1986Oct01_pathology_2.pdf',	890,	'2023-04-19 10:27:00',	'T',	'Transfer successful',	'',	'2023-04-20 10:27:00',	0,	'[]',	'2023-04-20 10:27:00');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -12 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -12 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -12 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -12 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -12 DAY)
WHERE PatientSerNum = 51 AND DocumentSerNum = 8;



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


-- Laurie documents
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `SessionId`, `DateAdded`, `ReadBy`, `LastUpdated`) VALUES
(17, NULL, 92, 1, '437600000000000367341521', 32, 727, '2014-07-09 08:40:00', 761, '2014-07-09 08:40:00', '', 'Y', '', '547650.doc', '547650.pdf', 761, '2014-07-09 08:40:00', 'T', 'Transfer successful', 1, '', '2015-12-11 12:39:38', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2017-02-07 14:38:16'),
(18, NULL, 92, 1, '437600000000000367342524', 93, 305, '2016-01-26 14:22:00', 305, '2016-01-26 14:22:00', '', 'Y', '', '688769.pdf', '688769.pdf', 305, '2016-01-26 14:22:00', 'T', 'Transfer successful', 1, '', '2016-01-26 14:51:39', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2016-11-09 16:38:44'),
(19, NULL, 92, 1, '437600000000000367342625', 93, 306, '2016-03-23 15:13:00', 306, '2016-03-23 15:11:00', '', 'Y', '', '703415.pdf', '703415.pdf', 306, '2016-03-23 15:13:00', 'T', 'Transfer successful', 1, '', '2016-03-23 15:24:52', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2016-11-09 16:38:44'),
(20, NULL, 92, 1, '437600000000000367343645', 92, 305, '2016-10-09 19:03:00', 762, '2016-10-05 16:27:00', '', 'Y', '', '751013.pdf', '751013.pdf', 762, '2016-10-05 16:30:00', 'T', 'Transfer successful', 1, '', '2016-10-09 19:05:24', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2017-02-07 14:39:05'),
(21, NULL, 92, 1, '437600000000000367343338', 99, 305, '2016-10-09 20:29:00', 762, '2016-09-29 16:45:00', '', 'Y', '', '749423.pdf', '749423.pdf', 762, '2016-09-29 17:10:00', 'T', 'Transfer successful', 1, '', '2016-10-09 20:30:26', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2017-02-07 14:38:44'),
(22, NULL, 92, 1, '437600000000000367343847', 93, 305, '2016-10-12 17:24:00', 305, '2016-10-12 17:23:00', '', 'Y', '', '752509.pdf', '752509.pdf', 305, '2016-10-12 17:24:00', 'T', 'Transfer successful', 1, '', '2016-10-12 17:25:25', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2016-11-09 16:38:45'),
(23, NULL, 92, 1, '437600000000000367344049', 93, 305, '2016-10-22 12:43:00', 305, '2016-10-22 12:42:00', '', 'Y', '', '755338.pdf', '755338.pdf', 305, '2016-10-22 12:43:00', 'T', 'Transfer successful', 1, '', '2016-10-22 12:45:22', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2016-11-09 16:38:45'),
(24, NULL, 92, 1, '437600000000000367344250', 93, 306, '2016-11-03 22:52:00', 306, '2016-11-03 22:51:00', '', 'Y', '', '758681.pdf', '758681.pdf', 306, '2016-11-03 22:52:00', 'T', 'Transfer successful', 1, '', '2016-11-03 22:55:31', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2016-11-09 16:38:45'),
(25, NULL, 92, 1, '437600000000000367344251', 93, 306, '2016-11-03 22:53:00', 306, '2016-11-03 22:52:00', '', 'Y', '', '758682.pdf', '758682.pdf', 306, '2016-11-03 22:53:00', 'T', 'Transfer successful', 1, '', '2016-11-03 22:55:31', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2016-11-09 16:38:45'),
(26, NULL, 92, 1, '437600000000000367341822', 91, 305, '2014-07-29 13:05:00', 763, '2014-07-25 11:36:00', '', 'Y', '', '551651.pdf', '551651.pdf', 763, '2014-07-25 11:44:00', 'T', 'Transfer successful', 1, '', '2017-02-07 14:32:12', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2017-02-07 14:39:29'),
(27, NULL, 92, 1, '437600000000000367346263', 92, 305, '2018-01-28 21:50:49', 764, '2018-01-28 11:09:13', '', 'Y', '', '877679.pdf', '877679.pdf', 764, '2018-01-28 11:11:23', 'T', 'Transfer successful', 1, '', '2018-01-29 17:02:03', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2018-01-29 17:23:42'),
(28, NULL, 92, 1, '437600000000000367346364', 99, 305, '2018-01-29 14:04:22', 757, '2018-01-23 13:48:00', '', 'Y', '', '877866.pdf', '877866.pdf', 757, '2018-01-29 14:04:32', 'T', 'Transfer successful', 1, '', '2018-01-29 17:20:44', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2018-01-29 17:25:27'),
(29, NULL, 92, 1, '437600000000000367349966', 93, 306, '2019-05-10 09:25:47', 756, '2019-05-10 09:23:29', '', 'Y', '', '1008120.pdf', '1008120.pdf', 756, '2019-05-10 09:25:49', 'T', 'Transfer successful', 1, '', '2019-05-10 09:26:50', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2019-05-10 09:35:10'),
(30, NULL, 92, 1, '4376000000000003673410068', 99, 305, '2019-05-17 10:41:16', 784, '2019-05-16 10:59:26', '', 'Y', '', '1009942.pdf', '1009942.pdf', 784, '2019-05-16 11:24:40', 'T', 'Transfer successful', 1, '', '2019-05-17 10:41:55', '["a51fba18-3810-4808-9238-4d0e487785c8"]' ,'2019-05-17 11:57:44');

-- pathology for laurie
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(31,	NULL,	92,	1,	'4376000000000003673410069',	8408,	890,	'2023-04-12 10:26:00',	890,	'2023-04-19 10:26:00',	'',	'Y',	'',	'Laurie_Hendren_2024-May-31_16-10-34_pathology.pdf',	'Laurie_Hendren_2024-May-31_16-10-34_pathology.pdf',	890,	'2023-04-19 10:27:00',	'T',	'Transfer successful',	'',	'2023-04-20 10:27:00',	1,	'["a51fba18-3810-4808-9238-4d0e487785c8"]',	'2023-04-20 10:27:00');
UPDATE `Document`
SET
`ApprovedTimeStamp` = DATE_ADD(now(), INTERVAL -2205 DAY),
`DateOfService` = DATE_ADD(now(), INTERVAL -2205 DAY),
`CreatedTimeStamp` = DATE_ADD(now(), INTERVAL -2205 DAY),
`DateAdded` = DATE_ADD(now(), INTERVAL -2205 DAY),
`LastUpdated` = DATE_ADD(now(), INTERVAL -2205 DAY)
WHERE PatientSerNum = 92 AND DocumentSerNum = 31;
