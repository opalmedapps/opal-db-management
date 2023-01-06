ALTER TABLE `questionnaireStudy`
ADD CONSTRAINT `fk_questionnaireStudy_questionnaireId_questionnaire_ID`
    FOREIGN KEY (`questionnaireId`)
    REFERENCES `QuestionnaireDB` . `questionnaire` (`ID`);
