-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- CREATE PROCEDURE `updateAnswerQuestionnaireStatus`
(
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
        SET
          `status` = i_newStatus,
          -- Only set the questionnaire's completed date if its status is completed; otherwise, leave it as-is
          `completedDate` = IF(i_newStatus = 2, CURRENT_TIMESTAMP, `completedDate`),
          `respondentUsername` = i_respondentUsername,
          `lastUpdated` = CURRENT_TIMESTAMP,
          `updatedBy` = author_of_update,
          `respondentDisplayName` = i_respondentDisplayName
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
