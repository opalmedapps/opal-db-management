-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- CREATE PROCEDURE `getQuestionnaireList`
(
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
            aq.completedDate AS completed_date,
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
