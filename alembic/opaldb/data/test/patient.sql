-- TODO: can we remove the ProfileImage?

INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(51,	45676,	'9999996',	'',	'TEST',	'TRANSITION',	'Testy McTest',	NULL,	'Female',	'1973-01-16 00:00:00',	48,	5144758941,	0,	'muhc.app.mobile@gmail.com',	'FR',	'OTES01161973',	'3',	'2018-01-01 00:00:00',	'2019-01-01 00:00:00',	0,	'',	'0000-00-00 00:00:00',	'eyJhbGciOiJSUzI1NiIsImtpZCI6ImFlNTJiOGQ4NTk4N2U1OWRjYWM2MmJlNzg2YzcwZTAyMDcxN2I0MTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmlyZWJhc2UtYnJpbGxpYW50LWluZmVybm8tNzY3IiwiYXVkIjoiZmlyZWJhc2UtYnJpbGxpYW50LWluZmVybm8tNzY3IiwiYXV0aF90aW1lIjoxNjMyNDM0ODMxLCJ1c2VyX2lkIjoiMXpkaTQ1ZVdqUGhjMGxIUnlqTXRWVjlnR2hIMyIsInN1YiI6IjF6ZGk0NWVXalBoYzBsSFJ5ak10VlY5Z0doSDMiLCJpYXQiOjE2MzI0MzQ4MzEsImV4cCI6MTYzMjQzODQzMSwiZW1haWwiOiJhcHBsaW9wYWxAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiYXBwbGlvcGFsQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.Q_Pwg-6J4ZcOngkJrntEWfXg_e_CvB0YhfX_1CTrdh0ZZigfCyuM7xYtb4WNkbZcqsCxO6teePT2HerRthSEu4TV6P0pTAfIY12cEnxL0aqlsjqC--Cq3H39L9DkS8E80saMMXChnF98y9UPZ_bFazLMaFiO8_6s12X6xQkw0-kXCC7dBmmtoLl69LlrOnc_Ih4Ly7GVAXfE1weCdjMkReOPmp2g81SO_clJ78WfWP8Jz8XWbZFIC_y-W2sak9qP9W2TZxzVy0ye6bZabPCIYXtPPx65DCV3cONkI9x0eC-FkuPbJ7dMxXs0J1KKTPMqQPmNGoLFS_bsihOnyQT4Ng',	'2021-09-24 02:07:40',	0,	NULL,	NULL);

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(51,	1,	'2021-09-30 00:56:01',	'2021-09-30 08:56:01',	0);

INSERT INTO `PatientDoctor` (`PatientDoctorSerNum`, `PatientSerNum`, `DoctorSerNum`, `OncologistFlag`, `PrimaryFlag`, `LastUpdated`) VALUES
(1,	51,	4,	1,	1,	'2016-04-27 22:13:02'),
(2,	51,	5,	0,	0,	'2015-08-12 01:23:49'),
(3,	51,	6,	0,	0,	'2015-08-12 01:23:49'),
(4,	51,	7,	0,	1,	'2015-08-12 01:23:49'),
(5,	51,	8,	0,	0,	'2015-08-12 01:23:49');

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(1,	51,	'RVH',	'9999996',	1);

INSERT INTO `SecurityAnswer` (`SecurityAnswerSerNum`, `SecurityQuestionSerNum`, `PatientSerNum`, `AnswerText`, `CreationDate`, `LastUpdated`) VALUES
(159,	1,	51,	'5ed4c7167f059c5b864fd775f527c5a88794f9f823fea73c6284756b31a08faf6f9f950473c5aa7cdb99c56bc7807517fe4c4a0bd67318bcaec508592dd6d917',	'2018-11-08 12:37:55',	'2020-12-07 00:46:00'),
(160,	2,	51,	'f3b49c229cc474b3334dd4a3bbe827a866cbf6d6775cde7a5c42da24b4f15db8c0e564c4ff20754841c2baa9dafffc2caa02341010456157b1de9b927f24a1e6',	'2018-11-08 12:38:23',	'2019-01-11 02:45:19'),
(161,	5,	51,	'a7dbabba9a0371fbdb92724a5ca66401e02069089b1f3a100374e61f934fe9e959215ae0327de2bc064a9dfc351c4d64ef89bd47e95be0198a1f466c3518cc1d',	'2018-11-08 12:38:47',	'2019-01-11 02:45:32');

-- QSCCD-108: Insert testing data for multi-patient appointments
INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`)
VALUES
    (52, 45676, '9999997', '', 'aaa', 'bbb', 'Testy McTest', NULL, 'M', '1985-01-01 00:00:00', 38, 11234567890, 0, 'ccc@ccc.com', 'EN', 'TESC53511613', '3', '2023-01-13 14:40:28', '2024-01-13 14:40:28', 0, '', '0000-00-00 00:00:00', 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImY1NWU0ZDkxOGE0ODY0YWQxMzUxMDViYmRjMDEwYWY5Njc5YzM0MTMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3BhbGZpcmViYXNlLWRkZDY3IiwiYXVkIjoib3BhbGZpcmViYXNlLWRkZDY3IiwiYXV0aF90aW1lIjoxNjczODM4NTU5LCJ1c2VyX2lkIjoiVGhRS2Nrb2xsMlkzdFhjQTFrN2lDZkdobWV1MSIsInN1YiI6IlRoUUtja29sbDJZM3RYY0ExazdpQ2ZHaG1ldTEiLCJpYXQiOjE2NzM4Mzg1NTksImV4cCI6MTY3Mzg0MjE1OSwiZW1haWwiOiJiYmJAYmJiLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJiYmJAYmJiLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.bmB-VA0hVHheTE_FMcbUHQV5kDCFTa5ejL_7KYrPILlBSHn6iNCQKBABNAGkXnxGjUaV0r6O0Cu2d9EF2MbJ3mZMhag8EbNf-nRRmn83i-4NKpFamzvVCbVtciz6mxLUxTArkGPhmmkej8-IcvOuxWab3JIaxx_7KsNyzVDp6Ibxirr0ooOtqPvQc9EDZffMxIYrtIaKJiHptgYl3_uqomXqmaycF-v2dMzYe0_MJWFRpT-6RbOakO9tM0OVRULS8r7Vuj9Q2pwKIu30RYq1X0bmUPEmy_u3zzMAGDslvLUNEOst3yt1_kmHGXsvXedS9zq6ah6KNlQV8NiHlBW1lw', '2023-01-19 20:45:48', 0, 1, '2023-01-13 14:40:28');
