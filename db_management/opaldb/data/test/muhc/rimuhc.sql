-- additional records for secondary test patient family (Flintstones)
INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(56,	0,	'',	'',	'Fred',	'Flintstone',	'fred_test',	NULL,	'Male',	'1960-08-01 00:00:00',	0,	15144758941,	0,	'fred@opalmedapps.ca',	'EN',	'FLIF60080199',	'3',	DATE_ADD(NOW(), INTERVAL -2 MONTH),	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	1,	DATE_ADD(NOW(), INTERVAL -2 MONTH)),
(57,	0,	'',	'',	'Pebbles',	'Flintstone',	'pebbles_test',	NULL,	'Female',	'2015-02-22 00:00:00',	0,	14381234567,	0,	'pebbles@opalmedapps.ca',	'EN',	'FLIP15022299',	'3',	DATE_ADD(NOW(), INTERVAL -1 MONTH),	'2019-01-01 00:00:00',	1,	'',	'0000-00-00 00:00:00',	'',	'2023-05-25 00:00:00',	1,	NULL,	NULL);
UPDATE `Patient` SET `Age` = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), `DateOfBirth`)), '%Y') + 0;

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(56,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0),
(57,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0);

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(7, 56, 'RVH',  '9999998',  1),
(9,	57,	'MCH',	'9999999',	1);

INSERT INTO `Users` (`UserSerNum`, `UserType`, `UserTypeSerNum`, `Username`, `Password`, `SessionId`, `LastUpdated`) VALUES
(5,	'Patient',	56,	'ZYHAjhNy6hhr4tOW8nFaVEeKngt1',	'c9a29c53a3c5b4339ba51352e16ebbe797aeaa0d574c1724aa1779535ae2ede216328dca4d754c40841b49719a6ff5e1554fa7a14da7567f1a9d7b905bf95aab',	'',	'2021-08-10 16:24:59');

-- Documents: Pathology && Clinical Notes
-- Filestore must have these pdfs inserted separately (and readable by the listener) for the chart Clinical Reports section to function properly

-- Fred Pathology
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(12,	NULL,	56,	1,	'56190000000000039165518',	8408,	890,	'2023-11-03 12:35:00',	890,	'2023-11-03 12:35:00',	'',	'Y',	'',	'fred_2023Nov03_pathology_rvh.pdf',	'fred_2023Nov03_pathology_rvh.pdf',	890,	'2023-11-03 14:35:00',	'T',	'Transfer successful',	'',	'2023-11-03 14:35:00',	0,	'[]',	'2023-11-03 14:35:00');
-- Pebbles Pathology
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(13,	NULL,	57,	1,	'56190000000000039165519',	8408,	890,	'2023-10-29 12:35:00',	890,	'2023-10-29 12:35:00',	'',	'Y',	'',	'pebbles_2023Oct29_pathology_mch.pdf',	'pebbles_2023Oct29_pathology_mch.pdf',	890,	'2023-10-29 14:35:00',	'T',	'Transfer successful',	'',	'2023-10-29 14:35:00',	0,	'[]',	'2023-10-29 14:35:00');


-- We add those records here to manually insert `Clinical Notes` documents for hospital-specific `muhc` demo purposes
-- Pebbles Note
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(14,	NULL,	57,	1,	'56190000000000039165520',	99,	891,	'2023-10-14 12:36:00',	891,	'2023-10-14 12:36:00',	'',	'Y',	'',	'pebbles_2023Oct14_note_mch.pdf',	'pebbles_2023Oct14_note_mch.pdf',	891,	'2023-10-14 15:36:00',	'T',	'Transfer successful',	'',	'2023-10-14 15:36:00',	0,	'[]',	'2023-10-14 15:36:00');
-- Fred Note
INSERT INTO `Document` (`DocumentSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `SessionId`, `DateAdded`, `ReadStatus`, `ReadBy`, `LastUpdated`) VALUES
(15,	NULL,	56,	1,	'56190000000000039165521',	99,	892,	'2023-10-21 12:35:00',	892,	'2023-10-21 12:35:00',	'',	'Y',	'',	'fred_2023Oct21_note_rvh.pdf',	'fred_2023Oct21_note_rvh.pdf',	892,	'2023-10-21 15:35:00',	'T',	'Transfer successful',	'',	'2023-10-21 15:35:00',	0,	'[]',	'2023-10-21 15:35:00');
