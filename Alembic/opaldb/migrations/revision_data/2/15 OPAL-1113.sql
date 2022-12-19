DROP TRIGGER if exists legacy_questionnaire_insert_trigger;

CREATE TRIGGER `legacy_questionnaire_insert_trigger` AFTER INSERT ON `Questionnaire` FOR EACH ROW BEGIN

	-- prepared the variables
	DECLARE wsRespondent varchar(50);
	DECLARE wsQuestionnaireControlSerNum INT;

	INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`,
			`DateAdded`, ModificationAction)
	VALUES (NEW.QuestionnaireSerNum, NEW.CronLogSerNum, NEW.QuestionnaireControlSerNum, NEW.PatientSerNum, NEW.PatientQuestionnaireDBSerNum, NEW.CompletedFlag, NEW.CompletionDate,
			NOW(), 'INSERT');

	-- capture the questionnaire control serial number
	SET wsQuestionnaireControlSerNum = NEW.QuestionnaireControlSerNum;

	-- get the type of respondent
	SET wsRespondent =
		(SELECT d.content
      FROM OpalDB.QuestionnaireControl QC,
      	QuestionnaireDB.questionnaire q,
      	QuestionnaireDB.dictionary d,
			QuestionnaireDB.respondent r
      where QC.QuestionnaireDBSerNum = q.ID
      	and QC.QuestionnaireControlSerNum = wsQuestionnaireControlSerNum
         and q.respondentId = r.ID
         and r.title = d.contentId
         and d.languageId = 2
	);

	-- if the respondent is for Patient then insert a record into
	-- the notification table so that it shows up in the Opal app
	IF (wsRespondent = 'Patient') then
		BEGIN
			INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
			SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.QuestionnaireSerNum, NOW(), 0,
						getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'EN') EN, getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'FR') FR
			FROM NotificationControl ntc
			WHERE ntc.NotificationType = 'LegacyQuestionnaire';
		END;
	END IF;

END;
