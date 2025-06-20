-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- TODO Rows in `answerQuestionnaire` and `answer` from `db_management/questionnairedb/data/test/answers.sql` may not line up
-- TODO   with the right PatientIds based on data synced here. Consider separating questionnaire answers per hospital.

-- patients get synced automatically via the DB event SyncPublishQuestionnaire that runs periodically
