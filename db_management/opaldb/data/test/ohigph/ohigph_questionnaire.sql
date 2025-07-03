-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `Questionnaire` (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `DateAdded`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `SessionId`, `LastUpdated`) VALUES
-- all get: esas-r
(15, 1,	42,	54,	'2000-01-01 00:00:00',	208,	0,	NULL,	'',	'2000-01-01 00:00:00');

-- Update all Questionnaire dates to make the data more similar to a live environment

-- ESAS-r sent today
UPDATE Questionnaire
SET DateAdded = now(),
    LastUpdated = now()
WHERE QuestionnaireControlSerNum = 42;
UPDATE Notification
SET DateAdded = now(),
    LastUpdated = now()
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum in (3, 15);
