-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Adminer 4.8.1 MySQL 5.5.5-10.6.13-MariaDB-1:10.6.13+maria~ubu2004 dump
-- Contains updates to the following procs:
-- getQuestionnaireInfo, getQuestionnaireList, saveAnswer,
-- updateAnswerQuestionnaireStatus

-- ADDs new procedure: getCompletedQuestionnairesList
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

DROP PROCEDURE IF EXISTS `getQuestionnaireInfo`;

CREATE PROCEDURE `getQuestionnaireInfo`(
	IN `i_answerQuestionnaireId` BIGINT,
	IN `i_isoLang` VARCHAR(2)
) DETERMINISTIC
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
			q.optionalFeedback as allow_questionnaire_feedback,
			q.purposeId as purpose_id
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

			-- get the list of answer_id for which to get their values
			select GROUP_CONCAT(answer_id) into answer_id_text from answer_summary2;

			-- this is to prevent when answer_id_text is NULL, -1 is not a possible value
			set answer_id_text = COALESCE(answer_id_text, "-1");

			-- get answer from the answer_ids
			-- left join is used because sometimes answer is there but the answer value is not (and that is a valid answer).
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

			-- execute SQL statement
			prepare stmt from @wsSQL;

			Execute stmt;
			deallocate prepare stmt;

		end if; -- end of getting answers

		set wsReturn = 0;

	END; -- end of get_questionnaire block

	select wsReturn as procedure_status, language_id as language_id;

END;

DROP PROCEDURE IF EXISTS `getQuestionnaireList`;

CREATE PROCEDURE `getQuestionnaireList`(
	IN `i_externalPatientId` VARCHAR(64),
	IN `i_purposeId` BIGINT,
	IN `i_isoLang` VARCHAR(2),
	IN `i_respondentIdList` TEXT
)

DETERMINISTIC
BEGIN

	-- this procedure gets the list of questionnaire belonging to a single patient.
	-- it requires an external patient ID i.e. from OpalDB, and a language in ISO format, i.e. 'EN', 'FR'. If the language is not valid, default to French.

	-- i_respondentIdList (string of IDs framed and separated by pipes; '|'): only questionnaires with respondentIds in this list are returned

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
			aq.respondentUsername AS respondent_username,
			aq.`status` AS status,
			aq.creationDate AS created,
			aq.lastUpdated AS last_updated,
			aq.respondentDisplayName AS respondent_display_name,
			getDisplayName(q.title, language_id) AS nickname,
			q.respondentId AS respondent_id
		FROM answerQuestionnaire aq LEFT JOIN questionnaire q ON q.ID = aq.questionnaireId
		WHERE aq.deleted = 0
			AND q.deleted = 0
			AND q.final = 1
			AND q.purposeId = i_purposeId
			AND aq.patientId =
				(SELECT ID
				FROM patient
				WHERE externalId = i_externalPatientId
				AND deleted = 0)
			AND INSTR(i_respondentIdList, CONCAT("|", q.respondentId, "|")) > 0 -- respondentId must be found in the list of choices
		;

		set wsReturn = 0;

	END; -- end of the get_questionnaire_list block

	select wsReturn as procedure_status;

END;


DROP PROCEDURE IF EXISTS `saveAnswer`;

CREATE PROCEDURE `saveAnswer`(
    IN `i_answerQuestionnaireId` BIGINT,
    IN `i_sectionId` BIGINT,
    IN `i_questionId` BIGINT,
    IN `i_questionTypeId` BIGINT,
    IN `i_isSkipped` TINYINT,
    IN `i_respondentUsername` VARCHAR(255),
    IN `i_appVersion` VARCHAR(255),
    IN `i_isoLang` VARCHAR(2)
)
DETERMINISTIC
BEGIN
    /*
        author of update should be patientId(in QuestionnaireDB) + '_APP_' + appVersion

        1. get patientId, questionnaireId and respondentUsername from answerQuestionnaire_id
        2. update status from new to in progress using answerQuestionnaire_id (if the questionnaire is not locked by another user) and set the lock to the current user
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
        error saving the answer because another user has locked the questionnaire = -8
    */

    -- declare variables
    declare countLang, countExistingAnswer, countAnswerQuestionnaire, countAnswerSection, affected_row_count, wsReturn int;
    declare language_id, questionnaire_id, patient_id, existing_answerSection_id, inserted_answer_id bigint;
    declare default_isoLang varchar(2);
    declare author_of_update, existing_lock_owner, wsReturnMessage varchar(255);
    declare existing_answerSection_id_concated, existing_answer_id_concated text;
    declare is_answered tinyint;

    -- declare variables for error messages
    declare success, langErr, answerQuestionnaireIdErr, statusUpdateErr, insertAnswerSectionErr, answerSectionDuplicateErr, rewriteAnswerErr, insertAnswerErr, lockErr int;
    declare success_message, langErr_message, answerQuestionnaireIdErr_message, statusUpdateErr_message, insertAnswerSectionErr_message, answerSectionDuplicateErr_message, rewriteAnswerErr_message, insertAnswerErr_message, lockErr_message varchar(255);

    -- set error variables and messages
    set success = 0;
    set langErr = -1;
    set answerQuestionnaireIdErr = -2;
    set statusUpdateErr = -3;
    set insertAnswerSectionErr = -4;
    set answerSectionDuplicateErr = -5;
    set rewriteAnswerErr = -6;
    set insertAnswerErr = -7;
    set lockErr = -8;

    set success_message = 'SUCCESS';
    set langErr_message = 'ERROR: cannot get a language id';
    set answerQuestionnaireIdErr_message = 'ERROR: no such incomplete questionnaire or more than one such questionnaire';
    set statusUpdateErr_message = 'ERROR: cannot update status of this questionnaire from new to in progress';
    set insertAnswerSectionErr_message = 'ERROR: failed to insert a new answerSection';
    set answerSectionDuplicateErr_message = 'ERROR: there is more than one row for an answerQuestionnaireId and a sectionId in the answerSection table, but could not mark the answers as deleted';
    set rewriteAnswerErr_message = 'ERROR: failed to mark existing answer as deleted';
    set insertAnswerErr_message = 'ERROR: failed to insert into answer table';
    set lockErr_message = 'ERROR: another user has already locked this questionnaire';

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

        -- 1. get patientId, questionnaireId and respondentUsername from answerQuestionnaire_id
        SELECT count(*), patientId, questionnaireId, respondentUsername into countAnswerQuestionnaire, patient_id, questionnaire_id, existing_lock_owner
        FROM answerQuestionnaire
        WHERE ID = i_answerQuestionnaireId AND deleted = 0 AND `status` <> 2
        group by patientId, questionnaireId;

        -- verify that the questionnaire is not already locked by another user
        -- This extra check is done only to provide a more detailed error message when possible. The actual robust lock ownership checking and claiming is done in the query below that sets `status` = '1'.
        if (existing_lock_owner <> '' AND existing_lock_owner <> i_respondentUsername) then
            set wsReturn = lockErr;
            set wsReturnMessage = lockErr_message;

            leave save_answer;
        end if;

        -- verify if there is only one patientId and questionnaireId for the given answerQuestionnaireId
        if countAnswerQuestionnaire <> 1 then
            set wsReturn = answerQuestionnaireIdErr;
            set wsReturnMessage = answerQuestionnaireIdErr_message;

            leave save_answer;
        end if;

        -- set author of update: author of update should be patientId(in QuestionnaireDB) + '_APP_' + appVersion
        select concat(patient_id, '_APP_', i_appVersion) into author_of_update;

        -- 2. update status from new to in progress using answerQuestionnaire_id
        -- Also check that the current user owns the questionnaire lock, or claim the lock if it's empty.
        -- Checking and claiming the lock is done in one query to make the operation atomic and prevent a race condition.
        UPDATE `answerQuestionnaire`
        SET `status` = '1', `respondentUsername` = i_respondentUsername, `lastUpdated` = CURRENT_TIMESTAMP, `updatedBy` = author_of_update
        WHERE `ID` = i_answerQuestionnaireId
          AND (
              -- Only succeed if the lock is owned by the current user or is not owned by anyone yet
              `respondentUsername` = i_respondentUsername
              OR `respondentUsername` = ''
          );

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
        -- note that the answerSectionId are concatenated due to maybe there is an error in inserts and there are more than one ID matching the conditions
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
                select ROW_COUNT() into affected_row_count;  -- this needs to follow execute to have the correct row count.

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
                select ROW_COUNT() into affected_row_count;  -- this must follow execute to have the correct behaviour

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

END;

DROP PROCEDURE IF EXISTS `updateAnswerQuestionnaireStatus`;

CREATE PROCEDURE `updateAnswerQuestionnaireStatus`(
    IN `i_answerQuestionnaireId` BIGINT,
    IN `i_newStatus` BIGINT,
    IN `i_respondentUsername` VARCHAR(255),
    IN `i_appVersion` VARCHAR(255)
)
DETERMINISTIC
BEGIN
    -- declare variables
    declare author_of_update, existing_lock_owner, wsReturnMessage varchar(255);
    declare countAnswerQuestionnaire, affected_row_count, wsReturn int;
    declare patient_id bigint;

    -- declare variables for error messages
    declare success, answerQuestionnaireIdErr, statusUpdateErr, lockErr int;
    declare success_message, answerQuestionnaireIdErr_message, statusUpdateErr_message, lockErr_message varchar(255);

    -- set error variables and messages
    set success = 0;
    set answerQuestionnaireIdErr = -1;
    set statusUpdateErr = -2;
    set lockErr = -8;

    set success_message = 'SUCCESS';
    set answerQuestionnaireIdErr_message = 'ERROR: no such questionnaire or more than one such questionnaire';
    set statusUpdateErr_message = 'ERROR: cannot update status of this questionnaire';
    set lockErr_message = 'ERROR: another user has already locked this questionnaire';

    updateStatus:BEGIN
        -- 1. get patientId and respondentUsername from answerQuestionnaire_id
        SELECT count(*), patientId, respondentUsername into countAnswerQuestionnaire, patient_id, existing_lock_owner
        FROM answerQuestionnaire
        WHERE ID = i_answerQuestionnaireId AND deleted = 0
        GROUP BY patientId;

        -- verify that the questionnaire is not already locked by another user
        -- This extra check is done only to provide a more detailed error message when possible. The actual robust lock ownership checking and claiming is done in the query below that sets `status` = i_newStatus.
        if (existing_lock_owner <> '' AND existing_lock_owner <> i_respondentUsername) then
            set wsReturn = lockErr;
            set wsReturnMessage = lockErr_message;

            leave updateStatus;
        end if;

        -- verify if there is only one patientId for the given answerQuestionnaireId
        if countAnswerQuestionnaire <> 1 then
            set wsReturn = answerQuestionnaireIdErr;
            set wsReturnMessage = answerQuestionnaireIdErr_message;

            leave updateStatus;
        end if;

        -- set author of update: author of update should be patientId(in QuestionnaireDB) + '_APP_' + appVersion
        select concat(patient_id, '_APP_', i_appVersion) into author_of_update;

        -- 2. update status using answerQuestionnaire_id
        -- Also check that the current user owns the questionnaire lock, or claim the lock if it's empty.
        -- Checking and claiming the lock is done in one query to make the operation atomic and prevent a race condition.
        UPDATE `answerQuestionnaire`
        SET `status` = i_newStatus, `respondentUsername` = i_respondentUsername, `lastUpdated` = CURRENT_TIMESTAMP, `updatedBy` = author_of_update
        WHERE `ID` = i_answerQuestionnaireId
          AND (
              -- Only succeed if the lock is owned by the current user or is not owned by anyone yet
              `respondentUsername` = i_respondentUsername
              OR `respondentUsername` = ''
          );

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

END;

DROP PROCEDURE IF EXISTS `getCompletedQuestionnairesList`;

-- Dumping structure for procedure questionnairedb.getCompletedQuestionnairesList
CREATE PROCEDURE `getCompletedQuestionnairesList`(
    IN `i_externalPatientId`        VARCHAR(64),
    IN `i_questionnairePurposeId`   BIGINT(20),
    IN `i_isoLang`                  VARCHAR(2)
)
BEGIN

    -- this procedure is intended to get the questionnaire, section, questions and answers from an externalPatientId.
    -- the language is passed in iso form, i.e. 'EN', 'FR'. If the language is not valid, default to French

    -- declare variables
    DECLARE patient_id BIGINT;
    DECLARE wsCountLang, wsCountQuestionnaires, wsReturn, questionnaire_status INT;
    DECLARE language_id BIGINT;
    DECLARE default_isoLang VARCHAR(2);
    DECLARE answer_id_text TEXT;

    -- set default language to French
    SET default_isoLang = 'FR';

    -- note: wsReturn convention for this procedure: success = 0, language error = -1, error in answerQuestionnaireId = -2, purpose error = -3

    -- get internal patient id
    SELECT
        p.ID
    INTO patient_id
    FROM patient p
    WHERE p.externalId = i_externalPatientId;

    -- get language
    SELECT
        count(*),
        ID
    INTO wsCountLang, language_id
    FROM language
    WHERE isoLang = i_isoLang AND deleted = 0;

    -- label is a way to do early exit
    get_questionnaire: BEGIN

        -- verify language is correct
        IF wsCountLang <> 1
        THEN

            -- try to get language again using default language
            SELECT
                count(*),
                ID
            INTO wsCountLang, language_id
            FROM language
            WHERE isoLang = default_isoLang AND deleted = 0;

            -- verify again that language is correct
            IF wsCountLang <> 1
            THEN
                SET wsReturn = -1;
                LEAVE get_questionnaire;
            END IF;

        END IF;

        -- Get the information about questionnaires by a patient id
        -- temporary table is created to store questionnaire_id(s) for fetching sections, questions and answers
        DROP TABLE IF EXISTS questionnaires_info;
        CREATE TEMPORARY TABLE IF NOT EXISTS questionnaires_info AS
            (
                SELECT
                    q.ID                                                                            AS questionnaire_id,
                    aq.ID                                                                           AS ans_questionnaire_id,
                    aq.`status`                                                                     AS status,
                    IF(q.nickname <> -1, getDisplayName(q.nickname, language_id), getDisplayName(q.title, language_id)) AS nickname,
                    q.logo                                                                          AS logo,
                    getDisplayName(q.description,
                                   2)                                                               AS description,
                    getDisplayName(q.instruction,
                                   2)                                                               AS instruction,
                    q.optionalFeedback                                                              AS allow_questionnaire_feedback,
                    q.purposeId                                                                     AS purposeId
                FROM answerQuestionnaire aq
                         LEFT JOIN questionnaire q ON (aq.questionnaireId = q.ID)
                WHERE aq.patientId = patient_id
                  AND aq.status = 2
                  AND aq.deleted = 0
                  AND q.deleted = 0
                  AND q.final = 1
            );

        -- verify that purpose ID is in the range between 0 and 6
        IF i_questionnairePurposeId < 0 OR i_questionnairePurposeId > 6
        THEN
            SET wsReturn = -3;
            LEAVE get_questionnaire;
        END IF;

        -- filter questionnaires by questionnaire purpose
        -- otherwise all the questionnaires will be returned
        IF i_questionnairePurposeId <> 0
        THEN
            DELETE FROM questionnaires_info
            WHERE purposeId <> i_questionnairePurposeId;
        END IF;

#       -- get the questionnaires
        SELECT
            count(*),
            aq.`status`
        INTO wsCountQuestionnaires, questionnaire_status
        FROM answerQuestionnaire aq
        WHERE aq.patientId = patient_id
          AND aq.status = 2
          AND aq.deleted = 0;

        -- verify that the questionnaires are being returned
        IF wsCountQuestionnaires = 0
        THEN
            SET wsReturn = -2;
            LEAVE get_questionnaire;
        END IF;

        -- Get the information about sections in questionnaires
        -- temporary table is created to store section_id(s) for the next step
        DROP TABLE IF EXISTS sections_info;
        CREATE TEMPORARY TABLE IF NOT EXISTS sections_info AS
            (
                SELECT
                    sec.questionnaireId                                             AS questionnaire_id,
                    sec.ID                                                          AS section_id,
                    if(sec.title <> -1, getDisplayName(sec.title, language_id), '') AS section_title,
                    getDisplayName(sec.instruction, language_id)                    AS section_instruction,
                    sec.`order`                                                     AS section_position
                FROM section sec
                WHERE sec.questionnaireId IN (SELECT qi.questionnaire_id FROM questionnaires_info qi)
                  AND sec.deleted = 0
            );

        -- get questions for those sections
        CREATE TEMPORARY TABLE IF NOT EXISTS questions_info AS (
            SELECT
            sec.questionnaireId                     AS questionnaire_id,
            qSec.sectionId                          AS section_id,
            q.ID                                    AS question_id,
            qSec.ID                                 AS questionSection_id,
            qSec.order                              AS question_position,
            qSec.orientation                        AS orientation,
            qSec.optional                           AS optional,
            getDisplayName(q.question, language_id) AS question_text,
            getDisplayName(q.display, language_id)  AS question_label,
            q.typeId                                AS type_id,
            q.polarity                              AS polarity,
            q.optionalFeedback                      AS allow_question_feedback,
            sl.minValue                             AS min_value,
            sl.maxValue                             AS max_value
        FROM questionSection qSec
                 LEFT JOIN question q ON (q.ID = qSec.questionId)
                 LEFT JOIN section sec ON (sec.ID = qSec.sectionID)
                 LEFT JOIN slider sl ON (sl.questionId = q.ID)
        WHERE qSec.sectionId IN (SELECT section_id
                                 FROM sections_info)
          AND q.deleted = 0
          AND q.final = 1
        );

        IF questionnaire_status = 0
        THEN
            -- the line below is not really needed, however, since without it the number of query returned will not be the same for new and other status questionnaire, this is added to prevent error when calling this procedure.
            SELECT questionnaire_status AS status;

        ELSE

            -- if the questionnaire is not new, then get its answer

            -- get answers_id for this questionnaire
            DROP TABLE IF EXISTS answer_summary;
            CREATE TEMPORARY TABLE IF NOT EXISTS answer_summary AS (
                SELECT
                    aSec.answerQuestionnaireId AS answer_questionnaire_id,
                    a.questionnaireId          AS questionnaire_id,
                    aSec.sectionId             AS section_id,
                    a.ID                       AS answer_id,
                    a.questionId               AS question_id,
                    a.typeId                   AS type_id,
                    a.answered                 AS answered,
                    a.skipped                  AS skipped,
                    a.creationDate             AS created,
                    a.lastUpdated              AS last_updated,
                    a.languageId               AS answer_language_id,
                    qSec.ID                    AS questionSection_id
                FROM (answerSection aSec
                         LEFT JOIN answer a ON (a.answerSectionId = aSec.ID)),
                     questionSection qSec
                WHERE a.patientId = patient_id
                  AND a.deleted = 0
                  AND qSec.questionId = a.questionId
                  AND qSec.sectionId = a.sectionId
            );

            -- GROUP_CONCAT() is used to convert multiple rows (ids) into a single string.
            -- By default, the maximum length of the result of this function is 1024 characters.
            -- To check the character length that GROUP_CONCAT supports in the mysql instance:
            -- SHOW VARIABLES LIKE '%group_concat%';

            -- makes a temporary session-scope setting for the group_concat
            SET SESSION group_concat_max_len = 1000000;

            -- get the list of answer_id for which to get their values
            SELECT GROUP_CONCAT(answer_id)
            INTO answer_id_text
            FROM answer_summary;

            -- this is to prevent when answer_id_text is NULL, -1 is not a possible value
            SET answer_id_text = COALESCE(answer_id_text, "-1");

            -- get answer from the answer_ids
            SET @wsSQL = concat(
                    "CREATE TEMPORARY TABLE IF NOT EXISTS answers_info AS (select answer_summary.*,
                      a.answer_value,
                      a.answer_option_text,
                      a.intensity,
                      a.posX,
                      a.posY,
                      a.selected
                    from answer_summary left join (
                      select rb.answerId as answer_id,
                        CONVERT(rb.value, CHAR(516)) as answer_value,
                        getDisplayName((select rbOpt.description from radioButtonOption rbOpt where rbOpt.ID = rb.value),",
                    language_id, ") as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerRadioButton rb
					where rb.answerId in (", answer_id_text, ")
					UNION
					select c.answerId as answer_id,
						CONVERT(c.value, CHAR(516)) as answer_value,
						getDisplayName((select cOpt.description from checkboxOption cOpt where cOpt.ID = c.value), ", language_id, ") as answer_option_text,
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
				);"
                );

            -- execute SQL statement
            PREPARE stmt FROM @wsSQL;

            EXECUTE stmt;

            DEALLOCATE PREPARE stmt;

        END IF; -- end of getting answers

        SET wsReturn = 0;

    END; -- end of get_questionnaire block


    -- get completed questionnaires and their answers in JSON format
    DROP TABLE IF EXISTS completed_questionnaires;
    CREATE TEMPORARY TABLE IF NOT EXISTS completed_questionnaires AS (
        SELECT
            JSON_OBJECT(
                'questionnaire_id', ai.questionnaire_id,
                'questionnaire_nickname', qi.nickname,
                'last_updated', MAX(ai.last_updated),
                'questions', (
                    SELECT JSON_ARRAYAGG(
                        JSON_OBJECT(
                            'question_text', quest.question_text,
                            'question_label', quest.question_label,
                            'question_type_id', quest.type_id,
                            'position', quest.question_position,
                            'min_value', quest.min_value,
                            'max_value', quest.max_value,
                            'polarity', quest.polarity,
                            'section_id', quest.section_id,
                            'values', (
                                SELECT JSON_ARRAYAGG(JSON_ARRAY(UNIX_TIMESTAMP(_ai.last_updated) * 1000, _ai.answer_value))
                                FROM answers_info _ai
                                WHERE _ai.question_id = quest.question_id
                            )
                    )
                    ) FROM questions_info quest
                    WHERE quest.questionnaire_id = qi.questionnaire_id
                )
            ) AS json_answer
        FROM questionnaires_info qi
            LEFT JOIN answers_info ai ON (qi.questionnaire_id = ai.questionnaire_id)
        GROUP BY qi.questionnaire_id
    );

    SELECT cq.json_answer AS json_answer
    FROM completed_questionnaires cq;

    SELECT
        wsReturn    AS procedure_status,
        language_id AS language_id;

END;

DROP PROCEDURE IF EXISTS `updateAnswerQuestionnaireStatus`;

CREATE PROCEDURE `updateAnswerQuestionnaireStatus`(
    IN `i_answerQuestionnaireId` BIGINT,
    IN `i_newStatus` BIGINT,
    IN `i_respondentUsername` VARCHAR(255),
    IN `i_appVersion` VARCHAR(255),
    IN `i_respondentDisplayName` VARCHAR(255)
)
DETERMINISTIC
BEGIN
    -- declare variables
    declare author_of_update, existing_lock_owner, wsReturnMessage varchar(255);
    declare countAnswerQuestionnaire, affected_row_count, wsReturn int;
    declare patient_id bigint;

    -- declare variables for error messages
    declare success, answerQuestionnaireIdErr, statusUpdateErr, lockErr int;
    declare success_message, answerQuestionnaireIdErr_message, statusUpdateErr_message, lockErr_message varchar(255);

    -- set error variables and messages
    set success = 0;
    set answerQuestionnaireIdErr = -1;
    set statusUpdateErr = -2;
    set lockErr = -8;

    set success_message = 'SUCCESS';
    set answerQuestionnaireIdErr_message = 'ERROR: no such questionnaire or more than one such questionnaire';
    set statusUpdateErr_message = 'ERROR: cannot update status of this questionnaire';
    set lockErr_message = 'ERROR: another user has already locked this questionnaire';

    updateStatus:BEGIN
        -- 1. get patientId and respondentUsername from answerQuestionnaire_id
        SELECT count(*), patientId, respondentUsername into countAnswerQuestionnaire, patient_id, existing_lock_owner
        FROM answerQuestionnaire
        WHERE ID = i_answerQuestionnaireId AND deleted = 0
        GROUP BY patientId;

        -- verify that the questionnaire is not already locked by another user
        -- This extra check is done only to provide a more detailed error message when possible. The actual robust lock ownership checking and claiming is done in the query below that sets `status` = i_newStatus.
        if (existing_lock_owner <> '' AND existing_lock_owner <> i_respondentUsername) then
            set wsReturn = lockErr;
            set wsReturnMessage = lockErr_message;

            leave updateStatus;
        end if;

        -- verify if there is only one patientId for the given answerQuestionnaireId
        if countAnswerQuestionnaire <> 1 then
            set wsReturn = answerQuestionnaireIdErr;
            set wsReturnMessage = answerQuestionnaireIdErr_message;

            leave updateStatus;
        end if;

        -- set author of update: author of update should be patientId(in QuestionnaireDB) + '_APP_' + appVersion
        select concat(patient_id, '_APP_', i_appVersion) into author_of_update;

        -- 2. update status using answerQuestionnaire_id
        -- Also check that the current user owns the questionnaire lock, or claim the lock if it's empty.
        -- Checking and claiming the lock is done in one query to make the operation atomic and prevent a race condition.
        UPDATE `answerQuestionnaire`
        SET `status` = i_newStatus, `respondentUsername` = i_respondentUsername, `lastUpdated` = CURRENT_TIMESTAMP, `updatedBy` = author_of_update, `respondentDisplayName` = i_respondentDisplayName
        WHERE `ID` = i_answerQuestionnaireId
          AND (
              -- Only succeed if the lock is owned by the current user or is not owned by anyone yet
              `respondentUsername` = i_respondentUsername
              OR `respondentUsername` = ''
          );

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

END;

DROP PROCEDURE IF EXISTS `getCompletedQuestionnairesList`;

-- Dumping structure for procedure questionnairedb.getCompletedQuestionnairesList
CREATE PROCEDURE `getCompletedQuestionnairesList`(
    IN `i_externalPatientId`        VARCHAR(64),
    IN `i_questionnairePurposeId`   BIGINT(20),
    IN `i_isoLang`                  VARCHAR(2)
)
BEGIN

    -- this procedure is intended to get the questionnaire, section, questions and answers from an externalPatientId.
    -- the language is passed in iso form, i.e. 'EN', 'FR'. If the language is not valid, default to French

    -- declare variables
    DECLARE patient_id BIGINT;
    DECLARE wsCountLang, wsCountQuestionnaires, wsReturn, questionnaire_status INT;
    DECLARE language_id BIGINT;
    DECLARE default_isoLang VARCHAR(2);
    DECLARE answer_id_text TEXT;

    -- set default language to French
    SET default_isoLang = 'FR';

    -- note: wsReturn convention for this procedure: success = 0, language error = -1, error in answerQuestionnaireId = -2, purpose error = -3

    -- get internal patient id
    SELECT
        p.ID
    INTO patient_id
    FROM patient p
    WHERE p.externalId = i_externalPatientId;

    -- get language
    SELECT
        count(*),
        ID
    INTO wsCountLang, language_id
    FROM language
    WHERE isoLang = i_isoLang AND deleted = 0;

    -- label is a way to do early exit
    get_questionnaire: BEGIN

        -- verify language is correct
        IF wsCountLang <> 1
        THEN

            -- try to get language again using default language
            SELECT
                count(*),
                ID
            INTO wsCountLang, language_id
            FROM language
            WHERE isoLang = default_isoLang AND deleted = 0;

            -- verify again that language is correct
            IF wsCountLang <> 1
            THEN
                SET wsReturn = -1;
                LEAVE get_questionnaire;
            END IF;

        END IF;

        -- Get the information about questionnaires by a patient id
        -- temporary table is created to store questionnaire_id(s) for fetching sections, questions and answers
        DROP TABLE IF EXISTS questionnaires_info;
        CREATE TEMPORARY TABLE IF NOT EXISTS questionnaires_info AS
            (
                SELECT
                    q.ID                                                                            AS questionnaire_id,
                    aq.ID                                                                           AS ans_questionnaire_id,
                    aq.`status`                                                                     AS status,
                    getDisplayName(q.title, language_id)                                            AS nickname,
                    q.logo                                                                          AS logo,
                    getDisplayName(q.description,
                                   2)                                                               AS description,
                    getDisplayName(q.instruction,
                                   2)                                                               AS instruction,
                    q.optionalFeedback                                                              AS allow_questionnaire_feedback,
                    q.purposeId                                                                     AS purposeId
                FROM answerQuestionnaire aq
                         LEFT JOIN questionnaire q ON (aq.questionnaireId = q.ID)
                WHERE aq.patientId = patient_id
                  AND aq.status = 2
                  AND aq.deleted = 0
                  AND q.deleted = 0
                  AND q.final = 1
            );

        -- verify that purpose ID is in the range between 0 and 6
        IF i_questionnairePurposeId < 0 OR i_questionnairePurposeId > 6
        THEN
            SET wsReturn = -3;
            LEAVE get_questionnaire;
        END IF;

        -- filter questionnaires by questionnaire purpose
        -- otherwise all the questionnaires will be returned
        IF i_questionnairePurposeId <> 0
        THEN
            DELETE FROM questionnaires_info
            WHERE purposeId <> i_questionnairePurposeId;
        END IF;

#       -- get the questionnaires
        SELECT
            count(*),
            aq.`status`
        INTO wsCountQuestionnaires, questionnaire_status
        FROM answerQuestionnaire aq
        WHERE aq.patientId = patient_id
          AND aq.status = 2
          AND aq.deleted = 0;

        -- verify that the questionnaires are being returned
        IF wsCountQuestionnaires = 0
        THEN
            SET wsReturn = -2;
            LEAVE get_questionnaire;
        END IF;

        -- Get the information about sections in questionnaires
        -- temporary table is created to store section_id(s) for the next step
        DROP TABLE IF EXISTS sections_info;
        CREATE TEMPORARY TABLE IF NOT EXISTS sections_info AS
            (
                SELECT
                    sec.questionnaireId                                             AS questionnaire_id,
                    sec.ID                                                          AS section_id,
                    if(sec.title <> -1, getDisplayName(sec.title, language_id), '') AS section_title,
                    getDisplayName(sec.instruction, language_id)                    AS section_instruction,
                    sec.`order`                                                     AS section_position
                FROM section sec
                WHERE sec.questionnaireId IN (SELECT qi.questionnaire_id FROM questionnaires_info qi)
                  AND sec.deleted = 0
            );

        -- get questions for those sections
        CREATE TEMPORARY TABLE IF NOT EXISTS questions_info AS (
            SELECT
            sec.questionnaireId                     AS questionnaire_id,
            qSec.sectionId                          AS section_id,
            q.ID                                    AS question_id,
            qSec.ID                                 AS questionSection_id,
            qSec.order                              AS question_position,
            qSec.orientation                        AS orientation,
            qSec.optional                           AS optional,
            getDisplayName(q.question, language_id) AS question_text,
            getDisplayName(q.display, language_id)  AS question_label,
            q.typeId                                AS type_id,
            q.polarity                              AS polarity,
            q.optionalFeedback                      AS allow_question_feedback,
            sl.minValue                             AS min_value,
            sl.maxValue                             AS max_value
        FROM questionSection qSec
                 LEFT JOIN question q ON (q.ID = qSec.questionId)
                 LEFT JOIN section sec ON (sec.ID = qSec.sectionID)
                 LEFT JOIN slider sl ON (sl.questionId = q.ID)
        WHERE qSec.sectionId IN (SELECT section_id
                                 FROM sections_info)
          AND q.deleted = 0
          AND q.final = 1
        );

        IF questionnaire_status = 0
        THEN
            -- the line below is not really needed, however, since without it the number of query returned will not be the same for new and other status questionnaire, this is added to prevent error when calling this procedure.
            SELECT questionnaire_status AS status;

        ELSE

            -- if the questionnaire is not new, then get its answer

            -- get answers_id for this questionnaire
            DROP TABLE IF EXISTS answer_summary;
            CREATE TEMPORARY TABLE IF NOT EXISTS answer_summary AS (
                SELECT
                    aSec.answerQuestionnaireId AS answer_questionnaire_id,
                    a.questionnaireId          AS questionnaire_id,
                    aSec.sectionId             AS section_id,
                    a.ID                       AS answer_id,
                    a.questionId               AS question_id,
                    a.typeId                   AS type_id,
                    a.answered                 AS answered,
                    a.skipped                  AS skipped,
                    a.creationDate             AS created,
                    a.lastUpdated              AS last_updated,
                    a.languageId               AS answer_language_id,
                    qSec.ID                    AS questionSection_id
                FROM (answerSection aSec
                         LEFT JOIN answer a ON (a.answerSectionId = aSec.ID)),
                     questionSection qSec
                WHERE a.patientId = patient_id
                  AND a.deleted = 0
                  AND qSec.questionId = a.questionId
                  AND qSec.sectionId = a.sectionId
            );

            -- GROUP_CONCAT() is used to convert multiple rows (ids) into a single string.
            -- By default, the maximum length of the result of this function is 1024 characters.
            -- To check the character length that GROUP_CONCAT supports in the mysql instance:
            -- SHOW VARIABLES LIKE '%group_concat%';

            -- makes a temporary session-scope setting for the group_concat
            SET SESSION group_concat_max_len = 1000000;

            -- get the list of answer_id for which to get their values
            SELECT GROUP_CONCAT(answer_id)
            INTO answer_id_text
            FROM answer_summary;

            -- this is to prevent when answer_id_text is NULL, -1 is not a possible value
            SET answer_id_text = COALESCE(answer_id_text, "-1");

            -- get answer from the answer_ids
            SET @wsSQL = concat(
                    "CREATE TEMPORARY TABLE IF NOT EXISTS answers_info AS (select answer_summary.*,
                      a.answer_value,
                      a.answer_option_text,
                      a.intensity,
                      a.posX,
                      a.posY,
                      a.selected
                    from answer_summary left join (
                      select rb.answerId as answer_id,
                        CONVERT(rb.value, CHAR(516)) as answer_value,
                        getDisplayName((select rbOpt.description from radioButtonOption rbOpt where rbOpt.ID = rb.value),",
                    language_id, ") as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerRadioButton rb
					where rb.answerId in (", answer_id_text, ")
					UNION
					select c.answerId as answer_id,
						CONVERT(c.value, CHAR(516)) as answer_value,
						getDisplayName((select cOpt.description from checkboxOption cOpt where cOpt.ID = c.value), ", language_id, ") as answer_option_text,
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
				);"
                );

            -- execute SQL statement
            PREPARE stmt FROM @wsSQL;

            EXECUTE stmt;

            DEALLOCATE PREPARE stmt;

        END IF; -- end of getting answers

        SET wsReturn = 0;

    END; -- end of get_questionnaire block


    -- get completed questionnaires and their answers in JSON format
    DROP TABLE IF EXISTS completed_questionnaires;
    CREATE TEMPORARY TABLE IF NOT EXISTS completed_questionnaires AS (
        SELECT
            JSON_OBJECT(
                'questionnaire_id', ai.questionnaire_id,
                'questionnaire_nickname', qi.nickname,
                'last_updated', MAX(ai.last_updated),
                'questions', (
                    SELECT JSON_ARRAYAGG(
                        JSON_OBJECT(
                            'question_text', quest.question_text,
                            'question_label', quest.question_label,
                            'question_type_id', quest.type_id,
                            'position', quest.question_position,
                            'min_value', quest.min_value,
                            'max_value', quest.max_value,
                            'polarity', quest.polarity,
                            'section_id', quest.section_id,
                            'values', (
                                SELECT JSON_ARRAYAGG(JSON_ARRAY(UNIX_TIMESTAMP(_ai.last_updated) * 1000, _ai.answer_value))
                                FROM answers_info _ai
                                WHERE _ai.question_id = quest.question_id
                            )
                    )
                    ) FROM questions_info quest
                    WHERE quest.questionnaire_id = qi.questionnaire_id
                )
            ) AS json_answer
        FROM questionnaires_info qi
            LEFT JOIN answers_info ai ON (qi.questionnaire_id = ai.questionnaire_id)
        GROUP BY qi.questionnaire_id
    );

    SELECT cq.json_answer AS json_answer
    FROM completed_questionnaires cq;

    SELECT
        wsReturn    AS procedure_status,
        language_id AS language_id;

END;

-- Support checkbox and radio button return values, change type of last_updated from UNIX timestamp to string
DROP PROCEDURE IF EXISTS `getCompletedQuestionnairesList`;
CREATE PROCEDURE `getCompletedQuestionnairesList`(
    IN `i_externalPatientId`        VARCHAR(64),
    IN `i_questionnairePurposeId`   BIGINT(20),
    IN `i_isoLang`                  VARCHAR(2)
)
BEGIN

    -- this procedure is intended to get the questionnaire, section, questions and answers from an externalPatientId.
    -- the language is passed in iso form, i.e. 'EN', 'FR'. If the language is not valid, default to French

    -- declare variables
    DECLARE patient_id BIGINT;
    DECLARE wsCountLang, wsCountQuestionnaires, wsReturn, questionnaire_status INT;
    DECLARE language_id BIGINT;
    DECLARE default_isoLang VARCHAR(2);
    DECLARE answer_id_text TEXT;

    -- set default language to French
    SET default_isoLang = 'FR';

    -- note: wsReturn convention for this procedure: success = 0, language error = -1, error in answerQuestionnaireId = -2, purpose error = -3

    -- get internal patient id
    SELECT
        p.ID
    INTO patient_id
    FROM patient p
    WHERE p.externalId = i_externalPatientId;

    -- get language
    SELECT
        count(*),
        ID
    INTO wsCountLang, language_id
    FROM language
    WHERE isoLang = i_isoLang AND deleted = 0;

    -- label is a way to do early exit
    get_questionnaire: BEGIN

        -- verify language is correct
        IF wsCountLang <> 1
        THEN

            -- try to get language again using default language
            SELECT
                count(*),
                ID
            INTO wsCountLang, language_id
            FROM language
            WHERE isoLang = default_isoLang AND deleted = 0;

            -- verify again that language is correct
            IF wsCountLang <> 1
            THEN
                SET wsReturn = -1;
                LEAVE get_questionnaire;
            END IF;

        END IF;

        -- Get the information about questionnaires by a patient id
        -- temporary table is created to store questionnaire_id(s) for fetching sections, questions and answers
        DROP TABLE IF EXISTS questionnaires_info;
        CREATE TEMPORARY TABLE IF NOT EXISTS questionnaires_info AS
            (
                SELECT
                    q.ID                                                                            AS questionnaire_id,
                    aq.ID                                                                           AS ans_questionnaire_id,
                    aq.`status`                                                                     AS status,
                    getDisplayName(q.title, language_id)                                            AS nickname,
                    q.logo                                                                          AS logo,
                    getDisplayName(q.description,
                                   2)                                                               AS description,
                    getDisplayName(q.instruction,
                                   2)                                                               AS instruction,
                    q.optionalFeedback                                                              AS allow_questionnaire_feedback,
                    q.purposeId                                                                     AS purposeId
                FROM answerQuestionnaire aq
                         LEFT JOIN questionnaire q ON (aq.questionnaireId = q.ID)
                WHERE aq.patientId = patient_id
                  AND aq.status = 2
                  AND aq.deleted = 0
                  AND q.deleted = 0
                  AND q.final = 1
            );

        -- verify that purpose ID is in the range between 0 and 6
        IF i_questionnairePurposeId < 0 OR i_questionnairePurposeId > 6
        THEN
            SET wsReturn = -3;
            LEAVE get_questionnaire;
        END IF;

        -- filter questionnaires by questionnaire purpose
        -- otherwise all the questionnaires will be returned
        IF i_questionnairePurposeId <> 0
        THEN
            DELETE FROM questionnaires_info
            WHERE purposeId <> i_questionnairePurposeId;
        END IF;

#       -- get the questionnaires
        SELECT
            count(*),
            aq.`status`
        INTO wsCountQuestionnaires, questionnaire_status
        FROM answerQuestionnaire aq
        WHERE aq.patientId = patient_id
          AND aq.status = 2
          AND aq.deleted = 0;

        -- verify that the questionnaires are being returned
        IF wsCountQuestionnaires = 0
        THEN
            SET wsReturn = -2;
            LEAVE get_questionnaire;
        END IF;

        -- Get the information about sections in questionnaires
        -- temporary table is created to store section_id(s) for the next step
        DROP TABLE IF EXISTS sections_info;
        CREATE TEMPORARY TABLE IF NOT EXISTS sections_info AS
            (
                SELECT
                    sec.questionnaireId                                             AS questionnaire_id,
                    sec.ID                                                          AS section_id,
                    if(sec.title <> -1, getDisplayName(sec.title, language_id), '') AS section_title,
                    getDisplayName(sec.instruction, language_id)                    AS section_instruction,
                    sec.`order`                                                     AS section_position
                FROM section sec
                WHERE sec.questionnaireId IN (SELECT qi.questionnaire_id FROM questionnaires_info qi)
                  AND sec.deleted = 0
            );

        -- get questions for those sections
        CREATE TEMPORARY TABLE IF NOT EXISTS questions_info AS (
            SELECT
            sec.questionnaireId                     AS questionnaire_id,
            qSec.sectionId                          AS section_id,
            q.ID                                    AS question_id,
            qSec.ID                                 AS questionSection_id,
            qSec.order                              AS question_position,
            qSec.orientation                        AS orientation,
            qSec.optional                           AS optional,
            getDisplayName(q.question, language_id) AS question_text,
            getDisplayName(q.display, language_id)  AS question_label,
            q.typeId                                AS type_id,
            q.polarity                              AS polarity,
            q.optionalFeedback                      AS allow_question_feedback,
            sl.minValue                             AS min_value,
            sl.maxValue                             AS max_value
        FROM questionSection qSec
                 LEFT JOIN question q ON (q.ID = qSec.questionId)
                 LEFT JOIN section sec ON (sec.ID = qSec.sectionID)
                 LEFT JOIN slider sl ON (sl.questionId = q.ID)
        WHERE qSec.sectionId IN (SELECT section_id
                                 FROM sections_info)
          AND q.deleted = 0
          AND q.final = 1
        );

        IF questionnaire_status = 0
        THEN
            -- the line below is not really needed, however, since without it the number of query returned will not be the same for new and other status questionnaire, this is added to prevent error when calling this procedure.
            SELECT questionnaire_status AS status;

        ELSE

            -- if the questionnaire is not new, then get its answer

            -- get answers_id for this questionnaire
            DROP TABLE IF EXISTS answer_summary;
            CREATE TEMPORARY TABLE IF NOT EXISTS answer_summary AS (
                SELECT
                    aSec.answerQuestionnaireId AS answer_questionnaire_id,
                    a.questionnaireId          AS questionnaire_id,
                    aSec.sectionId             AS section_id,
                    a.ID                       AS answer_id,
                    a.questionId               AS question_id,
                    a.typeId                   AS type_id,
                    a.answered                 AS answered,
                    a.skipped                  AS skipped,
                    a.creationDate             AS created,
                    a.lastUpdated              AS last_updated,
                    a.languageId               AS answer_language_id,
                    qSec.ID                    AS questionSection_id
                FROM (answerSection aSec
                         LEFT JOIN answer a ON (a.answerSectionId = aSec.ID)),
                     questionSection qSec
                WHERE a.patientId = patient_id
                  AND a.deleted = 0
                  AND qSec.questionId = a.questionId
                  AND qSec.sectionId = a.sectionId
            );

            -- GROUP_CONCAT() is used to convert multiple rows (ids) into a single string.
            -- By default, the maximum length of the result of this function is 1024 characters.
            -- To check the character length that GROUP_CONCAT supports in the mysql instance:
            -- SHOW VARIABLES LIKE '%group_concat%';

            -- makes a temporary session-scope setting for the group_concat
            SET SESSION group_concat_max_len = 1000000;

            -- get the list of answer_id for which to get their values
            SELECT GROUP_CONCAT(answer_id)
            INTO answer_id_text
            FROM answer_summary;

            -- this is to prevent when answer_id_text is NULL, -1 is not a possible value
            SET answer_id_text = COALESCE(answer_id_text, "-1");

            -- get answer from the answer_ids
            SET @wsSQL = concat(
                    "CREATE TEMPORARY TABLE IF NOT EXISTS answers_info AS (select answer_summary.*,
                      a.answer_value,
                      a.answer_option_text,
                      a.intensity,
                      a.posX,
                      a.posY,
                      a.selected
                    from answer_summary left join (
                      select rb.answerId as answer_id,
                        CONVERT(rb.value, CHAR(516)) as answer_value,
                        getDisplayName((select rbOpt.description from radioButtonOption rbOpt where rbOpt.ID = rb.value),",
                    language_id, ") as answer_option_text,
						-1 as intensity,
						-1 as posX,
						-1 as posY,
						-1 as selected
					from answerRadioButton rb
					where rb.answerId in (", answer_id_text, ")
					UNION
					select c.answerId as answer_id,
						CONVERT(c.value, CHAR(516)) as answer_value,
						getDisplayName((select cOpt.description from checkboxOption cOpt where cOpt.ID = c.value), ", language_id, ") as answer_option_text,
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
				);"
                );

            -- execute SQL statement
            PREPARE stmt FROM @wsSQL;

            EXECUTE stmt;

            DEALLOCATE PREPARE stmt;

        END IF; -- end of getting answers

        SET wsReturn = 0;

    END; -- end of get_questionnaire block


    -- get completed questionnaires and their answers in JSON format
    DROP TABLE IF EXISTS completed_questionnaires;
    CREATE TEMPORARY TABLE IF NOT EXISTS completed_questionnaires AS (
        SELECT
            JSON_OBJECT(
                'questionnaire_id', ai.questionnaire_id,
                'questionnaire_nickname', qi.nickname,
                'last_updated', MAX(ai.last_updated),
                'questions', (
                    SELECT JSON_ARRAYAGG(
                        JSON_OBJECT(
                            'question_text', quest.question_text,
                            'question_label', quest.question_label,
                            'question_type_id', quest.type_id,
                            'position', quest.question_position,
                            'min_value', quest.min_value,
                            'max_value', quest.max_value,
                            'polarity', quest.polarity,
                            'section_id', quest.section_id,
                            'values', (
                                SELECT JSON_ARRAYAGG(
                                    JSON_ARRAY(
                                        _ai.last_updated,
                                        CASE
                                            WHEN quest.type_id = 1 THEN _ai.answer_option_text
					                        WHEN quest.type_id = 4 THEN _ai.answer_option_text
               				                ELSE _ai.answer_value
                                        END
                                    )
                                )
                                FROM answers_info _ai
                                WHERE _ai.question_id = quest.question_id
                            )
                    )
                    ) FROM questions_info quest
                    WHERE quest.questionnaire_id = qi.questionnaire_id
                )
            ) AS json_answer
        FROM questionnaires_info qi
            LEFT JOIN answers_info ai ON (qi.questionnaire_id = ai.questionnaire_id)
        GROUP BY qi.questionnaire_id
    );

    SELECT cq.json_answer AS json_answer
    FROM completed_questionnaires cq;

    SELECT
        wsReturn    AS procedure_status,
        language_id AS language_id;

END;


SET foreign_key_checks = 1;
-- 2023-05-23 16:57:52
