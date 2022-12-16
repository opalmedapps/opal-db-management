ALTER TABLE study 
	ADD COLUMN email VARCHAR(128), 
	CHANGE COLUMN email email VARCHAR(128) COMMENT 'Principal investigator email address of the study. Mandatory.' AFTER investigator,
	ADD COLUMN phone VARCHAR(25),
	CHANGE COLUMN phone phone VARCHAR(25) COMMENT 'Principal investigator phone number of the study. Mandatory.' AFTER email,
	ADD COLUMN phoneExt VARCHAR(10),
	CHANGE COLUMN phoneExt phoneExt VARCHAR(10) COMMENT 'Principal investigator phone number extension. Optional.' AFTER phone,
	ADD COLUMN consentQuestionnaireId BIGINT(20),
	CHANGE COLUMN consentQuestionnaireId consentQuestionnaireId BIGINT(20) COMMENT 'QuestionnaireDB questionnaire ID of the consent form for this study. Foreign key field. Mandatory.' AFTER ID,
	ADD CONSTRAINT fk_study_consentQuestionnaireId_questionnaire_ID FOREIGN KEY (consentQuestionnaireId) REFERENCES QuestionnaireDB.questionnaire(ID);

-- Add ConsentStatus, readStatus to `patientStudy`
ALTER TABLE patientStudy
	ADD COLUMN consentStatus INT NOT NULL,
	CHANGE COLUMN consentStatus consentStatus INT NOT NULL COMMENT 'Patient consent status for this study. 1 = invited; 2 = opalConsented; 3 = otherConsented; 4 = declined. Mandatory.' AFTER studyId,
	ADD COLUMN readStatus INT NOT NULL,
	CHANGE COLUMN readStatus readStatus INT NOT NULL COMMENT 'Patient read status for this consent form.' AFTER consentStatus;