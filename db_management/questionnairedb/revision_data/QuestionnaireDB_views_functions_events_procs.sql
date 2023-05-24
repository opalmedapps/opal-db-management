-- Adminer 4.8.1 MySQL 5.5.5-10.6.13-MariaDB-1:10.6.13+maria~ubu2004 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

DROP FUNCTION IF EXISTS `getAnswerTableOptionID`;
CREATE FUNCTION `getAnswerTableOptionID`(`i_questionID` BIGINT,
`i_content` VARCHAR(255
),
`i_answerTypeID` BIGINT

) RETURNS bigint(20)
    DETERMINISTIC
BEGIN


Declare wsReturn, wsCount int;
Declare wsQuestionID, wsAnswerTypeID bigint;
Declare wsContent varchar(255);


set wsReturn = -1;
Set wsContent = i_content;
Set wsAnswerTypeID = i_answerTypeID;
Set wsQuestionID = i_questionID;




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
AND tableId IN (12, 17, 31)
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
AND tableId IN (12, 17, 31)
)
LIMIT 1
);
end if;

set wsReturn = ifnull(wsReturn, -1);
return wsReturn;


END;

DROP FUNCTION IF EXISTS `getDisplayName`;
CREATE FUNCTION `getDisplayName`(`i_ContentID` BIGINT,
	`i_LanguageID` BIGINT

) RETURNS mediumtext CHARSET utf8mb3 COLLATE utf8mb3_general_ci
    DETERMINISTIC
BEGIN

	Declare wsText, wsReturnText, wsReturn MEDIUMTEXT;
	Declare wsCount int;
	Declare dictId bigint;


	set wsText = '';
	set wsCount = 0;



	Select count(*), ID
	into wsCount, dictId
	from dictionary
	where contentId = i_ContentID and languageId = i_LanguageID
	group by ID;



  	if (wsCount = 0) then
		set wsReturn = wsText;
	else
		select content into wsReturnText
		from dictionary
		where ID = dictId;

		set wsReturn = wsReturnText;
	end if;

	Return wsReturn;

END;

DROP PROCEDURE IF EXISTS `getAnswerByAnswerQuestionnaireIdAndQuestionSectionId`;
CREATE PROCEDURE `getAnswerByAnswerQuestionnaireIdAndQuestionSectionId`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_questionSectionId` BIGINT
)
    DETERMINISTIC
BEGIN




	declare lang_to_display, question_ID, section_ID bigint;


	set lang_to_display = 2;


	select qSec.questionId, qSec.sectionId into question_ID, section_ID
	from questionSection qSec
	where qSec.ID = i_questionSectionId;


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
			AND A.typeId IN (3,2,7,6,4)
	UNION
	Select A.answerSectionId, CONVERT(getDisplayName(cOpt.description, lang_to_display), CHAR(516)) AS Answer
	from answer A, answerCheckbox aC, checkboxOption cOpt
	where A.deleted <> 1
		and A.questionId = question_ID
		and A.sectionId = section_ID
		and aC.answerId = A.ID
		AND cOpt.ID = aC.`value`
		AND A.typeId = 1
	UNION
	Select A.answerSectionId, CONVERT(getDisplayName(lOpt.description, lang_to_display), CHAR(516)) AS Answer
	from answer A, answerLabel aL, labelOption lOpt
	where A.deleted <> 1
		and A.questionId = question_ID
		and A.sectionId = section_ID
		and aL.answerId = A.ID
		AND lOpt.ID = aL.`value`
		AND A.typeId = 5
	) B
	Where
		aSec.sectionId = section_ID
		and B.answerSectionId = aSec.ID
		and aSec.answerQuestionnaireId = i_answerQuestionnaireId;

END;

DROP PROCEDURE IF EXISTS `getCompletedQuestionnaireInfo`;
CREATE PROCEDURE `getCompletedQuestionnaireInfo`(
	IN `i_patientSerNum` VARCHAR(64),
	IN `i_questionnaireId` BIGINT
)
BEGIN



	declare patientId BIGINT;

	select ID into patientId
	from patient
	where patient.externalId = i_patientSerNum;


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
		AND aq.`status` = 2
	Order By DATE_FORMAT(aq.lastUpdated, '%Y-%m-%d') desc, aq.ID asc, qSec.`order` asc
	;

END;

DROP PROCEDURE IF EXISTS `getLastAnsweredQuestionnaire`;
CREATE PROCEDURE `getLastAnsweredQuestionnaire`(
	IN `i_patientSerNum` VARCHAR(64),
	IN `i_questionnaireId` BIGINT
)
    DETERMINISTIC
BEGIN




	declare patient_ID BIGINT;


	select p.ID into patient_ID
	from patient p
	where p.externalId = i_patientSerNum
		and p.deleted = 0;


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

END;

DROP PROCEDURE IF EXISTS `getLastCompletedQuestionnaireByPatientId`;
CREATE PROCEDURE `getLastCompletedQuestionnaireByPatientId`(
	IN `i_patientId` BIGINT,
	IN `i_questionnaireId` BIGINT
)
    DETERMINISTIC
BEGIN


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

END;

DROP PROCEDURE IF EXISTS `getQuestionnaireInfo`;
CREATE PROCEDURE `getQuestionnaireInfo`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_isoLang` VARCHAR(2)
)
    DETERMINISTIC
BEGIN





	declare wsCountLang, wsCountQuestionnaire, wsReturn, questionnaire_status int;
	declare questionnaire_id bigint;
	declare language_id bigint;
	declare default_isoLang varchar(2);
	declare answer_id_text text;


	set default_isoLang = 'FR';




	select count(*), ID into wsCountLang, language_id from language where isoLang = i_isoLang and deleted = 0 group by ID;


	get_questionnaire:BEGIN


		if wsCountLang <> 1 then


			select count(*), ID into wsCountLang, language_id from language where isoLang = default_isoLang and deleted = 0 group by ID;


			if wsCountLang <> 1 then
				set wsReturn = -1;
				leave get_questionnaire;
			end if;

		end if;


		select count(*), aq.questionnaireId, aq.`status` into wsCountQuestionnaire, questionnaire_id, questionnaire_status
		from answerQuestionnaire aq
		where aq.ID = i_answerQuestionnaireId
			and aq.deleted = 0
		group by aq.questionnaireId, aq.`status`
		;


		if wsCountQuestionnaire <> 1 then
			set wsReturn = -2;
			leave get_questionnaire;
		end if;



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

			select questionnaire_status as status;

		else




			drop table if exists answer_summary2;
			create temporary table if not exists answer_summary2 as (
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


			select GROUP_CONCAT(answer_id) into answer_id_text from answer_summary2;


			set answer_id_text = COALESCE(answer_id_text, "-1");



			set @wsSQL = concat(
				"select answer_summary2.*,
					a.answer_value,
					a.answer_option_text,
					a.intensity,
					a.posX,
					a.posY,
					a.selected
				from answer_summary2 left join (
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
				on (answer_summary2.answer_id = a.answer_id)
				;"
			);


			prepare stmt from @wsSQL;

			Execute stmt;
			deallocate prepare stmt;

		end if;

		set wsReturn = 0;

	END;

	select wsReturn as procedure_status, language_id as language_id;

END;

DROP PROCEDURE IF EXISTS `getQuestionnaireList`;
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

END;

DROP PROCEDURE IF EXISTS `getQuestionnaireListORMS`;
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


	prepare stmt from @wsSQL;

	Execute stmt;

	deallocate prepare stmt;
END;

DROP PROCEDURE IF EXISTS `getQuestionNameAndAnswer`;
CREATE PROCEDURE `getQuestionNameAndAnswer`(
	IN `i_patientId` VARCHAR(50),
	IN `i_questionnaireId` BIGINT,
	IN `i_questionText` MEDIUMTEXT,
	IN `i_opalDBName` VARCHAR(50)
)
    DETERMINISTIC
BEGIN




	declare patientId_OpalDB INT(11);
	declare patienId_questionnaireDB BIGINT;
	declare answer_lang_Id BIGINT;

	set answer_lang_Id = 2;


	set @wsSQL = concat(
		"select p.PatientSerNum into @patientId_OpalDB
		from ", i_opalDBName, ".Patient p
		where p.PatientId = ", i_patientId, ";"
	);


	prepare stmt from @wsSQL;

	Execute stmt;

	select @patientId_OpalDB into patientId_OpalDB;

	deallocate prepare stmt;


	select p.ID into patienId_questionnaireDB
	from patient p
	where p.externalId = patientId_OpalDB
		and p.deleted = 0;


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

END;

DROP PROCEDURE IF EXISTS `getQuestionNameAndAnswerByID`;
CREATE PROCEDURE `getQuestionNameAndAnswerByID`(
	IN `i_patientId` VARCHAR(50),
	IN `i_questionnaireId` BIGINT,
	IN `i_questionText` MEDIUMTEXT,
	IN `i_opalDBName` VARCHAR(50),
	IN `i_questionID` BIGINT
)
    DETERMINISTIC
BEGIN




	declare patientId_OpalDB INT(11);
	declare patienId_questionnaireDB BIGINT;
	declare answer_lang_Id BIGINT;

	set answer_lang_Id = 2;


	set @wsSQL = concat(
		"select p.PatientSerNum into @patientId_OpalDB
		from ", i_opalDBName, ".Patient p
		where p.PatientId = ", i_patientId, ";"
	);


	prepare stmt from @wsSQL;

	Execute stmt;

	select @patientId_OpalDB into patientId_OpalDB;

	deallocate prepare stmt;


	select p.ID into patienId_questionnaireDB
	from patient p
	where p.externalId = patientId_OpalDB
		and p.deleted = 0;


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

END;

DROP PROCEDURE IF EXISTS `getQuestionOptions`;
CREATE PROCEDURE `getQuestionOptions`(
	IN `i_typeId` BIGINT,
	IN `i_questionId` TEXT,
	IN `i_languageId` BIGINT
)
    DETERMINISTIC
BEGIN




	declare wsReturn int;
	declare tableName, subTableName varchar(255);

	get_options: BEGIN


		if (length(trim(i_questionId)) = 0) then
			set wsReturn = 0;
			leave get_options;
		end if;


		select
			(select def.name from definitionTable def where def.ID = type.tableId) as tableName,
			if (type.subTableId = -1, '-1', (select def.name from definitionTable def where def.ID = type.subTableId)) as subTableName
			into tableName, subTableName
		from type
		where type.ID = i_typeId;


		if tableName IS NULL then
			set wsReturn = -1;
			leave get_options;
		end if;


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


		elseif subTableName = '-1' then
			set @wsSQL = concat(
				"select *
				from ", tableName, " t
				where t.questionId in (", i_questionId, ");
				"
			);


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


		prepare stmt from @wsSQL;

		Execute stmt;
		deallocate prepare stmt;


		set wsReturn = 0;

	END;

	select wsReturn as procedure_status, i_typeId as type_id, tableName as type_table_name;

END;

DROP PROCEDURE IF EXISTS `queryAnswers`;
CREATE PROCEDURE `queryAnswers`(
	IN `i_answerQuestionnaireId` TEXT,
	IN `i_languageId` BIGINT



)
    DETERMINISTIC
BEGIN



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



END;

DROP PROCEDURE IF EXISTS `queryPatientQuestionnaireInfo`;
CREATE PROCEDURE `queryPatientQuestionnaireInfo`(
	IN `i_externalId` BIGINT


)
BEGIN



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



END;

DROP PROCEDURE IF EXISTS `queryQuestionChoices`;
CREATE PROCEDURE `queryQuestionChoices`(
	IN `i_questionID` TEXT

)
    DETERMINISTIC
BEGIN



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

END;

DROP PROCEDURE IF EXISTS `queryQuestionChoicesORMS`;
CREATE PROCEDURE `queryQuestionChoicesORMS`(
	IN `i_questionID` BIGINT
)
    DETERMINISTIC
BEGIN


	declare lang_to_display bigint;
	set lang_to_display = 2;

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

END;

DROP PROCEDURE IF EXISTS `queryQuestions`;
CREATE PROCEDURE `queryQuestions`(
	IN `i_questionnaireID` TEXT




)
    DETERMINISTIC
BEGIN



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

END;

DROP PROCEDURE IF EXISTS `saveAnswer`;
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






	declare countLang, countExistingAnswer, countAnswerQuestionnaire, countAnswerSection, affected_row_count, wsReturn int;
	declare language_id, questionnaire_id, patient_id, existing_answerSection_id, inserted_answer_id bigint;
	declare default_isoLang varchar(2);
	declare author_of_update, wsReturnMessage varchar(255);
	declare existing_answerSection_id_concated, existing_answer_id_concated text;
	declare is_answered tinyint;


	declare success, langErr, answerQuestionnaireIdErr, statusUpdateErr, insertAnswerSectionErr, answerSectionDuplicateErr, rewriteAnswerErr, insertAnswerErr int;
	declare success_message, langErr_message, answerQuestionnaireIdErr_message, statusUpdateErr_message, insertAnswerSectionErr_message, answerSectionDuplicateErr_message, rewriteAnswerErr_message, insertAnswerErr_message varchar(255);


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


	set default_isoLang = 'FR';


	select count(*), ID into countLang, language_id from language where isoLang = i_isoLang and deleted = 0 group by ID;


	save_answer:BEGIN


		if countLang <> 1 then


			select count(*), ID into countLang, language_id from language where isoLang = default_isoLang and deleted = 0 group by ID;


			if countLang <> 1 then
				set wsReturn = langErr;
				set wsReturnMessage = langErr_message;

				leave save_answer;
			end if;

		end if;


		SELECT count(*), patientId, questionnaireId into countAnswerQuestionnaire, patient_id, questionnaire_id
		FROM answerQuestionnaire
		WHERE ID = i_answerQuestionnaireId AND deleted = 0 AND `status` <> 2
		group by patientId, questionnaireId;


		if countAnswerQuestionnaire <> 1 then
			set wsReturn = answerQuestionnaireIdErr;
			set wsReturnMessage = answerQuestionnaireIdErr_message;

			leave save_answer;
		end if;


		select concat(patient_id, '_APP_', i_appVersion) into author_of_update;


		UPDATE `answerQuestionnaire` SET `status` = '1', `lastUpdated` = CURRENT_TIMESTAMP, `updatedBy` = author_of_update WHERE `ID` = i_answerQuestionnaireId;

		select ROW_COUNT() into affected_row_count;


		if affected_row_count <> 1 then
			set wsReturn = statusUpdateErr;
			set wsReturnMessage = statusUpdateErr_message;

			leave save_answer;
		else

			set affected_row_count = -1;
		end if;



		select count(*), group_concat(answerSection.ID), max(answerSection.ID) into countAnswerSection, existing_answerSection_id_concated, existing_answerSection_id
		from answerSection
		where answerSection.answerQuestionnaireId = i_answerQuestionnaireId
			and answerSection.sectionId = i_sectionId;




		if countAnswerSection > 1 then


			set @wsSQL = concat(
				"select count(*), group_concat(ID) into @countExistingAnswer, @existing_answer_id_concated
				from answer a
				where a.deleted = 0
					and a.answerSectionId IN (", existing_answerSection_id_concated, ")
					and a.answerSectionId <> ", existing_answerSection_id, ";"
				);


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


				prepare stmt from @wsSQL;

				Execute stmt;
				select ROW_COUNT() into affected_row_count;

				deallocate prepare stmt;


				if affected_row_count = 0 then
					set wsReturn = answerSectionDuplicateErr;
					set wsReturnMessage = answerSectionDuplicateErr_message;

					leave save_answer;
				else

					set affected_row_count = -1;
				end if;
			end if;

		end if;


		if countAnswerSection > 0 then


			select count(*), group_concat(ID) into countExistingAnswer, existing_answer_id_concated
			from answer
			where answerSectionId = existing_answerSection_id
				and deleted = 0
				and questionnaireId = questionnaire_id
				and sectionId = i_sectionId
				and questionId = i_questionId
				and patientId = patient_id
			;


			if countExistingAnswer > 0 then
				set @wsSQL = concat(
					"update answer
					set deleted = 1,
						deletedBy = '", author_of_update, "',
						updatedBy = '", author_of_update, "'
					where ID in (", existing_answer_id_concated, ");"
				);



				prepare stmt from @wsSQL;

				Execute stmt;
				select ROW_COUNT() into affected_row_count;

				deallocate prepare stmt;


				if affected_row_count = 0 then
					set wsReturn = rewriteAnswerErr;
					set wsReturnMessage = rewriteAnswerErr_message;

					leave save_answer;
				else

					set affected_row_count = -1;
				end if;
			end if;

		else



			INSERT INTO answerSection (`answerQuestionnaireId`, `sectionId`) VALUES (i_answerQuestionnaireId, i_sectionId);
			set existing_answerSection_id = LAST_INSERT_ID();

			select ROW_COUNT() into affected_row_count;


			if affected_row_count <> 1 then
				set wsReturn = insertAnswerSectionErr;
				set wsReturnMessage = insertAnswerSectionErr_message;
				leave save_answer;
			else

				set affected_row_count = -1;
			end if;

		end if;


		set is_answered = 1 - i_isSkipped;

		INSERT INTO `answer` (`questionnaireId`, `sectionId`, `questionId`, `typeId`, `answerSectionId`, `languageId`, `patientId`, `answered`, `skipped`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `updatedBy`)
		VALUES (questionnaire_id, i_sectionId, i_questionId, i_questionTypeId, existing_answerSection_id, language_id, patient_id, is_answered, i_isSkipped, 0, '', CURRENT_TIMESTAMP, author_of_update, author_of_update);

		set inserted_answer_id = LAST_INSERT_ID();

		select ROW_COUNT() into affected_row_count;


		if affected_row_count <> 1 then
			set wsReturn = insertAnswerErr;
			set wsReturnMessage = insertAnswerErr_message;
			leave save_answer;
		else

			set affected_row_count = -1;
		end if;


		set wsReturn = success;
		set wsReturnMessage = success_message;

	END;

	select wsReturn as procedure_status,
		wsReturnMessage as procedure_message,
		inserted_answer_id as inserted_answer_id
	;

END;

DROP PROCEDURE IF EXISTS `updateAnswerQuestionnaireStatus`;
CREATE PROCEDURE `updateAnswerQuestionnaireStatus`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_newStatus` BIGINT,
	IN `i_appVersion` VARCHAR(255)
)
    DETERMINISTIC
BEGIN


	declare author_of_update, wsReturnMessage varchar(255);
	declare countAnswerQuestionnaire, affected_row_count, wsReturn int;
	declare patient_id bigint;


	declare success, answerQuestionnaireIdErr, statusUpdateErr int;
	declare success_message, answerQuestionnaireIdErr_message, statusUpdateErr_message varchar(255);


	set success = 0;
	set answerQuestionnaireIdErr = -1;
	set statusUpdateErr = -2;

	set success_message = 'SUCCESS';
	set answerQuestionnaireIdErr_message = 'ERROR: no such questionnaire or more than one such questionnaire';
	set statusUpdateErr_message = 'ERROR: cannot update status of this questionnaire';

	updateStatus:BEGIN

		SELECT count(*), patientId into countAnswerQuestionnaire, patient_id
		FROM answerQuestionnaire
		WHERE ID = i_answerQuestionnaireId AND deleted = 0
		GROUP BY patientId;


		if countAnswerQuestionnaire <> 1 then
			set wsReturn = answerQuestionnaireIdErr;
			set wsReturnMessage = answerQuestionnaireIdErr_message;

			leave updateStatus;
		end if;


		select concat(patient_id, '_APP_', i_appVersion) into author_of_update;


		UPDATE `answerQuestionnaire` SET `status` = i_newStatus, `lastUpdated` = CURRENT_TIMESTAMP, `updatedBy` = author_of_update WHERE `ID` = i_answerQuestionnaireId;

		select ROW_COUNT() into affected_row_count;


		if affected_row_count <> 1 then
			set wsReturn = statusUpdateErr;
			set wsReturnMessage = statusUpdateErr_message;

			leave updateStatus;
		end if;


		set wsReturn = success;
		set wsReturnMessage = success_message;

	END;

	select wsReturn as procedure_status, wsReturnMessage as procedure_message;

END;

DROP EVENT IF EXISTS `SyncPublishQuestionnaire`;
CREATE EVENT `SyncPublishQuestionnaire` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-24 14:05:11' ON COMPLETION PRESERVE ENABLE DO BEGIN




DECLARE specialDeletedFlag, statusToBeInserted INT;
DECLARE authorOfUpdate, opalDBName, questionnaireDBName VARCHAR(255);


SET specialDeletedFlag = 2;
SET statusToBeInserted = 0;
SET authorOfUpdate = 'QUESTIONNAIRE_V2_AUTO_SYNC';
SET opalDBName = 'OpalDB';
SET questionnaireDBName = 'QuestionnaireDB';


   SET @wsSQL = CONCAT(
        "INSERT INTO ", questionnaireDBName,".patient (`hospitalId`, `externalId`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`)
Select -1, PatientSerNum, 0, '', now(), '", authorOfUpdate,"', now(), '", authorOfUpdate,"'
from ", opalDBName,".Patient
where PatientSerNum not in (select externalId from ", questionnaireDBName,".patient);"
   );


prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;


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


prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;


SET @wsSQL = CONCAT(
"UPDATE ", opalDBName, ".Questionnaire q, ", questionnaireDBName, ".answerQuestionnaire QAQ
SET q.PatientQuestionnaireDBSerNum = QAQ.ID
WHERE q.QuestionnaireSerNum = QAQ.deletedBy
AND QAQ.deleted = ", specialDeletedFlag, "
AND q.CompletedFlag = 0
;"
);


prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;


SET @wsSQL = CONCAT(
"UPDATE ", opalDBName, ".Questionnaire q, ", questionnaireDBName, ".answerQuestionnaire QAQ
SET QAQ.deleted = 0, QAQ.deletedBy = ''
WHERE QAQ.deleted = ", specialDeletedFlag, "
AND q.PatientQuestionnaireDBSerNum = QAQ.ID
;"
);


prepare stmt from @wsSQL;
Execute stmt;
deallocate prepare stmt;

END;

SET foreign_key_checks = 1;


-- 2023-05-23 16:57:52
