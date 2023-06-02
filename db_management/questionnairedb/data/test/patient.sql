-- NOTE: This data does not need to be run as long as the QuestionnaireDB event
--       `SyncPublishQuestionnaire` is running. This procedure automatically
--       populates the patient and answerQuestionnaire tables every minute.


-- INSERT INTO `patient` (`ID`, `hospitalId`, `externalId`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
(3,	-1,	'51',	0,	'',	'2019-11-05 19:04:14',	'QUESTIONNAIRE_MIGRATION_2019',	'2019-11-06 05:04:14',	'QUESTIONNAIRE_MIGRATION_2019'),
(4,	-1,	'52',	0,	'',	'2023-05-29 11:30:00',	'QUESTIONNAIRE_V2_AUTO_SYNC',	'2023-05-29 15:30:00',	'QUESTIONNAIRE_V2_AUTO_SYNC'),
(5,	-1,	'53',	0,	'',	'2023-05-29 11:30:00',	'QUESTIONNAIRE_V2_AUTO_SYNC',	'2023-05-29 15:30:00',	'QUESTIONNAIRE_V2_AUTO_SYNC'),
(7,	-1,	'55',	0,	'',	'2023-05-29 11:30:00',	'QUESTIONNAIRE_V2_AUTO_SYNC',	'2023-05-29 15:30:00',	'QUESTIONNAIRE_V2_AUTO_SYNC');
