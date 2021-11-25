-- --------------------------------------------------------
-- Host:                         lxkvmap96
-- Server version:               10.5.9-MariaDB - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for QuestionnaireDB
CREATE DATABASE IF NOT EXISTS `QuestionnaireDB` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `QuestionnaireDB`;

-- Dumping structure for table QuestionnaireDB.answer
CREATE TABLE IF NOT EXISTS `answer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaireId` bigint(20) NOT NULL,
  `sectionId` bigint(20) NOT NULL,
  `questionId` bigint(20) NOT NULL,
  `typeId` bigint(20) NOT NULL,
  `answerSectionId` bigint(20) NOT NULL,
  `languageId` bigint(20) NOT NULL,
  `patientId` bigint(20) NOT NULL,
  `answered` tinyint(4) NOT NULL DEFAULT 0,
  `skipped` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_answer_deleted` (`deleted`),
  KEY `fk_answer_questionId_question_ID` (`questionId`),
  KEY `fk_answer_sectionId_section_ID` (`sectionId`),
  KEY `fk_answer_questionnaireId_questionnaire_ID` (`questionnaireId`),
  KEY `fk_answer_answerSectionId_answerSection_ID` (`answerSectionId`),
  KEY `fk_answer_patientId_patient_ID` (`patientId`),
  KEY `fk_answer_languageId_language_ID` (`languageId`),
  KEY `fk_answer_TypeId_type_ID` (`typeId`),
  CONSTRAINT `fk_answer_TypeId_type_ID` FOREIGN KEY (`typeId`) REFERENCES `type` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_answer_answerSectionId_answerSection_ID` FOREIGN KEY (`answerSectionId`) REFERENCES `answerSection` (`ID`),
  CONSTRAINT `fk_answer_languageId_language_ID` FOREIGN KEY (`languageId`) REFERENCES `language` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_answer_patientId_patient_ID` FOREIGN KEY (`patientId`) REFERENCES `patient` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_answer_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`),
  CONSTRAINT `fk_answer_questionnaireId_questionnaire_ID` FOREIGN KEY (`questionnaireId`) REFERENCES `questionnaire` (`ID`),
  CONSTRAINT `fk_answer_sectionId_section_ID` FOREIGN KEY (`sectionId`) REFERENCES `section` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2267 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerCheckbox
CREATE TABLE IF NOT EXISTS `answerCheckbox` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerId` bigint(20) NOT NULL,
  `value` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerCheckbox_answerId_answer_ID` (`answerId`),
  KEY `fk_answerCheckbox_value_checkboxOption_ID` (`value`),
  CONSTRAINT `fk_answerCheckbox_answerId_answer_ID` FOREIGN KEY (`answerId`) REFERENCES `answer` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_answerCheckbox_value_checkboxOption_ID` FOREIGN KEY (`value`) REFERENCES `checkboxOption` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerDate
CREATE TABLE IF NOT EXISTS `answerDate` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerId` bigint(20) NOT NULL,
  `value` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerDate_answerId_answer_ID` (`answerId`),
  CONSTRAINT `fk_answerDate_answerId_answer_ID` FOREIGN KEY (`answerId`) REFERENCES `answer` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerLabel
CREATE TABLE IF NOT EXISTS `answerLabel` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerId` bigint(20) NOT NULL,
  `selected` tinyint(4) NOT NULL DEFAULT 1,
  `posX` int(11) NOT NULL,
  `posY` int(11) NOT NULL,
  `intensity` int(11) NOT NULL,
  `value` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerLabel_answer_ID` (`answerId`),
  KEY `fk_answerLabel_labelOption_ID` (`value`),
  CONSTRAINT `fk_answerLabel_answer_ID` FOREIGN KEY (`answerId`) REFERENCES `answer` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_answerLabel_labelOption_ID` FOREIGN KEY (`value`) REFERENCES `labelOption` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerQuestionnaire
CREATE TABLE IF NOT EXISTS `answerQuestionnaire` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaireId` bigint(20) NOT NULL,
  `patientId` bigint(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0 = New, 1 = In Progress, 2 = Completed',
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_answerQuestionnaire_deleted` (`deleted`),
  KEY `fk_answerQuestionnaire_questionnaireId_questionnaire_ID` (`questionnaireId`),
  KEY `fk_answerQuestionnaire_patientId_patient_ID` (`patientId`),
  CONSTRAINT `fk_answerQuestionnaire_patientId_patient_ID` FOREIGN KEY (`patientId`) REFERENCES `patient` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_answerQuestionnaire_questionnaireId_questionnaire_ID` FOREIGN KEY (`questionnaireId`) REFERENCES `questionnaire` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=727 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerRadioButton
CREATE TABLE IF NOT EXISTS `answerRadioButton` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerId` bigint(20) NOT NULL,
  `value` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerRadioButton_answerId_answer_ID` (`answerId`),
  KEY `fk_¸answerRadioButton_value_radioButtonOption_ID` (`value`),
  CONSTRAINT `fk_answerRadioButton_answerId_answer_ID` FOREIGN KEY (`answerId`) REFERENCES `answer` (`ID`),
  CONSTRAINT `fk_¸answerRadioButton_value_radioButtonOption_ID` FOREIGN KEY (`value`) REFERENCES `radioButtonOption` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerSection
CREATE TABLE IF NOT EXISTS `answerSection` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerQuestionnaireId` bigint(20) NOT NULL,
  `sectionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerSection_answerQuestionnaire_ID` (`answerQuestionnaireId`),
  KEY `fk_answerSection_section_ID` (`sectionId`),
  CONSTRAINT `fk_answerSection_answerQuestionnaire_ID` FOREIGN KEY (`answerQuestionnaireId`) REFERENCES `answerQuestionnaire` (`ID`),
  CONSTRAINT `fk_answerSection_section_ID` FOREIGN KEY (`sectionId`) REFERENCES `section` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerSlider
CREATE TABLE IF NOT EXISTS `answerSlider` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerId` bigint(20) NOT NULL,
  `value` float NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerSlider_answer_ID` (`answerId`),
  CONSTRAINT `fk_answerSlider_answer_ID` FOREIGN KEY (`answerId`) REFERENCES `answer` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1434 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerTextBox
CREATE TABLE IF NOT EXISTS `answerTextBox` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerId` bigint(20) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerTextBox_answerId_answer_ID` (`answerId`),
  CONSTRAINT `fk_answerTextBox_answerId_answer_ID` FOREIGN KEY (`answerId`) REFERENCES `answer` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.answerTime
CREATE TABLE IF NOT EXISTS `answerTime` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `answerId` bigint(20) NOT NULL,
  `value` time NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_answerTime_answerId_answer_ID` (`answerId`),
  CONSTRAINT `fk_answerTime_answerId_answer_ID` FOREIGN KEY (`answerId`) REFERENCES `answer` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.checkbox
CREATE TABLE IF NOT EXISTS `checkbox` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  `minAnswer` int(11) NOT NULL DEFAULT 1,
  `maxAnswer` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `fk_checkbox_questionId_question_ID` (`questionId`),
  CONSTRAINT `fk_checkbox_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.checkboxOption
CREATE TABLE IF NOT EXISTS `checkboxOption` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `description` bigint(20) NOT NULL,
  `specialAction` int(11) NOT NULL DEFAULT 0 COMMENT '0 = nothing special, 1 = check everything, 2 = uncheck everything',
  PRIMARY KEY (`ID`),
  KEY `fk_checkboxOption_parentTableId_checkBox_ID` (`parentTableId`),
  KEY `fk_checkboxOption_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_checkboxOption_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkboxOption_parentTableId_checkBox_ID` FOREIGN KEY (`parentTableId`) REFERENCES `checkbox` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.date
CREATE TABLE IF NOT EXISTS `date` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_date_questionId_question_ID` (`questionId`),
  CONSTRAINT `fk_date_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.definitionTable
CREATE TABLE IF NOT EXISTS `definitionTable` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.dictionary
CREATE TABLE IF NOT EXISTS `dictionary` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `tableId` bigint(20) NOT NULL,
  `languageId` bigint(20) NOT NULL,
  `contentId` bigint(20) NOT NULL,
  `content` mediumtext NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) DEFAULT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_dictionary_contentId` (`contentId`),
  KEY `idx_dictionary_deleted` (`deleted`),
  KEY `fk_dictionary_languageId_language_ID` (`languageId`),
  KEY `fk_dictionary_tableId_definitionTable_ID` (`tableId`),
  CONSTRAINT `fk_dictionary_languageId_language_ID` FOREIGN KEY (`languageId`) REFERENCES `language` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dictionary_tableId_definitionTable_ID` FOREIGN KEY (`tableId`) REFERENCES `definitionTable` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3972 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for procedure QuestionnaireDB.getAnswerByAnswerQuestionnaireIdAndQuestionSectionId
DELIMITER //
CREATE PROCEDURE `getAnswerByAnswerQuestionnaireIdAndQuestionSectionId`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_questionSectionId` BIGINT



)
    DETERMINISTIC
BEGIN

	-- This procedure takes the answerQuestionnaireId and the questionSectionId to produce a list of answer for that question. The answers are displayed in English for ORMS.

	-- declare variables
	declare lang_to_display, question_ID, section_ID bigint;
	
	-- for ORMS display in English
	set lang_to_display = 2;
	
	-- use questionSectionId to get the questionId and the sectionId
	select qSec.questionId, qSec.sectionId into question_ID, section_ID
	from questionSection qSec
	where qSec.ID = i_questionSectionId;
	
	-- get the answer
	select B.Answer as Answer
	from answerSection aSec, 
		(Select A.answerSectionId,
	
			(SELECT CONVERT(answerTextBox.VALUE, CHAR(516)) 
			FROM answerTextBox
			WHERE answerTextBox.answerId = A.ID
			UNION 
			SELECT CONVERT(answerSlider.VALUE, CHAR(516))
			FROM answerSlider
			WHERE answerSlider.answerId = A.ID
			UNION 
			SELECT CONVERT(answerDate.VALUE, CHAR(516))
			FROM answerDate
			WHERE answerDate.answerId = A.ID
			UNION 
			SELECT CONVERT(answerTime.VALUE, CHAR(516))
			FROM answerTime
			WHERE answerTime.answerId = A.ID
			UNION 
			SELECT CONVERT(getDisplayName(rbOpt.description, lang_to_display), CHAR(516)) 
			FROM answerRadioButton aRB, radioButtonOption rbOpt
			WHERE aRB.answerId = A.ID
				AND rbOpt.ID = aRB.`value`) AS Answer
		from answer A
		where A.deleted <> 1
			and A.questionId = question_ID
			and A.sectionId = section_ID
			AND A.typeId IN (3,2,7,6,4) -- this is to control for the type and not returning a null, this can be found in the `type` table
	UNION
	Select A.answerSectionId, CONVERT(getDisplayName(cOpt.description, lang_to_display), CHAR(516)) AS Answer
	from answer A, answerCheckbox aC, checkboxOption cOpt
	where A.deleted <> 1
		and A.questionId = question_ID
		and A.sectionId = section_ID
		and aC.answerId = A.ID
		AND cOpt.ID = aC.`value`
		AND A.typeId = 1 -- 1 is checkbox type, this can be found in the `type` table
	UNION
	Select A.answerSectionId, CONVERT(getDisplayName(lOpt.description, lang_to_display), CHAR(516)) AS Answer
	from answer A, answerLabel aL, labelOption lOpt
	where A.deleted <> 1
		and A.questionId = question_ID
		and A.sectionId = section_ID
		and aL.answerId = A.ID
		AND lOpt.ID = aL.`value`
		AND A.typeId = 5 -- 5 is label type, this can be found in the `type` table
	) B
	Where
		aSec.sectionId = section_ID
		and B.answerSectionId = aSec.ID
		and aSec.answerQuestionnaireId = i_answerQuestionnaireId;

END//
DELIMITER ;

-- Dumping structure for function QuestionnaireDB.getAnswerTableOptionID
DELIMITER //
CREATE FUNCTION `getAnswerTableOptionID`(`i_questionID` BIGINT,
`i_content` VARCHAR(255
),
`i_answerTypeID` BIGINT

) RETURNS bigint(20)
    DETERMINISTIC
BEGIN

-- Declare variables
Declare wsReturn, wsCount int;
Declare wsQuestionID, wsAnswerTypeID bigint;
Declare wsContent varchar(255);

-- Store the parameters
set wsReturn = -1;
Set wsContent = i_content;
Set wsAnswerTypeID = i_answerTypeID;
Set wsQuestionID = i_questionID;

-- Answer Type ID : 1 = Checkbox, 4 = Radiobutton, 5 = Label
-- The answer types can be found in table "Type"
-- NOTE: Currently we don't have any Label for now
if (wsAnswerTypeID = 1) then 
set wsReturn = (SELECT cbOpt.ID 
FROM checkbox cb, checkboxOption cbOpt
WHERE cb.questionId = i_questionID
AND cb.ID = cbOpt.parentTableId
AND cbOpt.description IN (
SELECT contentId
FROM dictionary
WHERE content = i_content
AND deleted <> 1 
AND tableId IN (12, 17, 31) -- where 12, 17, 31 are checkboxOption, labelOption, radioButtonOption tables resp., you can check in definitionTable
)
LIMIT 1
);
end if;
if (wsAnswerTypeID = 4) then 
set wsReturn = (SELECT rbOpt.ID  
FROM radioButton rb, radioButtonOption rbOpt
WHERE rb.questionId = i_questionID
AND rbOpt.parentTableId = rb.ID
AND rbOpt.description IN (
SELECT contentId
FROM dictionary
WHERE content = i_content
AND deleted <> 1 
AND tableId IN (12, 17, 31) -- where 12, 17, 31 are checkboxOption, labelOption, radioButtonOption tables resp., you can check in definitionTable
)
LIMIT 1
);
end if;

set wsReturn = ifnull(wsReturn, -1);
return wsReturn;


END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getCompletedQuestionnaireInfo
DELIMITER //
CREATE PROCEDURE `getCompletedQuestionnaireInfo`(
	IN `i_patientSerNum` VARCHAR(64),
	IN `i_questionnaireId` BIGINT
)
BEGIN

	-- This procedure gets the list of non deleted answered questionnaires with the given questionnaireId for the given patientSerNum
	-- The patientSerNum comes from the OpalDB or some external DB 
	declare patientId BIGINT;

	select ID into patientId
	from patient
	where patient.externalId = i_patientSerNum;
	
	-- gets the questionnaire information with the questions and its type.
	SELECT 
		aq.ID as PatientQuestionnaireSerNum,
		aq.patientId as PatientSerNum,
		DATE_FORMAT(aq.lastUpdated, '%Y-%m-%d') as DateTimeAnswered,
		aq.lastUpdated as FullDateTimeAnswered,
		qSec.ID AS QuestionnaireQuestionSerNum,
		questionnaire.ID as QuestionnaireSerNum,
		questionnaire.legacyName AS QuestionnaireName,
		qSec.questionId AS QuestionSerNum,
		getDisplayName(display, 2) AS QuestionName,
		getDisplayName(display, 1) AS QuestionName_FR,
		getDisplayName(q.question,2) AS QuestionQuestion,
		getDisplayName(q.question,1) AS QuestionQuestion_FR,
		q.legacyTypeId AS QuestionTypeSerNum
	FROM answerQuestionnaire aq
		LEFT JOIN questionnaire ON (aq.questionnaireId = questionnaire.ID)
		LEFT JOIN section sec ON (sec.questionnaireId = questionnaire.ID)
		LEFT JOIN questionSection qSec ON (qSec.sectionId = sec.ID)
		LEFT JOIN question q ON (qSec.questionId = q.ID)
	WHERE questionnaire.ID = i_questionnaireId
		AND questionnaire.deleted <> 1
		AND sec.deleted <> 1
		AND q.deleted <> 1
		AND aq.deleted = 0
		AND aq.patientId = patientId
		AND aq.`status` = 2	-- we need to retrieve the questionnaires that only has responses
	Order By DATE_FORMAT(aq.lastUpdated, '%Y-%m-%d') desc, aq.ID asc, qSec.`order` asc
	;
	
END//
DELIMITER ;

-- Dumping structure for function QuestionnaireDB.getDisplayName
DELIMITER //
CREATE FUNCTION `getDisplayName`(`i_ContentID` BIGINT,
	`i_LanguageID` BIGINT

) RETURNS mediumtext CHARSET utf8
    DETERMINISTIC
BEGIN
	-- Declare variables
	Declare wsText, wsReturnText, wsReturn MEDIUMTEXT;
	Declare wsCount int;
	Declare dictId bigint;

	-- Store the parameters
	set wsText = '';
	set wsCount = 0;
	
	-- Note: we have to first get the ID then get the content because content is text and is not indexed, making group by taking a long time to run
	-- Get the translation
	Select count(*), ID
	into wsCount, dictId
	from dictionary 
	where contentId = i_ContentID and languageId = i_LanguageID
	group by ID;

  -- if no record found then return empty
  -- otherwise return the translation text
  	if (wsCount = 0) then
		set wsReturn = wsText;
	else
		select content into wsReturnText
		from dictionary
		where ID = dictId;
		
		set wsReturn = wsReturnText;
	end if;
	
	Return wsReturn;

END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getLastAnsweredQuestionnaire
DELIMITER //
CREATE PROCEDURE `getLastAnsweredQuestionnaire`(
	IN `i_patientSerNum` VARCHAR(64),
	IN `i_questionnaireId` BIGINT
)
    DETERMINISTIC
BEGIN

	-- Retrieve the Last Questionnaire Responses for chart report in ORMS
	
	-- declare variables
	declare patient_ID BIGINT;
	
	-- find patientId in the questionnaireDB
	select p.ID into patient_ID
	from patient p
	where p.externalId = i_patientSerNum
		and p.deleted = 0;
	
	-- retrieve the last answered questionnaire
	select max(aq.ID) as PatientQuestionnaireSerNum,
		aq.questionnaireId,
		DATE_FORMAT(max(aq.lastUpdated), '%Y-%m-%d') as LastDateTimeAnswered, 
		count(*) as Total
	from answerQuestionnaire aq
	where aq.deleted = 0
		and aq.questionnaireId = i_questionnaireId
		and aq.patientId = patient_ID
		and aq.`status` = 2
	group by aq.questionnaireId
	;

END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getLastCompletedQuestionnaireByPatientId
DELIMITER //
CREATE PROCEDURE `getLastCompletedQuestionnaireByPatientId`(
	IN `i_patientId` BIGINT,
	IN `i_questionnaireId` BIGINT
)
    DETERMINISTIC
BEGIN

	-- retrieve the last answered questionnaire
	select max(aq.ID) as PatientQuestionnaireSerNum,
		aq.questionnaireId,
		DATE_FORMAT(max(aq.lastUpdated), '%Y-%m-%d') as LastDateTimeAnswered, 
		count(*) as Total
	from answerQuestionnaire aq
	where aq.deleted = 0
		and aq.questionnaireId = i_questionnaireId
		and aq.patientId = i_patientId
		and aq.`status` = 2
	group by aq.questionnaireId
	;

END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getQuestionnaireInfo
DELIMITER //
CREATE PROCEDURE `getQuestionnaireInfo`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_isoLang` VARCHAR(2)
)
    DETERMINISTIC
BEGIN
	
	-- this procedure is intended to get the questionnaire, section, questions and answers from an answerQuestionnaireId.
	-- the language is passed in iso form, i.e. 'EN', 'FR'. If the language is not valid, default to French
	
	-- declare variables
	declare wsCountLang, wsCountQuestionnaire, wsReturn, questionnaire_status int;
	declare questionnaire_id bigint;
	declare language_id bigint;
	declare default_isoLang varchar(2);
	declare answer_id_text text;

	-- set default language to French
	set default_isoLang = 'FR';
	
	-- note: wsReturn convention for this procedure: success = 0, language error = -1, error in answerQuestionnaireId = -2
	
	-- get language
	select count(*), ID into wsCountLang, language_id from language where isoLang = i_isoLang and deleted = 0 group by ID;
	
	-- label is a way to do early exit
	get_questionnaire:BEGIN
	
		-- verify language is correct	
		if wsCountLang <> 1 then
			
			-- try to get language again using default language
			select count(*), ID into wsCountLang, language_id from language where isoLang = default_isoLang and deleted = 0 group by ID;
			
			-- verify again that language is correct	
			if wsCountLang <> 1 then
				set wsReturn = -1;
				leave get_questionnaire;
			end if;
			
		end if;
		
		-- get the questionnaireId
		select count(*), aq.questionnaireId, aq.`status` into wsCountQuestionnaire, questionnaire_id, questionnaire_status	-- this will return at most 1 row only since ID is the primary key of answerQuestionnaire table
		from answerQuestionnaire aq
		where aq.ID = i_answerQuestionnaireId
			and aq.deleted = 0
		group by aq.questionnaireId, aq.`status`
		;
	
		-- verify that the questionnaireId is being returned
		if wsCountQuestionnaire <> 1 then
			set wsReturn = -2;
			leave get_questionnaire;
		end if;
		
		-- get information about that particular questionnaire
		-- left join is used here because we would still want to give the status of a questionnaire sent to a patient, even though that questionnaire does not exist in the questionnaire table
		select aq.ID as qp_ser_num,
			aq.`status` as status,
			aq.questionnaireId as questionnaire_id,
			aq.patientId as patient_id,
			p.externalId,
			getDisplayName(q.title,language_id) as nickname,
			q.logo as logo,
			getDisplayName(q.description,language_id) as description,
			getDisplayName(q.instruction,language_id) as instruction, 
			q.optionalFeedback as allow_questionnaire_feedback
		from answerQuestionnaire aq 
			left join questionnaire q on (aq.questionnaireId = q.ID)
			LEFT JOIN patient p ON (p.ID = aq.patientId)
		where aq.ID = i_answerQuestionnaireId
			and aq.deleted = 0
			and q.deleted = 0
			and q.final = 1
		;
	
		-- Get the information about sections in that questionnaire
		-- temporary table is created to store section_id(s) for the next step
		drop table if exists section_info;
		create temporary table if not exists section_info as 
		(
			select sec.ID as section_id,
				if(sec.title <> -1, getDisplayName(sec.title, language_id), '') as section_title,
				getDisplayName(sec.instruction, language_id) as section_instruction,
				sec.`order` as section_position
			from section sec 
			where sec.questionnaireId = questionnaire_id
				and sec.deleted = 0
			ORDER BY sec.`order`
		);
		
		select * from section_info;
		
		-- get questions for those sections
		-- inner join is used here because it does not make sense to give the question's position when the question itself does not exist
		select
			qSec.ID as questionSection_id,
			qSec.order as question_position,
			qSec.sectionId as section_id,
			qSec.orientation as orientation,
			qSec.optional as optional,
			q.ID as question_id,
			getDisplayName(q.question,language_id) as question_text,
			getDisplayName(q.display, language_id) as question_display,
			q.typeId as type_id,	
			q.polarity as polarity,
			q.optionalFeedback as allow_question_feedback
		from questionSection qSec
			inner join question q on (q.ID = qSec.questionId)
		where qSec.sectionId IN (select section_id from section_info)
			and q.deleted = 0
			and q.final = 1
		ORDER BY qSec.`order`
		;
		
		if questionnaire_status = 0 then 
			-- the line below is not really needed, however, since without it the number of query returned will not be the same for new and other status questionnaire, this is added to prevent error when calling this procedure.
			select questionnaire_status as status;
			
		else
							
			-- if the questionnaire is not new, then get its answer
			
			-- get answers_id for this questionnaire
			drop table if exists answer_summary;
			create temporary table if not exists answer_summary as (
				SELECT 
					aSec.answerQuestionnaireId as questionnairePatientRelSerNum,
					aSec.sectionId as section_id,
					a.ID as answer_id,
					a.questionId as question_id,
					a.typeId as type_id,
					a.answered as answered,
					a.skipped as skipped,
					a.creationDate as created,
					a.lastUpdated as last_updated,
					a.languageId as answer_language_id,
					qSec.ID AS questionSection_id
				FROM answerSection aSec, answer a, questionSection qSec
				WHERE aSec.answerQuestionnaireId = i_answerQuestionnaireId
					 AND a.answerSectionId = aSec.ID
				    AND a.deleted = 0
				    AND qSec.questionId = a.questionId
					 AND qSec.sectionId = a.sectionId
			);
			
			-- get the list of answer_id for which to get their values
			select GROUP_CONCAT(answer_id) into answer_id_text from answer_summary;
			
			-- this is to prevent when answer_id_text is NULL, -1 is not a possible value
			set answer_id_text = COALESCE(answer_id_text, "-1");

			-- get answer from the answer_ids
			-- left join is used because sometimes answer is there but the answer value is not (and that is a valid answer).
			set @wsSQL = concat(
				"select answer_summary.*,
					a.answer_value,
					a.answer_option_text,
					a.intensity,
					a.posX,
					a.posY,
					a.selected
				from answer_summary left join (
					select rb.answerId as answer_id,
						CONVERT(rb.value, CHAR(516)) as answer_value,
						getDisplayName((select rbOpt.description from radioButtonOption rbOpt where rbOpt.ID = rb.value),", language_id, ") as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerRadioButton rb
					where rb.answerId in (", answer_id_text, ")
					UNION
					select c.answerId as answer_id,
						CONVERT(c.value, CHAR(516)) as answer_value,
						getDisplayName((select cOpt.description from checkboxOption cOpt where cOpt.ID = c.value), ",language_id, ") as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerCheckbox c
					where c.answerId in (", answer_id_text, ")
					UNION
					select t.answerId, 
						CONVERT(t.value, CHAR(516)) as answer_value,
						-1 as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerTextBox t
					where t.answerId in (", answer_id_text, ")
					UNION
					select d.answerId, 
						CONVERT(d.value, CHAR(516)) as answer_value,
						-1 as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerDate d
					where d.answerId in (", answer_id_text, ")
					UNION
					select answerTime.answerId, 
						CONVERT(answerTime.value, CHAR(516)) as answer_value,
						-1 as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerTime 
					where answerTime.answerId in (", answer_id_text, ")
					UNION
					select s.answerId, 
						CONVERT(s.value, CHAR(516)) as answer_value,
						-1 as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerSlider s
					where s.answerId in (", answer_id_text, ")
					UNION
					select l.answerId, 
						CONVERT(l.value, CHAR(516)) as answer_value,
						getDisplayName((select lOpt.description from labelOption lOpt where lOpt.ID = l.value), ", language_id, ") as answer_option_text,
						l.intensity,
						l.posX,
						l.posY,
						l.selected
					from answerLabel l
					where l.answerId in (", answer_id_text, ")) a 
				on (answer_summary.answer_id = a.answer_id)
				;"
			);
			
			-- execute SQL statement
			prepare stmt from @wsSQL;
	
			Execute stmt;
			deallocate prepare stmt;

		end if; -- end of getting answers

		set wsReturn = 0;
		
	END; -- end of get_questionnaire block

	select wsReturn as procedure_status, language_id as language_id;

END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getQuestionnaireList
DELIMITER //
CREATE PROCEDURE `getQuestionnaireList`(
	IN `i_externalPatientId` VARCHAR(64),
	IN `i_isoLang` VARCHAR(2)
)
BEGIN

	-- this procedure gets the list of questionnaire belonging to a single patient.
	-- it requires an external patient ID i.e. from OpalDB, and a language in ISO format, i.e. 'EN', 'FR'. If the language is not valid, default to French.
	
	-- declare variables
	declare wsCountLang, wsReturn int;
	declare language_id bigint;
	declare default_isoLang varchar(2);
	
	-- set default language to French
	set default_isoLang = 'FR';
	
	-- note: wsReturn convention for this procedure: success = 0, language error = -1
	
	-- get language
	select count(ID), ID into wsCountLang, language_id from language where isoLang = i_isoLang and deleted = 0 group by ID;
	
	-- label is a way to do early exit
	get_questionnaire_list:BEGIN
	
		-- verify language is correct	
		if wsCountLang <> 1 then
		
			-- try to get language again using default language
			select count(ID), ID into wsCountLang, language_id from language where isoLang = default_isoLang and deleted = 0 group by ID;
			
			-- verify again that language is correct	
			if wsCountLang <> 1 then
				set wsReturn = -1;
				leave get_questionnaire_list;
			end if;
			
		end if;
		
		-- get the list of questionnaire
		SELECT aq.ID AS qp_ser_num,
			aq.questionnaireId AS questionnaire_id,
			aq.`status` AS status,
			aq.creationDate AS created,
			aq.lastUpdated AS last_updated,
			getDisplayName(q.title, language_id) AS nickname
		FROM answerQuestionnaire aq LEFT JOIN questionnaire q ON q.ID = aq.questionnaireId
		WHERE aq.deleted = 0
			AND q.deleted = 0
			AND q.final = 1
			AND aq.patientId = 
				(SELECT ID
				FROM patient
				WHERE externalId = i_externalPatientId
				AND deleted = 0)
			AND q.respondentId =
				(SELECT r.ID
				FROM respondent r, dictionary d
				WHERE r.title = d.contentId
					AND d.languageId =2
					AND d.content = 'Patient')
		;
		
		set wsReturn = 0;
				
	END; -- end of the get_questionnaire_list block
	
	select wsReturn as procedure_status;
	
END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getQuestionnaireListORMS
DELIMITER //
CREATE PROCEDURE `getQuestionnaireListORMS`(
	IN `i_patientId` VARCHAR(50),
	IN `i_opalDBName` VARCHAR(50)




)
    DETERMINISTIC
BEGIN

	set @wsSQL = concat(
		"SELECT ", 
		  i_patientId, " as PatientId,
		  max(CAST(DATE_FORMAT(Q.CompletionDate, '%Y-%m-%d') AS char(30))) as CompletionDate,
		  CASE
		    WHEN datediff(CAST(DATE_FORMAT(now(), '%Y-%m-%d') AS char(30)), max(CAST(DATE_FORMAT(Q.CompletionDate, '%Y-%m-%d') AS char(30)))) <= 3650 then 'New'
		    ELSE 'Old'
		  END as Status,
		  QC.QuestionnaireDBSerNum,
		  QC.QuestionnaireName_EN,
		  Count(*) as Total,
		  P.Sex,
		  P.Age,
		  qDB_q.visualization as Visualization
		FROM ", i_opalDBName, ".QuestionnaireControl QC,", 
		  i_opalDBName, ".Questionnaire Q,", 
			i_opalDBName, ".Patient P,", 
		  i_opalDBName, ".Users U,
		  questionnaire qDB_q
		WHERE QC.QuestionnaireControlSerNum = Q.QuestionnaireControlSerNum
			AND qDB_q.ID = QC.QuestionnaireDBSerNum
			AND qDB_q.deleted = 0
			AND Q.PatientSerNum = P.PatientSerNum
		  AND U.UserTypeSerNum = P.PatientSerNum
			and ((P.PatientId = '", i_patientId, "') or (P.PatientId2 = '", i_patientId,"'))
			and Q.CompletedFlag = 1
		GROUP BY QC.QuestionnaireDBSerNum, QC.QuestionnaireName_EN, P.Sex, P.Age, qDB_q.visualization
		Order By QC.QuestionnaireName_EN
		;"
	);
	
	-- execute SQL statement
	prepare stmt from @wsSQL;
	
	Execute stmt;
	
	deallocate prepare stmt;
END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getQuestionNameAndAnswer
DELIMITER //
CREATE PROCEDURE `getQuestionNameAndAnswer`(
	IN `i_patientId` VARCHAR(50),
	IN `i_questionnaireId` BIGINT,
	IN `i_questionText` MEDIUMTEXT

,
	IN `i_opalDBName` VARCHAR(50)

)
    DETERMINISTIC
BEGIN

	-- This routine gets the question name in EN and FR and the answer in EN for ORMS.
	
	-- declare variables
	declare patientId_OpalDB INT(11);
	declare patienId_questionnaireDB BIGINT;
	declare answer_lang_Id BIGINT;
	
	set answer_lang_Id = 2; 	-- the interface shows only English to clinicians now
	
	-- get the patientSerNum from opalDB
	set @wsSQL = concat(
		"select p.PatientSerNum into @patientId_OpalDB
		from ", i_opalDBName, ".Patient p
		where p.PatientId = ", i_patientId, ";"
	);
	
	-- execute SQL statement
	prepare stmt from @wsSQL;
	
	Execute stmt;
	
	select @patientId_OpalDB into patientId_OpalDB;
	
	deallocate prepare stmt;
	
	-- find out the patientId in the questionnaireDB using the opalDB's patientSerNum
	select p.ID into patienId_questionnaireDB
	from patient p
	where p.externalId = patientId_OpalDB
		and p.deleted = 0;
	
	-- output the question names, date answered, and the answer in the text format
	select unix_timestamp(DATE_FORMAT(aq.lastUpdated, '%Y-%m-%d')) as DateTimeAnswered,
		getDisplayName(q.display, 2) as QuestionName,
		getDisplayName(q.display, 1) as QuestionName_FR,
		B.value as Answer,
		B.Id as answerId
	from answerSection aSec, 
		questionSection qSec, 
		answerQuestionnaire aq,
		question q,
		(Select A.Id, A.questionId, A.sectionId, A.answerSectionId,
	
		(SELECT CONVERT(answerTextBox.VALUE, CHAR(516)) 
		FROM answerTextBox
		WHERE answerTextBox.answerId = A.ID
		UNION 
		SELECT CONVERT(answerSlider.VALUE, CHAR(516))
		FROM answerSlider
		WHERE answerSlider.answerId = A.ID
		UNION 
		SELECT CONVERT(answerDate.VALUE, CHAR(516))
		FROM answerDate
		WHERE answerDate.answerId = A.ID
		UNION 
		SELECT CONVERT(answerTime.VALUE, CHAR(516))
		FROM answerTime
		WHERE answerTime.answerId = A.ID
		UNION 
		SELECT CONVERT(getDisplayName(rbOpt.description, answer_lang_Id), CHAR(516)) 
		FROM answerRadioButton aRB, radioButtonOption rbOpt
		WHERE aRB.answerId = A.ID
			AND rbOpt.ID = aRB.`value`) AS value
	from answer A
	where A.deleted <> 1
	UNION
	Select A.Id, A.questionId, A.sectionId, A.answerSectionId, CONVERT(getDisplayName(cOpt.description, answer_lang_Id), CHAR(516)) AS value
	from answer A, answerCheckbox aC, checkboxOption cOpt
	where A.deleted <> 1
		and aC.answerId = A.ID
			AND cOpt.ID = aC.`value`
	UNION
	Select A.Id, A.questionId, A.sectionId, A.answerSectionId,CONVERT(getDisplayName(lOpt.description, answer_lang_Id), CHAR(516)) AS value
	from answer A, answerLabel aL, labelOption lOpt
	where A.deleted <> 1
		and aL.answerId = A.ID
			AND lOpt.ID = aL.`value`) B
	Where
		qSec.questionId = B.questionId
		and qSec.sectionId = B.sectionId
		and B.answerSectionId = aSec.ID
		and aSec.answerQuestionnaireId = aq.ID
		and aq.patientId = patienId_questionnaireDB
		and aq.`status` = 2
		and aq.questionnaireId = i_questionnaireId
		and aq.deleted = 0
		and q.ID = B.questionId
		and q.deleted = 0
		and getDisplayName(q.question, answer_lang_Id) = i_questionText
	;

END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getQuestionNameAndAnswerByID
DELIMITER //
CREATE PROCEDURE `getQuestionNameAndAnswerByID`(
	IN `i_patientId` VARCHAR(50),
	IN `i_questionnaireId` BIGINT,
	IN `i_questionText` MEDIUMTEXT,
	IN `i_opalDBName` VARCHAR(50),
	IN `i_questionID` BIGINT
)
    DETERMINISTIC
BEGIN

	-- This routine gets the question name in EN and FR and the answer in EN for ORMS.
	
	-- declare variables
	declare patientId_OpalDB INT(11);
	declare patienId_questionnaireDB BIGINT;
	declare answer_lang_Id BIGINT;
	
	set answer_lang_Id = 2; 	-- the interface shows only English to clinicians now
	
	-- get the patientSerNum from opalDB
	set @wsSQL = concat(
		"select p.PatientSerNum into @patientId_OpalDB
		from ", i_opalDBName, ".Patient p
		where p.PatientId = ", i_patientId, ";"
	);
	
	-- execute SQL statement
	prepare stmt from @wsSQL;
	
	Execute stmt;
	
	select @patientId_OpalDB into patientId_OpalDB;
	
	deallocate prepare stmt;
	
	-- find out the patientId in the questionnaireDB using the opalDB's patientSerNum
	select p.ID into patienId_questionnaireDB
	from patient p
	where p.externalId = patientId_OpalDB
		and p.deleted = 0;
	
	-- output the question names, date answered, and the answer in the text format
	select unix_timestamp(DATE_FORMAT(aq.lastUpdated, '%Y-%m-%d')) as DateTimeAnswered,
		getDisplayName(q.display, 2) as QuestionName,
		getDisplayName(q.display, 1) as QuestionName_FR,
		B.value as Answer,
		B.Id as answerId
	from answerSection aSec, 
		questionSection qSec, 
		answerQuestionnaire aq,
		question q,
		(Select A.Id, A.questionId, A.sectionId, A.answerSectionId,
	
		(SELECT CONVERT(answerTextBox.VALUE, CHAR(516)) 
		FROM answerTextBox
		WHERE answerTextBox.answerId = A.ID
		UNION 
		SELECT CONVERT(answerSlider.VALUE, CHAR(516))
		FROM answerSlider
		WHERE answerSlider.answerId = A.ID
		UNION 
		SELECT CONVERT(answerDate.VALUE, CHAR(516))
		FROM answerDate
		WHERE answerDate.answerId = A.ID
		UNION 
		SELECT CONVERT(answerTime.VALUE, CHAR(516))
		FROM answerTime
		WHERE answerTime.answerId = A.ID
		UNION 
		SELECT CONVERT(getDisplayName(rbOpt.description, answer_lang_Id), CHAR(516)) 
		FROM answerRadioButton aRB, radioButtonOption rbOpt
		WHERE aRB.answerId = A.ID
			AND rbOpt.ID = aRB.`value`) AS value
	from answer A
	where A.deleted <> 1
	UNION
	Select A.Id, A.questionId, A.sectionId, A.answerSectionId, CONVERT(getDisplayName(cOpt.description, answer_lang_Id), CHAR(516)) AS value
	from answer A, answerCheckbox aC, checkboxOption cOpt
	where A.deleted <> 1
		and aC.answerId = A.ID
			AND cOpt.ID = aC.`value`
	UNION
	Select A.Id, A.questionId, A.sectionId, A.answerSectionId,CONVERT(getDisplayName(lOpt.description, answer_lang_Id), CHAR(516)) AS value
	from answer A, answerLabel aL, labelOption lOpt
	where A.deleted <> 1
		and aL.answerId = A.ID
			AND lOpt.ID = aL.`value`) B
	Where
		qSec.questionId = B.questionId
		and qSec.sectionId = B.sectionId
		and B.answerSectionId = aSec.ID
		and aSec.answerQuestionnaireId = aq.ID
		and aq.patientId = patienId_questionnaireDB
		and aq.`status` = 2
		and aq.questionnaireId = i_questionnaireId
		and aq.deleted = 0
		and q.ID = B.questionId
		and q.deleted = 0
		AND qSec.ID = i_questionID
		and getDisplayName(q.question, answer_lang_Id) = i_questionText
	;

END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.getQuestionOptions
DELIMITER //
CREATE PROCEDURE `getQuestionOptions`(
	IN `i_typeId` BIGINT,
	IN `i_questionId` TEXT,
	IN `i_languageId` BIGINT
)
    DETERMINISTIC
BEGIN

	/*
	Parameter: i_typeId: the typeId of the questions passed
				i_questionId: the list of questions' ID to get the options for
				i_languageId: the languageId to get the options displayed in
				
	Produce the list of choices/options
	
	note: wsReturn convention for this procedure: success = 0, no matching type = -1
	*/

	-- declare variables
	declare wsReturn int;
	declare tableName, subTableName varchar(255);
	
	get_options: BEGIN
	
		-- verify length of i_questionId
		if (length(trim(i_questionId)) = 0) then
			set wsReturn = 0;
			leave get_options;
		end if;
	
		-- get table names for that type
		select 
			(select def.name from definitionTable def where def.ID = type.tableId) as tableName,
			if (type.subTableId = -1, '-1', (select def.name from definitionTable def where def.ID = type.subTableId)) as subTableName
			into tableName, subTableName
		from type
		where type.ID = i_typeId;
		
		-- verify that a single table name has been returned (has to be 1 or 0, because ID is unique)
		if tableName IS NULL then
			set wsReturn = -1;
			leave get_options;
		end if;
		
		-- slider type: special due to it having more fields to translate
		if tableName = 'slider' then
			set @wsSQL = concat(
				"select s.ID, 
					s.questionId,
					s.minValue as min_value,
					s.maxValue as max_value,
					getDisplayName(s.minCaption, ", i_languageId, ") as min_caption,
					getDisplayName(s.maxCaption, ", i_languageId, ") as max_caption,
					s.increment as increment
				from slider s
				where s.questionId in (", i_questionId, ");"
			);
		
		-- types without a subTable: date, time, slider (which is a special case dealed with earlier)
		elseif subTableName = '-1' then
			set @wsSQL = concat(
				"select *
				from ", tableName, " t
				where t.questionId in (", i_questionId, ");
				"
			);
		
		-- types with a subTable: checkbox, radioButton, label, textBox
		else
			set @wsSQL = concat(
				"select *, 
					subT.ID as option_id,
					getDisplayName(subT.description, ", i_languageId, ") as option_text
				from ", tableName, " t
					left join ", subTableName, " subT on (t.ID = subT.parentTableId)
				where t.questionId in (", i_questionId, ");"
			);
		end if;
		
		-- execute SQL statements
		prepare stmt from @wsSQL;
		
		Execute stmt;
		deallocate prepare stmt;
		
		-- end of execution, return success
		set wsReturn = 0;
		
	END; -- end of get_options block
	
	select wsReturn as procedure_status, i_typeId as type_id, tableName as type_table_name;
	 
END//
DELIMITER ;

-- Dumping structure for table QuestionnaireDB.label
CREATE TABLE IF NOT EXISTS `label` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  `displayIntensity` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 = patient cannot select intensity, 1 = patient can select intensity',
  `pathImage` varchar(512) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_label_questionId_question_ID` (`questionId`),
  CONSTRAINT `fk_label_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.labelOption
CREATE TABLE IF NOT EXISTS `labelOption` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  `posInitX` int(11) NOT NULL DEFAULT 0,
  `posInitY` int(11) NOT NULL DEFAULT 0,
  `posFinalX` int(11) NOT NULL DEFAULT 0,
  `posFinalY` int(11) NOT NULL DEFAULT 0,
  `intensity` int(11) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `fk_labelOption_parentTableId_label_ID` (`parentTableId`),
  KEY `fk_labelOption_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_labelOption_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_labelOption_parentTableId_label_ID` FOREIGN KEY (`parentTableId`) REFERENCES `label` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.language
CREATE TABLE IF NOT EXISTS `language` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `isoLang` varchar(2) NOT NULL,
  `name` bigint(20) NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_language_deleted` (`deleted`),
  KEY `fk_language_name_dictionary_ID` (`name`),
  CONSTRAINT `fk_language_name_dictionary_ID` FOREIGN KEY (`name`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.legacyType
CREATE TABLE IF NOT EXISTS `legacyType` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `legacyName` varchar(255) NOT NULL,
  `legacyTableName` varchar(255) NOT NULL,
  `typeId` bigint(20) NOT NULL,
  `default` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `fk_legacyType_typeId_type_ID` (`typeId`),
  CONSTRAINT `fk_legacyType_typeId_type_ID` FOREIGN KEY (`typeId`) REFERENCES `type` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='This table is a direct replication from the legacy table QuestionType in questionnaireDB. It is required for the time of the migration. When the migration will be over and the triggers will stop, this table needs to be deleted.';

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.library
CREATE TABLE IF NOT EXISTS `library` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OAUserId` bigint(20) NOT NULL DEFAULT -1,
  `name` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `private` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_library_deleted` (`deleted`),
  KEY `idx_library_OAUserId` (`OAUserId`),
  KEY `fk_library_name_dictionary_ID` (`name`),
  CONSTRAINT `fk_library_name_dictionary_ID` FOREIGN KEY (`name`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.libraryQuestion
CREATE TABLE IF NOT EXISTS `libraryQuestion` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  `libraryId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_libraryQuestion_questionId_question_ID` (`questionId`),
  KEY `fk_libraryQuestion_libraryId_library_ID` (`libraryId`),
  CONSTRAINT `fk_libraryQuestion_libraryId_library_ID` FOREIGN KEY (`libraryId`) REFERENCES `library` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_libraryQuestion_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.patient
CREATE TABLE IF NOT EXISTS `patient` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `hospitalId` bigint(20) NOT NULL,
  `externalId` varchar(64) NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_patient_deleted` (`deleted`),
  KEY `idx_patient_hospitalId` (`hospitalId`),
  KEY `idx_patient_externalId` (`externalId`)
) ENGINE=InnoDB AUTO_INCREMENT=1878 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.purpose
CREATE TABLE IF NOT EXISTS `purpose` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_purpose_title_dictionary_contentId` (`title`),
  KEY `fk_purpose_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_purpose_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purpose_title_dictionary_contentId` FOREIGN KEY (`title`) REFERENCES `dictionary` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for procedure QuestionnaireDB.queryAnswers
DELIMITER //
CREATE PROCEDURE `queryAnswers`(
	IN `i_answerQuestionnaireId` TEXT,
	IN `i_languageId` BIGINT



)
    DETERMINISTIC
BEGIN

/*
Parameter: i_answerQuestionnaireID: the list of answerQuestionnaireID for which to get answer for
				i_languageId: the language that the answers are going to be displayed in case the answers have languageId = -1 in the database
Produce the list of answers values translated
Note: this procedure is hardcoded for its type, which refers to the `type` table
*/

set @wsSQL = concat("
select aSec.answerQuestionnaireId AS QuestionnaireSerNum, 
	qSec.ID AS QuestionnaireQuestionSerNum, 
	B.Answer
from answerSection aSec, 
	questionSection qSec, 
	(Select A.questionId, A.sectionId, A.answerSectionId,

	(SELECT CONVERT(answerTextBox.VALUE, CHAR(516)) 
	FROM answerTextBox
	WHERE answerTextBox.answerId = A.ID
	UNION 
	SELECT CONVERT(answerSlider.VALUE, CHAR(516))
	FROM answerSlider
	WHERE answerSlider.answerId = A.ID
	UNION 
	SELECT CONVERT(answerDate.VALUE, CHAR(516))
	FROM answerDate
	WHERE answerDate.answerId = A.ID
	UNION 
	SELECT CONVERT(answerTime.VALUE, CHAR(516))
	FROM answerTime
	WHERE answerTime.answerId = A.ID
	UNION 
	SELECT CONVERT(getDisplayName(rbOpt.description, if(A.languageId < 0,", i_languageId, ", A.languageId)), CHAR(516)) 
	FROM answerRadioButton aRB, radioButtonOption rbOpt
	WHERE aRB.answerId = A.ID
		AND rbOpt.ID = aRB.`value`) AS Answer
from answer A
where A.deleted <> 1
	AND A.typeId IN (3,2,7,6,4) -- this is to control for the type and not returning a null, this can be found in the `type` table
UNION
Select A.questionId, A.sectionId, A.answerSectionId, CONVERT(getDisplayName(cOpt.description, if(A.languageId < 0,", i_languageId, ", A.languageId) ), CHAR(516)) AS Answer
from answer A, answerCheckbox aC, checkboxOption cOpt
where A.deleted <> 1
	and aC.answerId = A.ID
	AND cOpt.ID = aC.`value`
	AND A.typeId = 1 -- 1 is checkbox type, this can be found in the `type` table
UNION
Select A.questionId, A.sectionId, A.answerSectionId,CONVERT(getDisplayName(lOpt.description, if(A.languageId < 0,", i_languageId, ", A.languageId)), CHAR(516)) AS Answer
from answer A, answerLabel aL, labelOption lOpt
where A.deleted <> 1
	and aL.answerId = A.ID
	AND lOpt.ID = aL.`value`
	AND A.typeId = 5 -- 5 is label type, this can be found in the `type` table
) B
Where
	qSec.questionId = B.questionId
	and qSec.sectionId = B.sectionId
	and B.answerSectionId = aSec.ID
	and aSec.answerQuestionnaireId IN (", i_answerQuestionnaireId, ");");

Prepare stmt from @wsSQL;
Execute stmt;

deallocate prepare stmt;



END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.queryPatientQuestionnaireInfo
DELIMITER //
CREATE PROCEDURE `queryPatientQuestionnaireInfo`(
	IN `i_externalId` BIGINT


)
BEGIN

/*
Produce the list of Questionnaires
*/

SELECT IF(`status` <> 2, 0, 1) AS CompletedFlag,
    creationDate AS DateAdded,
    IF(`status` <> 2, NULL, lastUpdated) AS CompletionDate,
    ID AS QuestionnaireSerNum,
    questionnaireId AS QuestionnaireDBSerNum
FROM answerQuestionnaire
WHERE deleted <> 1
AND patientId IN (
    SELECT ID
FROM patient
WHERE externalId = i_externalId
AND deleted <> 1
)
;



END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.queryQuestionChoices
DELIMITER //
CREATE PROCEDURE `queryQuestionChoices`(
	IN `i_questionID` TEXT

)
    DETERMINISTIC
BEGIN

/*
Parameter: i_questionID: the list of questions' ID to get the options for
Produce the list of choices/options
*/

if (length(trim(i_questionID)) = 0) then
	set i_questionID = '-1';
end if;


set @wsSQL = concat("
SELECT rb.questionId AS QuestionSerNum,
	rbOpt.`order` AS OrderNum,
	getDisplayName(rbOpt.description, 2) AS ChoiceDescription_EN,
	getDisplayName(rbOpt.description, 1) AS ChoiceDescription_FR
FROM radioButton rb, radioButtonOption rbOpt
WHERE rb.Id = rbOpt.parentTableId
	AND rb.questionId IN (", i_questionID, ")
UNION ALL 
SELECT c.questionId,
	cOpt.`order`,
	getDisplayName(cOpt.description, 2) AS ChoiceDescription_EN,
	getDisplayName(cOpt.description, 1) AS ChoiceDescription_FR
FROM checkbox c, checkboxOption cOpt
WHERE c.ID = cOpt.parentTableId
	AND c.questionId IN (", i_questionID, ")
UNION ALL 
SELECT slider.questionId,
	slider.minValue - 1 AS OrderNum,
	getDisplayName(slider.minCaption, 2) AS ChoiceDescription_EN,
	getDisplayName(slider.minCaption, 1) AS ChoiceDescription_FR
FROM slider
WHERE slider.questionId IN (", i_questionID, ")
UNION ALL 
SELECT slider.questionId,
	slider.`maxValue` AS OrderNum,
	getDisplayName(slider.maxCaption, 2) AS ChoiceDescription_EN,
	getDisplayName(slider.maxCaption, 1) AS ChoiceDescription_FR
FROM slider
WHERE slider.questionId IN (", i_questionID, ")
UNION ALL 
SELECT l.questionId,
	lOpt.`order`,
	getDisplayName(lOpt.description, 2) AS ChoiceDescription_EN,
	getDisplayName(lOpt.description, 1) AS ChoiceDescription_FR
FROM label l, labelOption lOpt
WHERE l.ID = lOpt.parentTableId
	AND l.questionId IN (", i_questionID, ")
ORDER BY QuestionSerNum, OrderNum DESC;");


prepare stmt from @wsSQL;

Execute stmt;
deallocate prepare stmt;

END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.queryQuestionChoicesORMS
DELIMITER //
CREATE PROCEDURE `queryQuestionChoicesORMS`(
	IN `i_questionID` BIGINT
)
    DETERMINISTIC
BEGIN
	/*
	Parameter: i_questionID: the questions' ID to get the options for
	Produce the list of choices/options in order, and in English
	Note: this is similar to queryQuestionChoices, but this is for ORMS
	*/
	
	declare lang_to_display bigint;
	set lang_to_display = 2;	-- ORMS wants EN
	
	SELECT rbOpt.`order` AS ChoiceSerNum,
		getDisplayName(rbOpt.description, lang_to_display) AS ChoiceDescription
	FROM radioButton rb, radioButtonOption rbOpt
	WHERE rb.Id = rbOpt.parentTableId
		AND rb.questionId = i_questionID
	UNION ALL 
	SELECT
		cOpt.`order` AS ChoiceSerNum,
		getDisplayName(cOpt.description, lang_to_display) AS ChoiceDescription
	FROM checkbox c, checkboxOption cOpt
	WHERE c.ID = cOpt.parentTableId
		AND c.questionId = i_questionID
	UNION ALL 
	SELECT 
		slider.minValue - 1 AS ChoiceSerNum,
		getDisplayName(slider.minCaption, lang_to_display) AS ChoiceDescription
	FROM slider
	WHERE slider.questionId = i_questionID
	UNION ALL 
	SELECT 
		slider.`maxValue` AS ChoiceSerNum,
		getDisplayName(slider.maxCaption, lang_to_display) AS ChoiceDescription
	FROM slider
	WHERE slider.questionId = i_questionID
	UNION ALL 
	SELECT 
		lOpt.`order` AS ChoiceSerNum,
		getDisplayName(lOpt.description, lang_to_display) AS ChoiceDescription
	FROM label l, labelOption lOpt
	WHERE l.ID = lOpt.parentTableId
		AND l.questionId = i_questionID
	ORDER BY ChoiceSerNum;
	
END//
DELIMITER ;

-- Dumping structure for procedure QuestionnaireDB.queryQuestions
DELIMITER //
CREATE PROCEDURE `queryQuestions`(
	IN `i_questionnaireID` TEXT




)
    DETERMINISTIC
BEGIN

/*
parameter: list of Questionnaires ID
produce the list of questions in that questionnaire
*/

if (length(trim(i_questionnaireID)) = 0) then
	set i_questionnaireID = '-1';
end if;


set @wsSQL = concat("
SELECT questionnaire.ID AS QuestionnaireDBSerNum,
	questionnaire.legacyName AS QuestionnaireName,
	-- IF (questionnaire.nickname <> -1, getDisplayName(questionnaire.nickname,2), getDisplayName(questionnaire.title,2)) AS QuestionnaireName_EN, These two lines are ignore because the nickname functionality does not exist for now
	-- IF (questionnaire.nickname <> -1, getDisplayName(questionnaire.nickname,1), getDisplayName(questionnaire.title,1)) AS QuestionnaireName_FR,
	getDisplayName(questionnaire.title,2) AS QuestionnaireName_EN,
	getDisplayName(questionnaire.title,1) AS QuestionnaireName_FR,
	getDisplayName(questionnaire.description,2) AS Intro_EN,
	getDisplayName(questionnaire.description,1) AS Intro_FR,
	sec.ID AS sectionId,
	sec.`order` AS secOrder,
	qSec.ID AS QuestionnaireQuestionSerNum,
	qSec.questionId AS QuestionSerNum,
	q.polarity AS isPositiveQuestion,
	getDisplayName(q.question,2) AS QuestionText_EN,
	getDisplayName(q.question,1) AS QuestionText_FR,
	getDisplayName(display, 2) AS Asseses_EN,
	getDisplayName(display, 1) AS Asseses_FR,
	legacyType.legacyName AS QuestionType,
	q.legacyTypeId AS QuestionTypeSerNum,
	qSec.`order` AS qOrder
FROM questionnaire
	LEFT JOIN section sec ON (sec.questionnaireId = questionnaire.ID)
	LEFT JOIN questionSection qSec ON (qSec.sectionId = sec.ID)
	LEFT JOIN question q ON (qSec.questionId = q.ID)
	LEFT JOIN legacyType ON (q.legacyTypeId = legacyType.ID)
WHERE questionnaire.ID IN (", i_questionnaireID,")
	AND questionnaire.deleted <> 1
	AND sec.deleted <> 1
	AND q.deleted <> 1;");

prepare stmt from @wsSQL;

Execute stmt;
deallocate prepare stmt;

END//
DELIMITER ;

-- Dumping structure for table QuestionnaireDB.question
CREATE TABLE IF NOT EXISTS `question` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OAUserId` bigint(20) NOT NULL DEFAULT -1,
  `display` bigint(20) NOT NULL,
  `definition` bigint(20) NOT NULL,
  `question` bigint(20) NOT NULL,
  `typeId` bigint(20) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `parentId` bigint(20) NOT NULL DEFAULT -1,
  `polarity` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 = lowGood (the lower the score, the better the answer), 1 = highGood (the higher the score, the better the answer)',
  `private` tinyint(4) NOT NULL DEFAULT 0,
  `final` tinyint(4) NOT NULL DEFAULT 0,
  `optionalFeedback` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  `legacyTypeId` bigint(20) NOT NULL COMMENT 'This ID linked to the legacyTypes table must be removed once the migration of the legacy questionnaire will be done and the triggers stopped.',
  PRIMARY KEY (`ID`),
  KEY `idx_question_deleted` (`deleted`),
  KEY `idx_question_OAUserId` (`OAUserId`),
  KEY `idx_question_parentId` (`parentId`),
  KEY `fk_question_typeId_type_ID` (`typeId`),
  KEY `fk_question_question_dictionary_contentId` (`question`),
  KEY `fk_question_display_dictionary_contentId` (`display`),
  KEY `fk_question_definition_dictionary_contentId` (`definition`),
  KEY `fk_question_legacyTypeId_legacyType` (`legacyTypeId`),
  CONSTRAINT `fk_question_definition_dictionary_contentId` FOREIGN KEY (`definition`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_display_dictionary_contentId` FOREIGN KEY (`display`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_legacyTypeId_legacyType` FOREIGN KEY (`legacyTypeId`) REFERENCES `legacyType` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_question_dictionary_contentId` FOREIGN KEY (`question`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_typeId_type_ID` FOREIGN KEY (`typeId`) REFERENCES `type` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1027 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.questionFeedback
CREATE TABLE IF NOT EXISTS `questionFeedback` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  `languageId` bigint(20) NOT NULL,
  `patientId` bigint(20) NOT NULL,
  `feedback` text NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_questionFeedback_deleted` (`deleted`),
  KEY `fk_questionFeedback_questionId_question_ID` (`questionId`),
  KEY `fk_questionFeedback_patientId_patient_ID` (`patientId`),
  KEY `fk_questionFeedback_languageId_language_ID` (`languageId`),
  CONSTRAINT `fk_questionFeedback_languageId_language_ID` FOREIGN KEY (`languageId`) REFERENCES `language` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionFeedback_patientId_patient_ID` FOREIGN KEY (`patientId`) REFERENCES `patient` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionFeedback_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.questionnaire
CREATE TABLE IF NOT EXISTS `questionnaire` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OAUserId` bigint(20) NOT NULL DEFAULT -1,
  `purposeId` bigint(20) NOT NULL DEFAULT 1,
  `respondentId` bigint(20) NOT NULL DEFAULT 1,
  `title` bigint(20) NOT NULL,
  `nickname` bigint(20) NOT NULL,
  `category` int(11) NOT NULL DEFAULT -1,
  `description` bigint(20) NOT NULL,
  `instruction` bigint(20) NOT NULL,
  `final` tinyint(4) NOT NULL DEFAULT 0,
  `version` int(11) NOT NULL DEFAULT 1,
  `parentId` bigint(20) NOT NULL DEFAULT -1,
  `private` tinyint(4) NOT NULL DEFAULT 0,
  `optionalFeedback` tinyint(4) NOT NULL DEFAULT 1,
  `visualization` int(4) NOT NULL COMMENT '0',
  `logo` varchar(512) NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  `legacyName` varchar(255) NOT NULL COMMENT 'This field is mandatory to make the app works during the migration process. This field must be removed once the migration of the legacy questionnaire will be done, the triggers stopped and the app changed to use the correct standards.',
  PRIMARY KEY (`ID`),
  KEY `idx_questionnaire_deleted` (`deleted`),
  KEY `idx_questionnaire_OAUserId` (`OAUserId`),
  KEY `idx_questionnaire_parentId` (`parentId`),
  KEY `fk_questionnaire_title_dictionary_contentId` (`title`),
  KEY `fk_questionnaire_nickname_dictionary_contentId` (`nickname`),
  KEY `fk_questionnaire_description_dictionary_contentId` (`description`),
  KEY `fk_questionnaire_instructions_dictionary_contentId` (`instruction`),
  KEY `fk_questionnaire_purposeId_purpose_id` (`purposeId`),
  KEY `fk_questionnaire_respondentId_respondent_id` (`respondentId`),
  CONSTRAINT `fk_questionnaire_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionnaire_instructions_dictionary_contentId` FOREIGN KEY (`instruction`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionnaire_nickname_dictionary_contentId` FOREIGN KEY (`nickname`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionnaire_purposeId_purpose_id` FOREIGN KEY (`purposeId`) REFERENCES `purpose` (`ID`),
  CONSTRAINT `fk_questionnaire_respondentId_respondent_id` FOREIGN KEY (`respondentId`) REFERENCES `respondent` (`ID`),
  CONSTRAINT `fk_questionnaire_title_dictionary_contentId` FOREIGN KEY (`title`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.questionnaireFeedback
CREATE TABLE IF NOT EXISTS `questionnaireFeedback` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaireId` bigint(20) NOT NULL,
  `languageId` bigint(20) NOT NULL,
  `patientId` bigint(20) NOT NULL,
  `feedback` text NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_questionnaireFeedback` (`deleted`),
  KEY `fk_questionnaireFeedback_questionnaireId_questionnaire_ID` (`questionnaireId`),
  KEY `fk_questionnaireFeedback_patientId_patient_ID` (`patientId`),
  KEY `fk_questionnaireFeedback_languageId_language_ID` (`languageId`),
  CONSTRAINT `fk_questionnaireFeedback_languageId_language_ID` FOREIGN KEY (`languageId`) REFERENCES `language` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionnaireFeedback_patientId_patient_ID` FOREIGN KEY (`patientId`) REFERENCES `patient` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionnaireFeedback_questionnaireId_questionnaire_ID` FOREIGN KEY (`questionnaireId`) REFERENCES `questionnaire` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.questionnaireRating
CREATE TABLE IF NOT EXISTS `questionnaireRating` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaireId` bigint(20) NOT NULL,
  `languageId` bigint(20) NOT NULL,
  `patientId` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `comment` text NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_questionnaireRating_deleted` (`deleted`),
  KEY `fk_questionnaireRating_questionnaireId_questionnaire_ID` (`questionnaireId`),
  KEY `fk_questionnaireRating_patientId_patient_ID` (`patientId`),
  KEY `fk_questionnaireRating_languageId_language_ID` (`languageId`),
  CONSTRAINT `fk_questionnaireRating_languageId_language_ID` FOREIGN KEY (`languageId`) REFERENCES `language` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionnaireRating_patientId_patient_ID` FOREIGN KEY (`patientId`) REFERENCES `patient` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionnaireRating_questionnaireId_questionnaire_ID` FOREIGN KEY (`questionnaireId`) REFERENCES `questionnaire` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.questionRating
CREATE TABLE IF NOT EXISTS `questionRating` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  `languageId` bigint(20) NOT NULL,
  `patientId` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `comment` text NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_questionRating_questionId_question_ID` (`questionId`),
  KEY `fk_questionRating_patientId_patient_ID` (`patientId`),
  KEY `fk_questionRating_languageId_language_ID` (`languageId`),
  CONSTRAINT `fk_questionRating_languageId_language_ID` FOREIGN KEY (`languageId`) REFERENCES `language` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionRating_patientId_patient_ID` FOREIGN KEY (`patientId`) REFERENCES `patient` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_questionRating_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.questionSection
CREATE TABLE IF NOT EXISTS `questionSection` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  `sectionId` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `orientation` int(11) NOT NULL DEFAULT 0 COMMENT '0 = Portrait, 1 = Landscape, 2 = Both',
  `optional` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 = false, 1 = true',
  PRIMARY KEY (`ID`),
  KEY `fk_questionSection_questionId_question_ID` (`questionId`),
  KEY `fk_questionSection_sectionId_section_ID` (`sectionId`),
  CONSTRAINT `fk_questionSection_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`),
  CONSTRAINT `fk_questionSection_sectionId_section_ID` FOREIGN KEY (`sectionId`) REFERENCES `section` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=778 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.radioButton
CREATE TABLE IF NOT EXISTS `radioButton` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_radioButton_questionId_question_ID` (`questionId`),
  CONSTRAINT `fk_radioButton_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.radioButtonOption
CREATE TABLE IF NOT EXISTS `radioButtonOption` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `fk_radioButtonOption_parentTableId_radioButton_ID` (`parentTableId`),
  KEY `fk_radioButtonOption_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_radioButtonOption_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_radioButtonOption_parentTableId_radioButton_ID` FOREIGN KEY (`parentTableId`) REFERENCES `radioButton` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=423 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.respondent
CREATE TABLE IF NOT EXISTS `respondent` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_respondent_title_dictionary_contentId` (`title`),
  KEY `fk_respondent_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_respondent_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_respondent_title_dictionary_contentId` FOREIGN KEY (`title`) REFERENCES `dictionary` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for procedure QuestionnaireDB.saveAnswer
DELIMITER //
CREATE PROCEDURE `saveAnswer`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_sectionId` BIGINT,
	IN `i_questionId` BIGINT,
	IN `i_questionTypeId` BIGINT,
	IN `i_isSkipped` TINYINT,
	IN `i_appVersion` VARCHAR(255),
	IN `i_isoLang` VARCHAR(2)
)
    DETERMINISTIC
BEGIN

	 /*
        author of update should be patientId(in questionnaireDB) + '_APP_' + appVersion

        1. get patientId and questionnaireId from answerQuestionnaire_id
        2. update status from new to in progress using answerQuestionnaire_id
        3. verify if the answerSection exist for that answerQuestionnaire_id
            3.1 if it exist take that ID as answerSectionId
                and verify if the answer exists for that ID
                    3.1.1 if it exists, mark it as deleted, go to 4.
                    3.1.2 if it does not exist, go to 4.
            3.2 if it does not exist, create one, and take the insertId as answerSectionId
        4. use answerSectionId from 3. and section_id, question_id, is_skipped, question_type_id from the param, questionnaireId from 1., and language from the db to insert into the answer table
         */

	/*
	note: wsReturn convention for this procedure: 
		success = 0, 
		language error = -1, 
		error in answerQuestionnaireId = -2 (no such incomplete questionnaire or more than one such questionnaire),
		error updating the status of the answered questionnaire = -3,
		error inserting a new answerSection = -4,
		error marking deletion of answers due to duplicated answerSection = -5,
		error marking deletion of answers due to rewriting the answer = -6,
		error inserting the answer into answer table = -7
	*/

	-- declare variables
	declare countLang, countExistingAnswer, countAnswerQuestionnaire, countAnswerSection, affected_row_count, wsReturn int;
	declare language_id, questionnaire_id, patient_id, existing_answerSection_id, inserted_answer_id bigint;
	declare default_isoLang varchar(2);
	declare author_of_update, wsReturnMessage varchar(255);
	declare existing_answerSection_id_concated, existing_answer_id_concated text;
	declare is_answered tinyint; 
	
	-- declare variables for error messages
	declare success, langErr, answerQuestionnaireIdErr, statusUpdateErr, insertAnswerSectionErr, answerSectionDuplicateErr, rewriteAnswerErr, insertAnswerErr int;
	declare success_message, langErr_message, answerQuestionnaireIdErr_message, statusUpdateErr_message, insertAnswerSectionErr_message, answerSectionDuplicateErr_message, rewriteAnswerErr_message, insertAnswerErr_message varchar(255);
	
	-- set error variables and messages
	set success = 0;
	set langErr = -1;
	set answerQuestionnaireIdErr = -2;
	set statusUpdateErr = -3;
	set insertAnswerSectionErr = -4;
	set answerSectionDuplicateErr = -5;
	set rewriteAnswerErr = -6;
	set insertAnswerErr = -7;
	
	set success_message = 'SUCCESS';
	set langErr_message = 'ERROR: cannot get a language id';
	set answerQuestionnaireIdErr_message = 'ERROR: no such incomplete questionnaire or more than one such questionnaire';
	set statusUpdateErr_message = 'ERROR: cannot update status of this questionnaire from new to in progress';
	set insertAnswerSectionErr_message = 'ERROR: failed to insert a new answerSection';
	set answerSectionDuplicateErr_message = 'ERROR: there is more than one row for an answerQuestionnaireId and a sectionId in the answerSection table, but could not mark the answers as deleted';
	set rewriteAnswerErr_message = 'ERROR: failed to mark existing answer as deleted';
	set insertAnswerErr_message = 'ERROR: failed to insert into answer table';
	
	-- set default language to French
	set default_isoLang = 'FR';
	
	-- get language
	select count(*), ID into countLang, language_id from language where isoLang = i_isoLang and deleted = 0 group by ID;
	
	-- label for early exit in case of error
	save_answer:BEGIN
	
		-- verify language is correct	
		if countLang <> 1 then
			
			-- try to get language again using default language
			select count(*), ID into countLang, language_id from language where isoLang = default_isoLang and deleted = 0 group by ID;
			
			-- verify again that language is correct	
			if countLang <> 1 then
				set wsReturn = langErr;
				set wsReturnMessage = langErr_message;
				
				leave save_answer;
			end if;
			
		end if;
		
		-- 1. get patientId and questionnaireId from answerQuestionnaire_id
		SELECT count(*), patientId, questionnaireId into countAnswerQuestionnaire, patient_id, questionnaire_id
		FROM answerQuestionnaire
		WHERE ID = i_answerQuestionnaireId AND deleted = 0 AND `status` <> 2
		group by patientId, questionnaireId;
		
		-- verify if there is only one patientId and questionnaireId for the given answerQuestionnaireId
		if countAnswerQuestionnaire <> 1 then
			set wsReturn = answerQuestionnaireIdErr;
			set wsReturnMessage = answerQuestionnaireIdErr_message;
			
			leave save_answer;
		end if;
		
		-- set author of update: author of update should be patientId(in questionnaireDB) + '_APP_' + appVersion
		select concat(patient_id, '_APP_', i_appVersion) into author_of_update;
		
		-- 2. update status from new to in progress using answerQuestionnaire_id
		UPDATE `answerQuestionnaire` SET `status` = '1', `lastUpdated` = CURRENT_TIMESTAMP, `updatedBy` = author_of_update WHERE `ID` = i_answerQuestionnaireId;
		
		select ROW_COUNT() into affected_row_count;
			
		-- verify that the row has been updated correctly
		if affected_row_count <> 1 then 
			set wsReturn = statusUpdateErr;
			set wsReturnMessage = statusUpdateErr_message;
			
			leave save_answer;
		else
			-- reset the variable for future use
			set affected_row_count = -1;
		end if;
		
		-- 3. verify if the answerSection exist for that answerQuestionnaire_id 
		-- note that the answerSectionId are concatonated due to maybe there is an error in inserts and there are more than one ID matching the conditions
		select count(*), group_concat(answerSection.ID), max(answerSection.ID) into countAnswerSection, existing_answerSection_id_concated, existing_answerSection_id
		from answerSection 
		where answerSection.answerQuestionnaireId = i_answerQuestionnaireId 
			and answerSection.sectionId = i_sectionId;
			
		/*
		3.1 if it exist take that ID as answerSectionId and verify if the answer exists for that ID
         3.1.1 if it exists, mark it as deleted, go to 4. 
         3.1.2 if the answer does not exist, go to 4.
      */
		
		-- this is for error handling, when there is more than one row for an answerQuestionnaireId and a sectionId in the answerSection table, but the answers are not deleted
		if countAnswerSection > 1 then
			
			-- if they have non deleted answers, set the answers to deleted
			set @wsSQL = concat(
				"select count(*), group_concat(ID) into @countExistingAnswer, @existing_answer_id_concated
				from answer a
				where a.deleted = 0
					and a.answerSectionId IN (", existing_answerSection_id_concated, ")
					and a.answerSectionId <> ", existing_answerSection_id, ";"
				);
			
			-- execute SQL statement
			prepare stmt from @wsSQL;
	
			Execute stmt;
			
			deallocate prepare stmt;
			
			if @countExistingAnswer > 0 then
				
				set @wsSQL = concat(
					"update answer
					set deleted = 1,
						deletedBy = '", author_of_update, "',
						updatedBy = '", author_of_update, "'
					where ID in (", @existing_answer_id_concated, ");"
				);
			  
				-- execute SQL statement
				prepare stmt from @wsSQL;
		
				Execute stmt;
				select ROW_COUNT() into affected_row_count;	-- this needs to follow execute to have the correct row count.
				
				deallocate prepare stmt;
		
				-- verify that the rows have been updated correctly
				if affected_row_count = 0 then 
					set wsReturn = answerSectionDuplicateErr;
					set wsReturnMessage = answerSectionDuplicateErr_message;
					
					leave save_answer;
				else
					-- reset the variable for future use
					set affected_row_count = -1;
				end if;
			end if;
		
		end if;
		
		-- 3.1.1 if answerSection exists, and contain answer for that question, mark it as deleted, go to 4. 
		if countAnswerSection > 0 then
			
			-- verify if the answer exists for that ID
			select count(*), group_concat(ID) into countExistingAnswer, existing_answer_id_concated
			from answer
			where answerSectionId = existing_answerSection_id
				and deleted = 0
				and questionnaireId = questionnaire_id
				and sectionId = i_sectionId
				and questionId = i_questionId
				and patientId = patient_id
			;
			
			-- mark it as deleted, go to 4. 
			if countExistingAnswer > 0 then
				set @wsSQL = concat(
					"update answer
					set deleted = 1,
						deletedBy = '", author_of_update, "',
						updatedBy = '", author_of_update, "'
					where ID in (", existing_answer_id_concated, ");"
				);
			
			
				-- execute SQL statement
				prepare stmt from @wsSQL;
		
				Execute stmt;
				select ROW_COUNT() into affected_row_count;	-- this must follow execute to have the correct behaviour
				
				deallocate prepare stmt;
				
				-- verify that the rows have been updated correctly
				if affected_row_count = 0 then 
					set wsReturn = rewriteAnswerErr;
					set wsReturnMessage = rewriteAnswerErr_message;
					
					leave save_answer;
				else
					-- reset the variable for future use
					set affected_row_count = -1;
				end if;
			end if;		
		
		else
					
			-- there is no answerSection which has answers non deleted
			-- 3.2 if answerSection does not exist, create one, and take the insertId as answerSectionId
			INSERT INTO answerSection (`answerQuestionnaireId`, `sectionId`) VALUES (i_answerQuestionnaireId, i_sectionId);
			set existing_answerSection_id = LAST_INSERT_ID();
			
			select ROW_COUNT() into affected_row_count;
			
			-- verify that the row has been inserted correctly
			if affected_row_count <> 1 then 
				set wsReturn = insertAnswerSectionErr;
				set wsReturnMessage = insertAnswerSectionErr_message;
				leave save_answer;
			else
				-- reset the variable for future use
				set affected_row_count = -1;
			end if;
			
		end if;
		
		-- 4. use answerSectionId from 3. and section_id, question_id, is_skipped, question_type_id from the param, questionnaireId from 1., and language from the db to insert into the answer table
		set is_answered = 1 - i_isSkipped;
		
		INSERT INTO `answer` (`questionnaireId`, `sectionId`, `questionId`, `typeId`, `answerSectionId`, `languageId`, `patientId`, `answered`, `skipped`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `updatedBy`) 
		VALUES (questionnaire_id, i_sectionId, i_questionId, i_questionTypeId, existing_answerSection_id, language_id, patient_id, is_answered, i_isSkipped, 0, '', CURRENT_TIMESTAMP, author_of_update, author_of_update);
		
		set inserted_answer_id = LAST_INSERT_ID();
		
		select ROW_COUNT() into affected_row_count;
			
		-- verify that the row has been inserted correctly
		if affected_row_count <> 1 then 
			set wsReturn = insertAnswerErr;
			set wsReturnMessage = insertAnswerErr_message;
			leave save_answer;
		else
			-- reset the variable for future use
			set affected_row_count = -1;
		end if;
		
		-- set return as success
		set wsReturn = success;
		set wsReturnMessage = success_message;
		
	END; -- end of save_answer label
	
	select wsReturn as procedure_status,
		wsReturnMessage as procedure_message,
		inserted_answer_id as inserted_answer_id
	;	

END//
DELIMITER ;

-- Dumping structure for table QuestionnaireDB.section
CREATE TABLE IF NOT EXISTS `section` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionnaireId` bigint(20) NOT NULL,
  `title` bigint(20) NOT NULL,
  `instruction` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_section_deleted` (`deleted`),
  KEY `fk_section_questionnaireId_questrionnaire_ID` (`questionnaireId`),
  KEY `fk_section_instruction_dictionary_contentId` (`instruction`),
  KEY `fk_section_title_dictionary_contentId` (`title`),
  CONSTRAINT `fk_section_instruction_dictionary_contentId` FOREIGN KEY (`instruction`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_questionnaireId_questrionnaire_ID` FOREIGN KEY (`questionnaireId`) REFERENCES `questionnaire` (`ID`),
  CONSTRAINT `fk_section_title_dictionary_contentId` FOREIGN KEY (`title`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.slider
CREATE TABLE IF NOT EXISTS `slider` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  `minValue` float NOT NULL,
  `maxValue` float NOT NULL,
  `minCaption` bigint(20) NOT NULL,
  `maxCaption` bigint(20) NOT NULL,
  `increment` float NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_slider_minCaption_dictionnary_contentId` (`minCaption`),
  KEY `fk_slider_maxCaption_dictionnary_contentId` (`maxCaption`),
  KEY `fk_slider_question_ID` (`questionId`),
  CONSTRAINT `fk_slider_maxCaption_dictionnary_contentId` FOREIGN KEY (`maxCaption`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_slider_minCaption_dictionnary_contentId` FOREIGN KEY (`minCaption`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_slider_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for event QuestionnaireDB.SyncPublishQuestionnaire
DELIMITER //
CREATE EVENT `SyncPublishQuestionnaire` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-24 14:05:11' ON COMPLETION PRESERVE ENABLE DO BEGIN

/*
In short:
This event is a temporary solution for inserting new patient into the QuestionnaireDB and for moving questionnaires sent to patient from OpalDB.Questionnaire to QuestionnaireDB.AnswerQuestionnaire table.
This is required to make questionnaire work

In details:
This event is used to migrate from questionnaire V1 (Legacy questionnaire with QuestionnaireDB) to questionnaireV2 (New questionnaire front-end which gets everything from the QuestionnaireDB)

This event first imports patients in opalDB (in opalDB.Patient table) into QuestionnaireDB (in QuestionnaireDB.patient table).
This event imports new questionnaire from the opalDB.Questionnaire into the QuestionnaireDB.answerQuestionnaire, and write the newly created ID of QuestionnaireDB.answerQuestionnaire into opalDB.Questionnaire.

This event access both the opalDB and the QuestionnaireDB.
Note that the opalDB has uppercase names (e.g. Patient), while the QuestionnaireDB has lowercase / camel case names (e.g. patient)

More in details, this event:
1) imports the new patients in opalDB into questionnaireDB
2) gets the new non-completed questionnaire(s) from the opalDB.Questionnaire table
3) finds out the corresponding non deleted patientId in QuestionnaireDB
4) inserts the questionnaire(s) into QuestionnaireDB.answerQuestionnaire with following two fields having a special meaning
4.1) The `deleted` field will be marked with a special flag indicating that it is currently used by the migration tools
4.2) The `deletedBy` field will be marked with opalDB.Questionnaire.QuestionnaireSerNum
Since the QuestionnaireDB.answerQuestionnaire does not have any foreign key to opalDB.Questionnaire, if we simply insert into QuestionnaireDB, we do not know which record in QuestionnaireDB matches which in opalDB.
The solution to this is to temporarily use the `deletedBy` field as a foreign key to opalDB.Questionnaire.QuestionnaireSerNum.
5) updates the field `PatientQuestionnaireDBSerNum` of opalDB.Questionnaire using the two special fields mentionned above.
6) sets the fields `deleted` and `deletedBy` of QuestionnaireDB.answerQuestionnaire back to normal

last updated: 21/02/2020
*/

-- declare variables
DECLARE specialDeletedFlag, statusToBeInserted INT;
DECLARE authorOfUpdate, opalDBName, questionnaireDBName VARCHAR(255);

-- set variables for easier changes
SET specialDeletedFlag = 2;
SET statusToBeInserted = 0; -- this means new questionnaire for the QuestionnaireDB
SET authorOfUpdate = 'QUESTIONNAIRE_V2_AUTO_SYNC';
SET opalDBName = 'OpalDB';
SET questionnaireDBName = 'QuestionnaireDB';

-- update patient records
   SET @wsSQL = CONCAT(
        "INSERT INTO ", questionnaireDBName,".patient (`hospitalId`, `externalId`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`)
Select -1, PatientSerNum, 0, '', now(), '", authorOfUpdate,"', now(), '", authorOfUpdate,"'
from ", opalDBName,".Patient
where PatientSerNum not in (select externalId from ", questionnaireDBName,".patient);"
   );
   
   -- execute SQL statement
prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;
   
   -- insert into QuestionnaireDB
SET @wsSQL = CONCAT(
"INSERT INTO ", questionnaireDBName, ".answerQuestionnaire (`questionnaireId`, `patientId`, `status`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`)
SELECT qc.QuestionnaireDBSerNum, QP.ID, ", statusToBeInserted, ", ", specialDeletedFlag, ", q.QuestionnaireSerNum, q.DateAdded, '", authorOfUpdate, "', q.DateAdded, '", authorOfUpdate, "'
FROM ", opalDBName, ".Questionnaire q, ", opalDBName, ".QuestionnaireControl qc, ", questionnaireDBName,".patient QP
WHERE q.QuestionnaireControlSerNum = qc.QuestionnaireControlSerNum
AND q.PatientSerNum = QP.externalId
AND q.CompletedFlag = 0
AND QP.deleted <> 1
AND q.PatientQuestionnaireDBSerNum IS NULL
AND qc.QuestionnaireDBSerNum IN (SELECT QQ.ID from ", questionnaireDBName, ".questionnaire QQ);
;"
);

-- execute SQL statement
prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;

-- update the opalDB.Questionnaire with the previous inserted ID(s)
SET @wsSQL = CONCAT(
"UPDATE ", opalDBName, ".Questionnaire q, ", questionnaireDBName, ".answerQuestionnaire QAQ
SET q.PatientQuestionnaireDBSerNum = QAQ.ID
WHERE q.QuestionnaireSerNum = QAQ.deletedBy
AND QAQ.deleted = ", specialDeletedFlag, "
AND q.CompletedFlag = 0
;"
);

-- execute SQL statement
prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;

-- clear the QuestionnaireDB special fields
SET @wsSQL = CONCAT(
"UPDATE ", opalDBName, ".Questionnaire q, ", questionnaireDBName, ".answerQuestionnaire QAQ
SET QAQ.deleted = 0, QAQ.deletedBy = ''
WHERE QAQ.deleted = ", specialDeletedFlag, "
AND q.PatientQuestionnaireDBSerNum = QAQ.ID
;"
);

-- execute SQL statement
prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;
   
END//
DELIMITER ;

-- Dumping structure for table QuestionnaireDB.tag
CREATE TABLE IF NOT EXISTS `tag` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag` bigint(20) NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_tag_deleted` (`deleted`),
  KEY `fk_tag_tag_dictionary_contentId` (`tag`),
  CONSTRAINT `fk_tag_tag_dictionary_contentId` FOREIGN KEY (`tag`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.tagLibrary
CREATE TABLE IF NOT EXISTS `tagLibrary` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `tagId` bigint(20) NOT NULL,
  `libraryId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tagLibrary_tagId_tag_ID` (`tagId`),
  KEY `fk_tagLibrary_libraryId_library_ID` (`libraryId`),
  CONSTRAINT `fk_tagLibrary_libraryId_library_ID` FOREIGN KEY (`libraryId`) REFERENCES `library` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tagLibrary_tagId_tag_ID` FOREIGN KEY (`tagId`) REFERENCES `tag` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.tagQuestion
CREATE TABLE IF NOT EXISTS `tagQuestion` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `tagId` bigint(20) NOT NULL,
  `questionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tagQuestion_questionId_question_ID` (`questionId`),
  KEY `fk_tagQuestion_tagId_tag_ID` (`tagId`),
  CONSTRAINT `fk_tagQuestion_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`),
  CONSTRAINT `fk_tagQuestion_tagId_tag_ID` FOREIGN KEY (`tagId`) REFERENCES `tag` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestion
CREATE TABLE IF NOT EXISTS `templateQuestion` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OAUserId` bigint(20) NOT NULL DEFAULT -1,
  `name` bigint(20) NOT NULL,
  `typeId` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `parentId` bigint(20) NOT NULL DEFAULT -1,
  `polarity` tinyint(4) NOT NULL DEFAULT 0,
  `private` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_templateQuestion_deleted` (`deleted`),
  KEY `idx_templateQuestion_OAUserId` (`OAUserId`),
  KEY `idx_templateQuestion_parentId` (`parentId`),
  KEY `fk_templateQuestion_name_dictionary_contentId` (`name`),
  KEY `fk_templateQuestionId_typeId_type_ID` (`typeId`),
  CONSTRAINT `fk_templateQuestionId_typeId_type_ID` FOREIGN KEY (`typeId`) REFERENCES `type` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_templateQuestion_name_dictionary_contentId` FOREIGN KEY (`name`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionCheckbox
CREATE TABLE IF NOT EXISTS `templateQuestionCheckbox` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `templateQuestionId` bigint(20) NOT NULL,
  `minAnswer` int(11) NOT NULL DEFAULT 0,
  `maxAnswer` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `fk_tqc_templateQuestionId_templateQuestion_ID` (`templateQuestionId`),
  CONSTRAINT `fk_tqc_templateQuestionId_templateQuestion_ID` FOREIGN KEY (`templateQuestionId`) REFERENCES `templateQuestion` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionCheckboxOption
CREATE TABLE IF NOT EXISTS `templateQuestionCheckboxOption` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `specialAction` int(11) NOT NULL COMMENT '0 = nothing special, 1 = check everything, 2 = uncheck everything',
  PRIMARY KEY (`ID`),
  KEY `fk_tqco_parentTableId_templateQuestionCheckbox_ID` (`parentTableId`),
  KEY `fk_tqco_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_tqco_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tqco_parentTableId_templateQuestionCheckbox_ID` FOREIGN KEY (`parentTableId`) REFERENCES `templateQuestionCheckbox` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionDate
CREATE TABLE IF NOT EXISTS `templateQuestionDate` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `templateQuestionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tqd_templateQuestionId_templateQuestion_ID` (`templateQuestionId`),
  CONSTRAINT `fk_tqd_templateQuestionId_templateQuestion_ID` FOREIGN KEY (`templateQuestionId`) REFERENCES `templateQuestion` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionLabel
CREATE TABLE IF NOT EXISTS `templateQuestionLabel` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `templateQuestionId` bigint(20) NOT NULL,
  `displayIntensity` int(11) NOT NULL DEFAULT 0,
  `pathImage` varchar(512) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tql_templateQuestionId_templateQuestion_ID` (`templateQuestionId`),
  CONSTRAINT `fk_tql_templateQuestionId_templateQuestion_ID` FOREIGN KEY (`templateQuestionId`) REFERENCES `templateQuestion` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionLabelOption
CREATE TABLE IF NOT EXISTS `templateQuestionLabelOption` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  `posInitX` int(11) NOT NULL DEFAULT 0,
  `posInitY` int(11) NOT NULL DEFAULT 0,
  `posFinalX` int(11) NOT NULL DEFAULT 0,
  `posFinalY` int(11) NOT NULL DEFAULT 0,
  `intensity` int(11) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `fk_tqlo_parentTableId_templateQuestionLabel_ID` (`parentTableId`),
  KEY `fk_tqlo_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_tqlo_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tqlo_parentTableId_templateQuestionLabel_ID` FOREIGN KEY (`parentTableId`) REFERENCES `templateQuestionLabel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionRadioButton
CREATE TABLE IF NOT EXISTS `templateQuestionRadioButton` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `templateQuestionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tqrb_templateQuestionId_templateQuestion_ID` (`templateQuestionId`),
  CONSTRAINT `fk_tqrb_templateQuestionId_templateQuestion_ID` FOREIGN KEY (`templateQuestionId`) REFERENCES `templateQuestion` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionRadioButtonOption
CREATE TABLE IF NOT EXISTS `templateQuestionRadioButtonOption` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `fk_tqrbo_parentTableId_templateQuestionRadioButton_ID` (`parentTableId`),
  KEY `fk_tqrbo_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_tqrbo_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tqrbo_parentTableId_templateQuestionRadioButton_ID` FOREIGN KEY (`parentTableId`) REFERENCES `templateQuestionRadioButton` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionSlider
CREATE TABLE IF NOT EXISTS `templateQuestionSlider` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `templateQuestionId` bigint(20) NOT NULL,
  `minValue` float NOT NULL,
  `maxValue` float NOT NULL,
  `minCaption` bigint(20) NOT NULL,
  `maxCaption` bigint(20) NOT NULL,
  `increment` float NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tqs_templateQuestionId_templateQuestion_ID` (`templateQuestionId`),
  KEY `fk_tqs_minContent_dictionary_contentId` (`minCaption`),
  KEY `fk_tqs_maxContent_dictionary_contentId` (`maxCaption`),
  CONSTRAINT `fk_tqs_maxContent_dictionary_contentId` FOREIGN KEY (`maxCaption`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tqs_minContent_dictionary_contentId` FOREIGN KEY (`minCaption`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tqs_templateQuestionId_templateQuestion_ID` FOREIGN KEY (`templateQuestionId`) REFERENCES `templateQuestion` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionTextBox
CREATE TABLE IF NOT EXISTS `templateQuestionTextBox` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `templateQuestionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tqtb_templateQuestionId_templateQuestion_ID` (`templateQuestionId`),
  CONSTRAINT `fk_tqtb_templateQuestionId_templateQuestion_ID` FOREIGN KEY (`templateQuestionId`) REFERENCES `templateQuestion` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionTextBoxTrigger
CREATE TABLE IF NOT EXISTS `templateQuestionTextBoxTrigger` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `fk_tqtt_parentTableId_templateQuestionTextBox_ID` (`parentTableId`),
  KEY `fk_tqtt_description_dictionnary_contentId` (`description`),
  CONSTRAINT `fk_tqtt_description_dictionnary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tqtt_parentTableId_templateQuestionTextBox_ID` FOREIGN KEY (`parentTableId`) REFERENCES `templateQuestionTextBox` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.templateQuestionTime
CREATE TABLE IF NOT EXISTS `templateQuestionTime` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `templateQuestionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_tqt_templateQuestionId_templateQuestion_ID` (`templateQuestionId`),
  CONSTRAINT `fk_tqt_templateQuestionId_templateQuestion_ID` FOREIGN KEY (`templateQuestionId`) REFERENCES `templateQuestion` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.textBox
CREATE TABLE IF NOT EXISTS `textBox` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_textBox_questionId_question_ID` (`questionId`),
  CONSTRAINT `fk_textBox_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.textBoxTrigger
CREATE TABLE IF NOT EXISTS `textBoxTrigger` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentTableId` bigint(20) NOT NULL,
  `description` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `fk_textBoxTrigger_parentTableId_textBox_ID` (`parentTableId`),
  KEY `fk_textBoxTrigger_description_dictionary_contentId` (`description`),
  CONSTRAINT `fk_textBoxTrigger_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_textBoxTrigger_parentTableId_textBox_ID` FOREIGN KEY (`parentTableId`) REFERENCES `textBox` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.time
CREATE TABLE IF NOT EXISTS `time` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_time_questionId_question_ID` (`questionId`),
  CONSTRAINT `fk_time_questionId_question_ID` FOREIGN KEY (`questionId`) REFERENCES `question` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table QuestionnaireDB.type
CREATE TABLE IF NOT EXISTS `type` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` bigint(20) NOT NULL,
  `tableId` bigint(20) NOT NULL,
  `subTableId` bigint(20) NOT NULL,
  `templateTableId` bigint(20) NOT NULL,
  `templateSubTableId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_type_description_dictionary_contentId` (`description`),
  KEY `fk_type_tableId_definitionTable_ID` (`tableId`),
  KEY `fk_type_subTableId_definitionTable_ID` (`subTableId`),
  KEY `fk_type_templateTableId_definitionTable_ID` (`templateTableId`),
  KEY `fk_type_templateSubTableId_definitionTable_ID` (`templateSubTableId`),
  CONSTRAINT `fk_type_description_dictionary_contentId` FOREIGN KEY (`description`) REFERENCES `dictionary` (`contentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_subTableId_definitionTable_ID` FOREIGN KEY (`subTableId`) REFERENCES `definitionTable` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_tableId_definitionTable_ID` FOREIGN KEY (`tableId`) REFERENCES `definitionTable` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_templateSubTableId_definitionTable_ID` FOREIGN KEY (`templateSubTableId`) REFERENCES `definitionTable` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_type_templateTableId_definitionTable_ID` FOREIGN KEY (`templateTableId`) REFERENCES `definitionTable` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for procedure QuestionnaireDB.updateAnswerQuestionnaireStatus
DELIMITER //
CREATE PROCEDURE `updateAnswerQuestionnaireStatus`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_newStatus` BIGINT,
	IN `i_appVersion` VARCHAR(255)
)
    DETERMINISTIC
BEGIN

	-- declare variables
	declare author_of_update, wsReturnMessage varchar(255);
	declare countAnswerQuestionnaire, affected_row_count, wsReturn int;
	declare patient_id bigint;
	
	-- declare variables for error messages
	declare success, answerQuestionnaireIdErr, statusUpdateErr int;
	declare success_message, answerQuestionnaireIdErr_message, statusUpdateErr_message varchar(255);
	
	-- set error variables and messages
	set success = 0;
	set answerQuestionnaireIdErr = -1;
	set statusUpdateErr = -2; 
	
	set success_message = 'SUCCESS';
	set answerQuestionnaireIdErr_message = 'ERROR: no such questionnaire or more than one such questionnaire';
	set statusUpdateErr_message = 'ERROR: cannot update status of this questionnaire';
	
	updateStatus:BEGIN
		-- 1. get patientId from answerQuestionnaire_id
		SELECT count(*), patientId into countAnswerQuestionnaire, patient_id
		FROM answerQuestionnaire
		WHERE ID = i_answerQuestionnaireId AND deleted = 0
		GROUP BY patientId;
		
		-- verify if there is only one patientId for the given answerQuestionnaireId
		if countAnswerQuestionnaire <> 1 then
			set wsReturn = answerQuestionnaireIdErr;
			set wsReturnMessage = answerQuestionnaireIdErr_message;
			
			leave updateStatus;
		end if;
		
		-- set author of update: author of update should be patientId(in questionnaireDB) + '_APP_' + appVersion
		select concat(patient_id, '_APP_', i_appVersion) into author_of_update;
		
		-- 2. update status using answerQuestionnaire_id
		UPDATE `answerQuestionnaire` SET `status` = i_newStatus, `lastUpdated` = CURRENT_TIMESTAMP, `updatedBy` = author_of_update WHERE `ID` = i_answerQuestionnaireId;
		
		select ROW_COUNT() into affected_row_count;
			
		-- verify that the row has been updated correctly
		if affected_row_count <> 1 then 
			set wsReturn = statusUpdateErr;
			set wsReturnMessage = statusUpdateErr_message;
			
			leave updateStatus;
		end if;
		
		-- set return as success
		set wsReturn = success;
		set wsReturnMessage = success_message;
		
	END; -- End of updateStatus label

	select wsReturn as procedure_status, wsReturnMessage as procedure_message;
	
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
