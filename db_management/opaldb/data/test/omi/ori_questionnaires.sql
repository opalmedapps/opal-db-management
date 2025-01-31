-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

INSERT INTO `Questionnaire` (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `DateAdded`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `SessionId`, `LastUpdated`) VALUES

-- all get databank consent questionnaire except lisa
(11,	1,	157,	55,	'2000-01-01 00:00:00',	5362,	0,	NULL,	'',	'2000-01-01 00:00:00'),
(12,	1,	157,	56,	'2000-01-01 00:00:00',	5363,	0,	NULL,	'',	'2000-01-01 00:00:00'),
(13,	1,	157,	57,	'2000-01-01 00:00:00',	5364,	0,	NULL,	'',	'2000-01-01 00:00:00'),

-- fred: GAD7
(14,	1,	50,	56,	'2000-01-01 00:00:00',	5365,	0,	NULL,	'',	'2000-01-01 00:00:00');


-- Update all Questionnaire dates to make the data more similar to a live environment
-- Databank Consent sent 2 days ago
UPDATE Questionnaire
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE QuestionnaireControlSerNum = 157;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -2 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -2 DAY)
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum IN (11, 12, 13);

-- GAD7 sent 7 days ago
UPDATE Questionnaire
SET DateAdded = DATE_ADD(now(), INTERVAL -7 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE QuestionnaireControlSerNum = 50;
UPDATE Notification
SET DateAdded = DATE_ADD(now(), INTERVAL -7 DAY),
    LastUpdated = DATE_ADD(now(), INTERVAL -7 DAY)
WHERE NotificationControlSerNum = 13
AND RefTableRowSerNum = 14;
