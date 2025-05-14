-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Insert the initial data required to start a project.
INSERT INTO `accesslevel` (`Id`, `AccessLevelName_EN`, `AccessLevelName_FR`) VALUES
(1,	'Need to Know',	'Accès minimum'),
(3,	'All',	'Accès à tout');

INSERT INTO `AllowableExtension` (`Type`, `Name`) VALUES
('video',	'mov'),
('video',	'mp4'),
('website',	'be'),
('website',	'ca'),
('website',	'com'),
('website',	'html'),
('website',	'net'),
('website',	'org'),
('website',	'php'),
('website',	'uk'),
('pdf',	'pdf'),
('image',	'jpeg'),
('image',	'jpg'),
('image',	'png');

INSERT INTO `BuildType` (`Name`) VALUES
('Production');

-- categories for modules
INSERT INTO `categoryModule` (`ID`, `name_EN`, `name_FR`, `order`) VALUES
(1,	'Publications',	'Publications',	1),
(2,	'Administration',	'Administration',	2),
(3, 'Clinical', 'Clinique', 3);

-- Educational Materials to be updated to Reference Materials when schema is migrated to admin
INSERT INTO `EducationalMaterialCategory` (`ID`, `title_EN`, `title_FR`, `description_EN`, `description_FR`) VALUES
(1,	'Clinical',	'Clinique',	'Clinical category',	'Catégorie clinique'),
(2,	'Research',	'Recherche',	'Research category',	'Catégorie recherche');

INSERT INTO `language` (`Id`, `Prefix`, `LanguageName_EN`, `LanguageName_FR`) VALUES
(1,	'FR',	'French',	'Français'),
(2,	'EN',	'English',	'Anglais');

-- Educational Materials to be updated to Reference Materials when schema is migrated to admin
INSERT INTO `module` (`ID`, `operation`, `name_EN`, `name_FR`, `description_EN`, `description_FR`, `tableName`, `controlTableName`, `primaryKey`, `iconClass`, `url`, `subModule`, `subModuleMenu`, `core`, `active`, `categoryModuleId`, `publication`, `customCode`, `unique`, `order`, `sqlPublicationList`, `sqlDetails`, `sqlPublicationChartLog`, `sqlPublicationListLog`, `sqlPublicationMultiple`, `sqlPublicationUnique`) VALUES
(1,	7,	'Appointments / Documents',	'Rendez-vous / Documents',	'Tool for appointments, and documents.',	'Gestion des rendez-vous et documents.',	'Alias',	'Alias',	'AliasSerNum',	'glyphicon glyphicon-cloud',	'alias',	'{\"1\": {\"ID\": 1, \"name_EN\": \"Appointment\",\"name_FR\": \"Rendez-vous\",\"iconClass\": \"calendar\"},\"2\": {\"ID\": 2, \"name_EN\": \"Document\",\"name_FR\": \"Document\",\"iconClass\": \"folder-open\"}}',	0,	0,	1,	1,	0,	1,	1,	6,	'',	'',	'',	'',	'',	''),
(2,	3,	'Posts',	'Annonces et messages',	'Tool for creating general announcements and treatment team messages.',	'Publication d\'annonces générales et de messages de l\'équipe de soin.',	'PostControl',	'PostControl',	'PostControlSerNum',	'glyphicon glyphicon-comment',	'post',	'{\"1\":{\"name_EN\":\"Announcement\",\"name_FR\":\"Annonce générale\",\"iconClass\":\"fa fa-bullhorn\",\"publishDateTime\":1},\"2\":{\"name_EN\":\"Treatment Team Message\",\"name_FR\":\"Message de l\'équipe soignante\",\"iconClass\":\"fa fa-user-md\",\"publishDateTime\":0},\"3\":{\"name_EN\":\"Patients for Patients\",\"name_FR\":\"Patients à votre aide\",\"iconClass\":\"fa fa-users\",\"publishDateTime\":0}}',	0,	0,	1,	1,	1,	0,	1,	4,	'SELECT DISTINCT pc.PostControlSerNum AS ID, 2 AS moduleId, m.name_EN AS module_EN, m.name_FR AS module_FR, pc.PostName_EN AS name_EN, pc.PostName_FR AS name_FR, pc.PostType AS type_EN, CASE WHEN pc.PostType = \"Treatment Team Message\" THEN \"Message de l\'équipe soignante\" WHEN pc.PostType = \"Patients for Patients\" THEN \"Patients à votre aide\" ELSE \"Annonce\" END AS type_FR, pc.PublishFlag AS publishFlag, IF(pc.PublishDate = \'0000-00-00 00:00:00\', \'--\', pc.PublishDate) AS publishDate FROM %%POSTCONTROL%% pc LEFT JOIN %%MODULE%% m ON m.ID = 2 WHERE (SELECT COUNT(*) FROM %%FILTERS%% f WHERE f.ControlTableSerNum = pc.PostControlSerNum and f.ControlTable = \'%%POSTCONTROL%%\') > 0',	'SELECT DISTINCT pc.PostControlSerNum AS ID, m.name_EN AS module_EN, m.name_FR AS module_FR, pc.PostName_EN AS name_EN, pc.PostName_FR AS name_FR, pc.PostType AS type_EN, CASE WHEN pc.PostType = \"Treatment Team Message\" THEN \"Message de l\'équipe soignante\" WHEN pc.PostType = \"Patients for Patients\" THEN \"Patients à votre aide\" ELSE \"Annonce\" END AS type_FR, pc.PublishFlag AS publishFlag, pc.PublishDate FROM %%POSTCONTROL%% pc LEFT JOIN %%MODULE%% m ON m.ID = 2 WHERE pc.PostControlSerNum = :ID;',	'{\"Announcement\":\"SELECT DISTINCT anmh.CronLogSerNum AS cron_serial, COUNT(anmh.CronLogSerNum) AS y, cl.CronDateTime AS x FROM %%ANNOUNCEMENT_MH_TABLE%% anmh, %%CRON_LOG_TABLE%% cl WHERE cl.CronStatus = \'Started\' AND cl.CronLogSerNum = anmh.CronLogSerNum AND anmh.CronLogSerNum IS NOT NULL AND anmh.PostControlSerNum = :cron_serial GROUP BY anmh.CronLogSerNum, cl.CronDateTime AND cl.CronDateTime >= DATE_SUB(NOW(),INTERVAL 1 YEAR) ORDER BY cl.CronDateTime ASC\",\"Treatment Team Message\":\"SELECT DISTINCT ttmmh.CronLogSerNum AS cron_serial, COUNT(ttmmh.CronLogSerNum) AS y, cl.CronDateTime AS x FROM %%TXT_TEAM_MSG_MH_TABLE%% ttmmh, %%CRON_LOG_TABLE%% cl WHERE cl.CronStatus = \'Started\' AND cl.CronLogSerNum = ttmmh.CronLogSerNum AND ttmmh.CronLogSerNum IS NOT NULL AND ttmmh.PostControlSerNum = :cron_serial GROUP BY ttmmh.CronLogSerNum, cl.CronDateTime AND cl.CronDateTime >= DATE_SUB(NOW(),INTERVAL 1 YEAR) ORDER BY cl.CronDateTime ASC\",\"Patients for Patients\":\"SELECT DISTINCT pfpmh.CronLogSerNum AS cron_serial, COUNT(pfpmh.CronLogSerNum) AS y, cl.CronDateTime AS x FROM %%PATIENTS_FOR_PATIENTS_MH_TABLE%% pfpmh, %%CRON_LOG_TABLE%% cl WHERE cl.CronStatus = \'Started\' AND cl.CronLogSerNum = pfpmh.CronLogSerNum AND pfpmh.CronLogSerNum IS NOT NULL AND pfpmh.PostControlSerNum = :cron_serial GROUP BY pfpmh.CronLogSerNum, cl.CronDateTime AND cl.CronDateTime >= DATE_SUB(NOW(),INTERVAL 1 YEAR) ORDER BY cl.CronDateTime ASC\"}',	'{\"Announcement\":\"SELECT DISTINCT pc.PostName_EN AS name, anmh.AnnouncementRevSerNum AS revision, anmh.CronLogSerNum AS cron_serial, anmh.PatientSerNum AS patient_serial, anmh.DateAdded AS date_added, anmh.ReadStatus AS read_status, anmh.ModificationAction AS mod_action FROM %%ANNOUNCEMENT_MH_TABLE%% anmh, %%POST_CONTROL_TABLE%% pc WHERE pc.PostControlSerNum = anmh.PostControlSerNum AND anmh.CronLogSerNum IN (%%CRON_LOG_IDS%%)\",\"Treatment Team Message\":\"SELECT DISTINCT pc.PostName_EN AS name, ttmmh.TxTeamMessageRevSerNum AS revision, ttmmh.CronLogSerNum AS cron_serial, ttmmh.PatientSerNum AS patient_serial, ttmmh.DateAdded AS date_added, ttmmh.ReadStatus AS read_status, ttmmh.ModificationAction AS mod_action FROM %%TXT_TEAM_MSG_MH_TABLE%% ttmmh, %%POST_CONTROL_TABLE%% pc WHERE pc.PostControlSerNum = ttmmh.PostControlSerNum AND ttmmh.CronLogSerNum IN (%%CRON_LOG_IDS%%)\",\"Patients for Patients\":\"SELECT DISTINCT pc.PostName_EN AS name, pfpmh.PatientsForPatientsRevSerNum AS revision, pfpmh.CronLogSerNum AS cron_serial, pfpmh.PatientSerNum AS patient_serial, pfpmh.DateAdded AS date_added, pfpmh.ReadStatus AS read_status, pfpmh.ModificationAction AS mod_action FROM %%PATIENTS_FOR_PATIENTS_MH_TABLE%% pfpmh, %%POST_CONTROL_TABLE%% pc WHERE pc.PostControlSerNum = pfpmh.PostControlSerNum AND pfpmh.CronLogSerNum IN (%%CRON_LOG_IDS%%)\"}',	'',	'SELECT DISTINCT pc.PostControlSerNum AS ID, pc.PostName_EN AS name_EN, pc.PostName_FR AS name_FR, pc.PostType AS type_EN, (SELECT COUNT(*) from %%FILTERS%% f WHERE f.ControlTableSerNum = pc.PostControlSerNum and f.ControlTable = \'%%POSTCONTROL%%\') AS locked FROM %%POSTCONTROL%% pc LEFT JOIN %%TXTEAMMESSAGE%% TTM ON TTM.PostControlSerNum = pc.PostControlSerNum LEFT JOIN %%ANNOUNCEMENT%% a ON a.PostControlSerNum = pc.PostControlSerNum LEFT JOIN %%PATIENTSFORPATIENTS%% PFP ON PFP.PostControlSerNum = pc.PostControlSerNum WHERE TTM.TxTeamMessageSerNum IS NULL AND a.AnnouncementSerNum IS NULL AND PFP.PatientsForPatientsSerNum IS NULL AND (SELECT COUNT(*) from %%FILTERS%% f WHERE f.ControlTableSerNum = pc.PostControlSerNum and f.ControlTable = \'%%POSTCONTROL%%\') <= 0 AND pc.deleted = 0 GROUP BY ID, name_EN, name_FR;'),
(3,	3,	'Educational / Reference Materials',	'Matériels éducatif / de référence',	'Tool for referencing materials hosted on the web.',	'Gestion des matériels éducatifs hébergés sur le Web.',	'EducationalMaterialControl',	'EducationalMaterialControl',	'EducationalMaterialControlSerNum',	'glyphicon glyphicon-book',	'educational-material',	NULL,	0,	0,	1,	1,	1,	0,	1,	3,	'SELECT DISTINCT em.EducationalMaterialControlSerNum AS ID, 3 AS moduleId, m.name_EN AS module_EN, m.name_FR AS module_FR, em.name_EN, em.name_FR, em.EducationalMaterialType_EN AS type_EN, em.EducationalMaterialType_FR AS type_FR, em.publishFlag, \'--\' AS publishDate FROM %%EDUCATIONALMATERIAL%% em LEFT JOIN %%MODULE%% m ON m.ID = 3 WHERE em.ParentFlag = 1 AND (SELECT COUNT(*) FROM %%FILTERS%% f WHERE f.ControlTableSerNum = em.EducationalMaterialControlSerNum and f.ControlTable = \'%%EDUCATIONALMATERIAL%%\') > 0',	'SELECT DISTINCT em.EducationalMaterialControlSerNum AS ID, m.name_EN AS module_EN, m.name_FR AS module_FR, em.name_EN, em.name_FR, em.EducationalMaterialType_EN AS type_EN, em.EducationalMaterialType_FR AS type_FR, em.publishFlag FROM %%EDUCATIONALMATERIAL%% em LEFT JOIN %%MODULE%% m ON m.ID = 3 WHERE em.EducationalMaterialControlSerNum = :ID',	'{\"0\":\"SELECT DISTINCT emmh.CronLogSerNum AS cron_serial, COUNT(emmh.CronLogSerNum) AS y, cl.CronDateTime AS x FROM %%EDUCATION_MATERIAL_MH_TABLE%% emmh, %%CRON_LOG_TABLE%% cl WHERE cl.CronStatus = \'Started\' AND cl.CronLogSerNum = emmh.CronLogSerNum AND emmh.CronLogSerNum IS NOT NULL AND emmh.EducationalMaterialControlSerNum = :cron_serial GROUP BY emmh.CronLogSerNum, cl.CronDateTime ORDER BY cl.CronDateTime ASC\"}',	'{\"0\":\"SELECT DISTINCT emc.Name_EN AS name, emmh.EducationalMaterialRevSerNum AS revision, emmh.CronLogSerNum AS cron_serial, emmh.PatientSerNum AS patient_serial, emmh.DateAdded AS date_added, emmh.ReadStatus AS read_status, emmh.ModificationAction AS mod_action FROM %%EDUCATION_MATERIAL_MH_TABLE%% emmh, %%EDUCATION_MATERIAL_CONTROL_TABLE%% emc WHERE emc.EducationalMaterialControlSerNum = emmh.EducationalMaterialControlSerNum AND emmh.CronLogSerNum IN (%%CRON_LOG_IDS%%)\"}',	'',	'SELECT DISTINCT em.EducationalMaterialControlSerNum AS ID, em.name_EN, em.name_FR, em.EducationalMaterialType_EN AS type_EN FROM %%EDUCATIONALMATERIAL%% em WHERE em.ParentFlag = 1 AND (SELECT COUNT(*) FROM %%FILTERS%% f WHERE f.ControlTableSerNum = em.EducationalMaterialControlSerNum and f.ControlTable = \'%%EDUCATIONALMATERIAL%%\') <= 0 GROUP BY ID, name_EN, name_FR;'),
(4,	3,	'Hospital Maps',	'Cartes de l\'hôpital',	'Tool for referencing hospital maps.',	'Gestion des cartes de l\'hôpital.',	'HospitalMap',	'HospitalMap',	'HospitalMapSerNum',	'fa fa-map',	'hospital-map',	NULL,	0,	0,	1,	1,	0,	0,	1,	5,	'',	'',	'',	'',	'',	''),
(5,	3,	'Notifications',	'Notifications',	'Tool for managing notifications.',	'Gestion des messages aux patients et des status des rendez-vous.',	'NotificationControl',	'NotificationControl',	'NotificationControlSerNum',	'glyphicon glyphicon-bell',	'notification',	NULL,	0,	0,	1,	2,	0,	0,	1,	23,	'',	'',	'',	'',	'',	''),
(6,	3,	'Lab Results',	'Résultats de laboratoire',	'Tool for publishing lab test results categorized by test group.',	'Publication des résultats de laboratoire classés par groupe de tests.',	'TestResultControl',	'TestResultControl',	'TestResultControlSerNum',	'fa fa-heartbeat',	'test-result',	NULL,	0,	0,	1,	1,	0,	0,	1,	7,	'',	'',	'',	'',	'',	''),
(7,	3,	'Questionnaires',	'Questionnaires',	'Manage patient-reported outcome questionnaires.',	'Gestion des questionnaires et des réponses des patients.',	'QuestionnaireControl',	'LegacyQuestionnaireControl',	'QuestionnaireControlSerNum',	'fa fa-pencil-square-o',	'questionnaire/menu',	'{\"1\":{\"name_EN\":\"Manage Questionnaires\",\"name_FR\":\"Gérer les questionnaires\",\"description_EN\":\"Create, view, update and delete questionnaires.\",\"description_FR\":\"Créer, afficher, mettre à jour et supprimer des questionnaires.\",\"iconClass\":\"fa fa-pencil fa-sm\",\"url\":\"questionnaire\"},\"2\":{\"name_EN\":\"Manage Questions\",\"name_FR\":\"Gérer les questions\",\"description_EN\":\"View and edit all the questions stored in the question bank.\",\"description_FR\":\"Afficher et modifier toutes les questions stockées dans la banque de données.\",\"iconClass\":\"fa fa-search fa-sm\",\"url\":\"questionnaire/question\"},\"3\":{\"name_EN\":\"Response Types Templates\",\"name_FR\":\"Modèles de types de réponse\",\"description_EN\":\"Create, view, update and delete templates of responses.\",\"description_FR\":\"Créer, afficher, mettre à jour et supprimer des modèles de réponses.\",\"iconClass\":\"fa fa-question-circle-o fa-sm\",\"url\":\"questionnaire/template-question\"}}',	1,	0,	1,	1,	1,	0,	0,	1,	'SELECT DISTINCT qc.QuestionnaireControlSerNum AS ID, 7 AS moduleId, m.name_EN AS module_EN, m.name_FR AS module_FR, qc.QuestionnaireName_EN AS name_EN, qc.QuestionnaireName_FR AS name_FR, (SELECT d.content FROM %%QUESTIONNAIRE_DB%%.%%DICTIONARY%% d WHERE d.contentId = q.title AND d.languageId = 2) AS type_EN, (SELECT d.content FROM %%QUESTIONNAIRE_DB%%.%%DICTIONARY%% d WHERE d.contentId = q.title AND d.languageId = 1) AS type_FR, qc.publishFlag, \"--\" AS publishDate FROM %%QUESTIONNAIRECONTROL%% qc LEFT JOIN %%MODULE%% m ON m.ID = 7 INNER JOIN %%QUESTIONNAIRE_DB%%.%%QUESTIONNAIRE%% q ON q.ID = qc.QuestionnaireDBSerNum',	'SELECT DISTINCT qc.QuestionnaireControlSerNum AS ID, m.name_EN AS module_EN, m.name_FR AS module_FR, qc.QuestionnaireName_EN AS name_EN, qc.QuestionnaireName_FR AS name_FR, (SELECT d.content FROM %%QUESTIONNAIRE_DB%%.%%DICTIONARY%% d WHERE d.contentId = q.title AND d.languageId = 2) AS type_EN, (SELECT d.content FROM %%QUESTIONNAIRE_DB%%.%%DICTIONARY%% d WHERE d.contentId = q.title AND d.languageId = 1) AS type_FR FROM %%QUESTIONNAIRECONTROL%% qc LEFT JOIN %%MODULE%% m ON m.ID = 7 INNER JOIN %%QUESTIONNAIRE_DB%%.%%QUESTIONNAIRE%% q ON q.ID = qc.QuestionnaireDBSerNum WHERE qc.QuestionnaireControlSerNum = :ID',	'{\"0\":\"SELECT DISTINCT qmh.CronLogSerNum AS cron_serial, COUNT(qmh.CronLogSerNum) AS y, cl.CronDateTime AS x FROM %%QUESTIONNAIRE_MH_TABLE%% qmh, %%CRON_LOG_TABLE%% cl WHERE cl.CronStatus = \'Started\' AND cl.CronLogSerNum = qmh.CronLogSerNum AND qmh.CronLogSerNum IS NOT NULL AND qmh.QuestionnaireControlSerNum = :cron_serial GROUP BY qmh.CronLogSerNum, cl.CronDateTime ORDER BY cl.CronDateTime ASC\"}',	'{\"0\":\"SELECT DISTINCT qc.QuestionnaireName_EN AS name, qmh.QuestionnaireRevSerNum AS revision, qmh.CronLogSerNum AS cron_serial, qmh.PatientSerNum AS patient_serial, qmh.DateAdded AS date_added, 0 AS read_status, qmh.ModificationAction AS mod_action FROM %%QUESTIONNAIRE_MH_TABLE%% qmh, %%QUESTIONNAIRE_CONTROL_TABLE%% qc WHERE qc.QuestionnaireControlSerNum = qmh.QuestionnaireControlSerNum AND qmh.CronLogSerNum IN (%%CRON_LOG_IDS%%)\"}',	'SELECT q.ID, (SELECT d.content FROM %%QUESTIONNAIRE_DB%%.%%DICTIONARY%% d WHERE d.contentId = q.title AND d.languageId = 2) AS name_EN, (SELECT d.content FROM %%QUESTIONNAIRE_DB%%.%%DICTIONARY%% d WHERE d.contentId = q.title AND d.languageId = 1) AS name_FR, (SELECT COUNT(*) from %%FILTERS%% f WHERE f.ControlTableSerNum = qc.QuestionnaireControlSerNum and f.ControlTable = \'LegacyQuestionnaireControl\') AS locked FROM %%QUESTIONNAIRE_DB%%.questionnaire q LEFT JOIN %%QUESTIONNAIRECONTROL%% qc ON qc.QuestionnaireDBSerNum = q.ID WHERE q.final = 1 AND (q.private = 0 OR q.OAUserId = :OAUserId) AND q.deleted = 0 GROUP BY ID, name_EN, name_FR;',	''),
(8,	3,	'Publication Tools',	'Outils de publication',	'Manage the publications and their triggers associated.',	'Gestion des publications et de leurs déclencheurs.',	'',	'',	'',	'fa fa-rss',	'publication',	NULL,	0,	0,	1,	1,	-1,	0,	1,	2,	'',	'',	'',	'',	'',	''),
(9,	7,	'Diagnosis Import and Aliasing',	'Importation et alias de diagnostics',	'Manage diagnosis codes.',	'Gestion les codes de diagnostic.',	'DiagnosisTranslation',	'DiagnosisTranslation',	'DiagnosisTranslationSerNum',	'fa fa-stethoscope',	'diagnosis-translation',	NULL,	0,	0,	1,	1,	0,	1,	1,	9,	'',	'',	'',	'',	'',	''),
(11,	3,	'Patients',	'Patients',	'Manage patients listing, registration and activities.',	'Gérer la liste, l\'inscription et les activités des patients.',	'Patient',	'Patient',	'PatientSerNum',	'fa fa-address-card',	'patients/menu',	'{\"1\":{\"name_EN\":\"View Patients\",\"name_FR\":\"Voir les patients\",\"description_EN\":\"View the list of patients.\",\"description_FR\":\"Voir la liste des patients.\",\"iconClass\":\"fa fa-address-card\",\"url\":\"patients\"},\"2\":{\"name_EN\":\"Patient Activity\",\"name_FR\":\"Activité patient\",\"description_EN\":\"List of patient sessions, connection / disconnection time and app activities.\",\"description_FR\":\"Liste des sessions des patients, heure de connexion / déconnexion et activités de l\'appli.\",\"iconClass\":\"fa fa-hourglass-half\",\"url\":\"patients/activity\"},\"3\":{\"name_EN\":\"Patient Report\",\"name_FR\":\"Rapport patient\",\"description_EN\":\"Search and generate reports for Opal patients.\",\"description_FR\":\"Rechercher et générer des rapports pour les patients utilisant Opal.\",\"iconClass\":\"fa fa fa-file-text\",\"url\":\"patients/report\"}}',	1,	1,	1,	2,	0,	0,	1,	12,	'',	'',	'',	'',	'',	''),
(12,	7,	'Users',	'Utilisateurs',	'Monitor user activity. Change passwords.',	'Surveiller l\'activité des utilisateurs. Changer les mots de passe.',	'OAUser',	'OAUser',	'OAUserSerNum',	'fa fa-users',	'users',	NULL,	0,	1,	1,	2,	0,	0,	1,	14,	'',	'',	'',	'',	'',	''),
(13,	3,	'Studies',	'Études',	'Manage studies to which are associated patients.',	'Gérer les études cliniques auxquelles sont associées certains patients.',	'study',	'study',	'ID',	'fa fa-pie-chart',	'study',	NULL,	0,	0,	1,	3,	0,	0,	1,	2,	'',	'',	'',	'',	'',	''),
(14,	3,	'Emails',	'Courriels',	'Tool for creating email templates.',	'Outil pour créer des modèles de courriel.',	'EmailControl',	'EmailControl',	'EmailControlSerNum',	'fa fa-envelope',	'email',	NULL,	0,	0,	0,	1,	0,	0,	1,	8,	'',	'',	'',	'',	'',	''),
(16,	7,	'Roles',	'Rôles',	'Manage the list of roles of the users.',	'Gestion de la liste des rôles des utilisateurs.',	'oaRole',	'oaRole',	'ID',	'fa fa-address-card-o',	'role',	NULL,	0,	1,	1,	2,	0,	0,	1,	16,	'',	'',	'',	'',	'',	''),
(17,	3,	'Alerts',	'Alertes',	'Manage the list of alerts and triggers for conditions.',	'Gestion de la liste des alertes et déclencheurs pour conditions.',	'alert',	'alert',	'ID',	'glyphicon glyphicon-exclamation-sign',	'alert',	NULL,	0,	0,	0,	2,	0,	0,	1,	26,	'',	'',	'',	'',	'',	''),
(18,	1,	'Audit',	'Audit',	'Audit the users operations in OpalAdmin.',	'Auditer les opérations des utilisateurs dans OpalAdmin.',	'audit',	'audit',	'ID',	'fa fa-gavel',	'audit',	NULL,	0,	0,	1,	2,	0,	0,	1,	24,	'',	'',	'',	'',	'',	''),
(19,	3,	'Trigger (API only / No GUI)',	'Déclencheur (API seulement / pas de GUI)',	'Tool to manage triggers for different conditions',	'Gestion des déclencheurs pour les différentes conditions.',	'jsonTrigger',	'jsonTrigger',	'id',	'fa fa-gavel',	'trigger',	NULL,	0,	0,	1,	2,	0,	0,	1,	19,	'',	'',	'',	'',	'',	''),
(20,	7,	'Master Lists Management (API only / No GUI)',	'Gestion des listes principales (API seulement / pas de GUI)',	'Manage the master source lists for aliases, diagnoses, and lab results.',	'Gestion des sources des alias, diagnostics et des résultats de laboratoire.',	'',	'',	'',	'fa fa-list-ol',	'master-source/menu',	'{\"1\":{\"name_EN\":\"Master Source Aliases\",\"name_FR\":\"Source principale des alias\",\"description_EN\":\"List of clinical codes for tasks, appointments and documents used by Opal.\",\"description_FR\":\"List des codes cliniques pour les tâches, rendez-vous et documents utilisés par Opal.\",\"iconClass\":\"glyphicon glyphicon-cloud\",\"url\":\"master-source/alias\"},\"2\":{\"name_EN\":\"Master Source Diagnoses\",\"name_FR\":\"Source principale des diagnostics\",\"description_EN\":\"List of diagnostic codes used by Opal.\",\"description_FR\":\"Liste des codes de diagnostic utilisés par Opal.\",\"iconClass\":\"fa fa-stethoscope\",\"url\":\"master-source/diagnosis\"},\"3\":{\"name_EN\":\"Master Source Test Results\",\"name_FR\":\"Source principale des tests de laboratoire\",\"description_EN\":\"List of test results codes used by Opal\",\"description_FR\":\"Liste des codes de tests de laboratoire utilisés par Opal.\",\"iconClass\":\"fa fa-heartbeat\",\"url\":\"master-source/test-result\"}}',	1,	0,	1,	2,	0,	0,	1,	20,	'',	'',	'',	'',	'',	''),
(21,	7,	'Resources (API only / No GUI)',	'Ressources (API seulement / pas de GUI)',	'Manage the resources for appointments.',	'Gestion des ressources pour les rendez-vous.',	'',	'',	'',	'fa fa-list-ol',	'resource',	NULL,	0,	0,	1,	2,	0,	0,	1,	22,	'',	'',	'',	'',	'',	''),
(22,	3,	'SMS',	'SMS',	'Manage the sms appointments.',	'Gestion des rendez-vous de sms.',	'SmsAppointment',	'SmsAppointment',	'SmsAppointmentId',	'glyphicon glyphicon-phone',	'sms',	NULL,	0,	0,	1,	2,	-1,	0,	1,	23,	'',	'',	'',	'',	'',	''),
(23,	3,	'Opal User Administration',	'Administration des utilisateurs',	'Manage the user account information.',	'Gérer les informations du compte utilisateur.',	'',	'',	'',	'fa fa-user-circle',	'patient-administration',	NULL,	0,	0,	1,	2,	0,	0,	1,	13,	'',	'',	'',	'',	'',	''),
(24,	3,	'Hospital Settings',	'Paramètres de l\'hôpital',	'Manage hospital settings.',	'Gérer les paramètres de configuration de l\'hôpital.',	'',	'',	'',	'fa fa-wrench',	'hospital-settings',	'',	0,	1,	1,	2,	0,	0,	1,	22,	'',	'',	'',	'',	'',	''),
(25,	3,	'Clinician Dashboard',	'Tableau de bord du clinicien',	'Clinician Dashboard Tools.',	'Outils du tableau de bord du clinicien.',	'',	'',	'',	'fa fa-user-md',	'clinician',	'',	0,	1,	1,	3,	0,	0,	1,	1,	'',	'',	'',	'',	'',	'');


INSERT INTO `publicationSetting` (`ID`, `name_EN`, `name_FR`, `internalName`, `isTrigger`, `isUnique`, `selectAll`, `opalDB`, `opalPK`, `custom`) VALUES
(1,	'Publish Frequency',	'Fréquence de publication',	'occurrence',	0,	1,	0,	'FrequencyEvents',	'',	'{\"occurrence\":\"\"}'),
(2,	'Trigger to Send By Patient',	'Déclencheur par patient',	'Patient',	1,	0,	1,	'SELECT DISTINCT PatientSerNum AS id, \'Patient\' AS type, 0 AS added, CONCAT(CONCAT(UCASE(SUBSTRING(LastName, 1, 1)), LOWER(SUBSTRING(LastName, 2))), \', \', CONCAT(UCASE(SUBSTRING(FirstName, 1, 1)), LOWER(SUBSTRING(FirstName, 2)))) AS name FROM Patient ORDER BY LastName;',	'id',	''),
(3,	'Trigger to Send By Demographic',	'Déclencheur par démographie',	'Sex,Age',	1,	1,	0,	'',	'',	'{\"enum\":{\"0\":\"Male\",\"1\":\"Female\"}};{\"range\":{\"0\":\"0\",\"1\":\"130\"}}'),
(4,	'Trigger to Send By Appointment Status',	'Déclencheur par statut de rendez-vous',	'AppointmentStatus',	1,	1,	0,	'SELECT DISTINCT sa.name AS name, sa.name AS id, \'AppointmentStatus\' AS type, 0 AS added FROM StatusAlias sa UNION SELECT \'Checked In\' AS name, 1 AS id, \'CheckedInFlag\' AS TYPE, 0 AS added;',	'id',	''),
(5,	'Trigger to Send By Appointment',	'Déclencheur par rendez-vous',	'Appointment',	1,	0,	1,	'SELECT DISTINCT AliasName_EN AS name, AliasName_FR AS name_FR, AliasSerNum AS id, \'Appointment\' AS type, 0 AS added FROM Alias WHERE AliasType = \'Appointment\' ORDER BY AliasName_EN',	'id',	''),
(6,	'Trigger to Send By Diagnosis',	'Déclencheur par diagnostic',	'Diagnosis',	1,	0,	1,	'SELECT DISTINCT dt.Name_EN AS name, dt.Name_FR, dt.DiagnosisTranslationSerNum AS id, \'Diagnosis\' AS type, 0 AS added FROM DiagnosisTranslation dt WHERE dt.Name_EN != \'\'',	'id',	''),
(7,	'Trigger to Send By Doctor',	'Déclencheur par médecin',	'Doctor',	1,	0,	1,	'SELECT DISTINCT CONCAT(trim(Doctor.FirstName), \" \", trim(Doctor.LastName), \" (\", max(Doctor.DoctorAriaSer), \")\") AS name, max(Doctor.DoctorAriaSer) AS id, \'Doctor\' AS type, 0 AS added FROM Doctor Doctor WHERE Doctor.ResourceSerNum > 0 GROUP BY  Doctor.LastName ORDER BY Doctor.LastName, Doctor.FirstName;',	'id',	''),
(8,	'Trigger to Send By Treatment Machine',	'Déclencheur par machine de traitement',	'Machine',	1,	0,	1,	'SELECT DISTINCT ResourceAriaSer AS id, ResourceName AS name, \'Machine\' AS type, 0 AS added FROM Resource WHERE (ResourceName LIKE \'STX%\' OR ResourceName LIKE \'TB%\') ORDER BY ResourceName;',	'id',	''),
(9,	'Publish Date',	'Date de publication',	'publishDateTime',	0,	1,	0,	'',	'',	'{\"dateTime\":\"Y-m-d H:i\"}'),
(10,	'Trigger to Send By Study',	'Déclencheur par étude',	'Study',	1,	0,	1,	'SELECT DISTINCT ID AS id, CONCAT (code, \" \", title_EN) AS name, \"Study\" AS type, 0 AS added FROM study WHERE deleted = 0 ORDER BY code, title_EN;',	'id',	'');


INSERT INTO `modulePublicationSetting` (`ID`, `moduleId`, `publicationSettingId`) VALUES
(1,	2,	2),
(2,	2,	5),
(3,	2,	6),
(4,	2,	7),
(5,	2,	8),
(6,	2,	9),
(7,	3,	2),
(8,	3,	3),
(9,	3,	5),
(10,	3,	6),
(11,	3,	7),
(12,	3,	8),
(13,	7,	2),
(14,	7,	1),
(15,	7,	3),
(16,	7,	4),
(17,	7,	5),
(19,	7,	6),
(20,	7,	7),
(21,	7,	8),
(22,	2,	10),
(23,	3,	10),
(24,	7,	10);


INSERT INTO `NotificationTypes` (`NotificationTypeSerNum`, `NotificationTypeId`, `NotificationTypeName`, `DateAdded`, `LastUpdated`) VALUES
(2,	'Document',	'Document',	'2016-03-23 12:56:39',	'2016-03-23 20:56:39'),
(3,	'TxTeamMessage',	'Treatment Team Message',	'2016-03-23 12:56:57',	'2016-03-23 20:56:57'),
(4,	'Announcement',	'Announcement',	'2016-03-23 12:57:14',	'2016-03-23 20:57:14'),
(5,	'EducationalMaterial',	'Educational Material',	'2016-03-23 12:58:04',	'2016-03-23 20:58:04'),
(6,	'NextAppointment',	'Next Appointment',	'2016-03-23 12:58:24',	'2016-03-23 20:58:24'),
(7,	'AppointmentTimeChange',	'Appointment Time Change',	'2016-03-23 12:59:47',	'2018-03-27 18:26:02'),
(8,	'NewMessage',	'New Message',	'2016-03-24 00:00:00',	'2016-03-25 01:45:59'),
(9,	'NewLabResult',	'New Lab Result',	'2016-03-24 00:00:00',	'2016-03-25 01:46:11'),
(10,	'UpdDocument',	'Updated Document',	'2016-10-18 00:00:00',	'2016-10-18 23:32:49'),
(11,	'RoomAssignment',	'Room Assignment',	'2016-11-30 15:38:00',	'2016-12-01 01:38:06'),
(12,	'PatientsForPatients',	'Patients For Patients Announcement	',	'2017-01-30 15:08:00',	'2017-01-31 01:08:00'),
(14,	'LegacyQuestionnaire',	'Legacy Questionnaire',	'2017-10-13 10:57:08',	'2017-10-13 18:57:08'),
(15,	'CheckInNotification',	'CheckInNotification',	'2017-11-07 17:41:49',	'2017-11-08 03:41:51'),
(16,	'CheckInError',	'Check In Error',	'2018-03-27 10:21:16',	'2018-03-27 18:21:16'),
(17,	'AppointmentCancelled',	'Cancelled Appointment',	'2018-03-27 10:26:20',	'2018-03-27 18:26:20'),
(18,	'AppointmentNew',	'New Appointment',	'2023-01-12 11:39:14',	'2023-01-12 16:39:14'),
(19,	'AppointmentReminder',	'Appointment Reminder',	'2023-11-27 11:39:14',	'2023-11-27 16:39:14');


INSERT INTO `NotificationControl` (`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationType`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `LastUpdated`, `SessionId`) VALUES
(2,	'New Document',	'Nouveau Document',	'$patientName ($institution): New document',	'$patientName ($institution): Nouveau document',	'Document',	2,	'2016-03-24 17:30:17',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(4,	'New Treating Team Message',	'Nouveau message de l\'équipe soignante',	'$patientName ($institution): New message from your treatment team',	'$patientName ($institution): Nouveau message de votre équipe soignante',	'TxTeamMessage',	3,	'2016-03-17 00:00:00',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(5,	'New Announcement',	'Nouvelle annonce',	'$patientName ($institution): New general announcement',	'$patientName ($institution): Nouvelle annonce générale',	'Announcement',	4,	'2016-03-30 12:57:50',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(6,	'Appointment Time Change',	'Changement d\'heure de rendez-vous',	'$patientName ($institution): Appointment on $oldAppointmentDateEN at $oldAppointmentTimeEN has been changed to $newAppointmentDateEN at $newAppointmentTimeEN',	'$patientName ($institution): Rendez-vous du $oldAppointmentDateFR à $oldAppointmentTimeFR a été changé au $newAppointmentDateFR à $newAppointmentTimeFR',	'AppointmentTimeChange',	7,	'2016-03-30 14:27:06',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	'FBJ8aRtN6L'),
(7,	'New Reference Material',	'Nouveau document de référence',	'$patientName ($institution): New Reference material',	'$patientName ($institution): Nouveau document de référence',	'EducationalMaterial',	5,	'2016-05-06 16:24:32',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(8,	'Next Appointment',	'Prochain rendez-vous',	'$patientName ($institution): Next appointment',	'$patientName ($institution): Prochain rendez-vous',	'NextAppointment',	6,	'2016-05-06 17:45:26',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(9,	'Updated Document',	'Document mis à jour',	'$patientName ($institution): Document updated',	'$patientName ($institution): Document mis à jour',	'UpdDocument',	10,	'2016-10-18 15:34:45',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(10,	'Appointment Call-in',	'Appel de rendez-vous',	'$patientName ($institution): Please go to $roomNumber for your appointment',	'$patientName ($institution): Veuillez vous rendre à $roomNumber pour votre rendez-vous',	'RoomAssignment',	11,	'2016-11-30 15:41:32',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(12,	'Appointment(s) Check-in',	'Enregistrement de mon rendez-vous',	'$patientName ($institution): Successfully checked in for your appointment(s) at $getDateTime. You will receive another notification when you are called in to your appointment(s).',	'$patientName ($institution): Enregistrement réussi à votre/vos rendez-vous de $getDateTime. Vous recevrez une autre notification lorsque vous serez appelé(e) à votre/vos rendez-vous.',	'CheckInNotification',	15,	'2017-11-07 17:43:27',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	'K0YKH6ugHm'),
(13,	'New Questionnaire',	'Nouveau questionnaire',	'$patientName ($institution): New questionnaire received. Please complete it before seeing your health care provider.',	'$patientName ($institution): Nouveau questionnaire reçu. Veuillez le compléter avant votre rendez-vous avec votre professionnel de la santé.',	'LegacyQuestionnaire',	14,	'2017-11-07 17:44:52',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	'EYl0ROULBM'),
(14,	'Error Checking In',	'Erreur lors de l\'enregistrement',	'$patientName ($institution): Couldn\'t check into one or more appointments. Please go to the reception.',	'$patientName ($institution): Enregistrement impossible à un ou plusieurs rendez-vous. Veuillez vous rendre à la réception.',	'CheckInError',	16,	'2017-11-24 11:59:45',	NULL,	'2017-11-24 11:59:45',	'2023-01-12 16:39:16',	'hg2nFkFxHJ'),
(15,	'New Lab Result',	'Nouveau résultat de laboratoire',	'$patientName ($institution): New lab test result',	'$patientName ($institution): Nouveau résultat de test de laboratoire',	'NewLabResult',	9,	'2018-06-08 09:09:14',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	'XddBb7PBiK'),
(16,	'Appointment Cancelled',	'Rendez-vous annulé',	'$patientName ($institution): Appointment on $oldAppointmentDateEN at $oldAppointmentTimeEN has been cancelled.',	'$patientName ($institution): Rendez-vous du $oldAppointmentDateFR à $oldAppointmentTimeFR a été annulé.',	'AppointmentCancelled',	17,	'2023-01-12 11:39:14',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(17,	'New Appointment',	'Nouveau rendez-vous',	'$patientName ($institution): New appointment on $newAppointmentDateEN at $newAppointmentTimeEN',	'$patientName ($institution): Nouveau rendez-vous le $newAppointmentDateFR à $newAppointmentTimeFR',	'AppointmentNew',	18,	'2023-01-12 11:39:14',	NULL,	'0000-00-00 00:00:00',	'2023-01-12 16:39:16',	NULL),
(18,	'Appointment Reminder',	'Rappel de rendez-vous',	'$patientName ($institution): Reminder for an appointment at the $hospitalEN: $appointmentAliasEN on $appointmentDate at $appointmentTime',	'$patientName ($institution): Rappel pour un rendez-vous au $hospitalFR : $appointmentAliasFR le $appointmentDate à $appointmentTime',	'AppointmentReminder',	19,	'2023-11-27 11:39:14',	NULL,	'0000-00-00 00:00:00',	'2023-11-27 16:39:16',	NULL);


INSERT IGNORE INTO `oaRole` (`ID`, `name_EN`, `name_FR`, `deleted`, `deletedBy`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`) VALUES
(1,	'System Administrator',	'Administrateur du système',	0,	'',	'2020-06-04 09:08:14',	'BODO6005',	'2020-08-19 16:47:32',	'BODO6005'),
(4,	'Patient Registration',	'Enregistrement patient',	0,	'',	'2020-06-04 09:08:35',	'BODO6005',	'2020-06-04 17:08:35',	'BODO6005'),
(5,	'Test Role',	'Test Rôle',	1,	'BODO6005',	'2020-08-10 09:22:33',	'BODO6005',	'2020-08-10 17:58:21',	'BODO6005'),
(6,	'Publication',	'Publication',	0,	'',	'2020-08-10 09:59:18',	'BODO6005',	'2020-08-10 21:10:32',	'BODO6005'),
(7,	'Content Creation',	'Création de contenu',	0,	'',	'2020-08-10 10:00:07',	'BODO6005',	'2021-09-08 17:06:19',	'CABR6008'),
(8,	'Patient Support',	'Soutien aux patients',	0,	'',	'2020-08-10 10:00:45',	'BODO6005',	'2020-08-10 18:00:45',	'BODO6005'),
(9,	'External System',	'Système externe',	1,	'BODO6005',	'2020-09-01 12:42:01',	'BODO6005',	'2020-12-08 00:09:13',	'BODO6005'),
(29,	'External System',	'Système externe',	0,	'',	'2020-09-01 12:42:01',	'BODO6005',	'2020-09-29 16:44:27',	'BODO6005'),
(30,	'Patients and Diagnoses',	'Patients et diagnostics',	0,	'',	'2020-11-18 14:32:54',	'BODO6005',	'2020-11-19 00:32:54',	'BODO6005'),
(32,	'Listener',	'Listener',	0,	'',	'2021-03-26 10:52:35',	'BODO6005',	'2021-03-26 18:59:26',	'MOYI6000'),
(33,	'Superuser',	'Superutilisateur',	1,	'CABR6008',	'2021-08-25 10:11:59',	'CABR6008',	'2021-08-25 18:13:18',	'CABR6008'),
(34,	'Superuser',	'Superutilisateur',	0,	'',	'2021-08-25 10:14:37',	'CABR6008',	'2021-08-25 18:53:22',	'CABR6008'),
(35,	'Lab Results',	'Résultats de laboratoire',	0,	'',	'2021-09-21 08:47:42',	'CABR6008',	'2021-09-21 16:47:42',	'CABR6008'),
(36,    'ORMS', 'ORMS', 0, '', '2024-03-19 09:22:20', 'AGKE6000', '2024-03-19 09:22:31', 'AGKE6000'),
(37,	'Medical Records',	'Dossiers médicaux',	0,	'',	'2024-03-19 09:22:20',	'AGKE6000',	'2024-03-19 09:22:20',	'AGKE6000');

INSERT IGNORE INTO `oaRoleModule` (`ID`, `moduleId`, `oaRoleId`, `access`) VALUES
(1,	1,	1,	3),
(2,	2,	1,	3),
(3,	3,	1,	3),
(4,	4,	1,	3),
(5,	5,	1,	3),
(6,	6,	1,	3),
(7,	7,	1,	3),
(8,	8,	1,	3),
(9,	9,	1,	3),
(11,	11,	1,	3),
(12,	12,	1,	3),
(14,	16,	1,	3),
(15,	11,	4,	3),
(16,	1,	5,	7),
(17,	2,	5,	3),
(18,	3,	5,	1),
(19,	11,	5,	1),
(20,	12,	5,	1),
(25,	8,	6,	3),
(26,	2,	7,	3),
(27,	3,	7,	3),
(28,	5,	7,	3),
(29,	7,	7,	3),
(30,	11,	8,	1),
(31,	13,	1,	3),
(32,	17,	1,	3),
(33,	18,	1,	1),
(34,	7,	9,	3),
(35,	19,	9,	3),
(36,	9,	9,	3),
(37,	7,	29,	3),
(38,	19,	29,	3),
(39,	9,	29,	3),
(40,	9,	30,	3),
(41,	11,	30,	3),
(45,	1,	32,	1),
(46,	3,	32,	1),
(47,	4,	32,	1),
(48,	5,	32,	1),
(49,	6,	32,	1),
(50,	7,	32,	1),
(51,	9,	32,	1),
(52,	11,	32,	1),
(53,	17,	32,	1),
(54,	19,	32,	1),
(55,	1,	33,	3),
(56,	2,	33,	3),
(57,	3,	33,	3),
(58,	4,	33,	3),
(59,	5,	33,	3),
(60,	6,	33,	1),
(61,	7,	33,	3),
(62,	8,	33,	3),
(63,	9,	33,	1),
(64,	11,	33,	1),
(65,	12,	33,	3),
(66,	1,	34,	3),
(67,	2,	34,	3),
(68,	3,	34,	3),
(69,	4,	34,	3),
(70,	5,	34,	1),
(71,	6,	34,	1),
(72,	7,	34,	3),
(73,	8,	34,	3),
(74,	9,	34,	1),
(75,	11,	34,	1),
(77,	12,	34,	1),
(78,	6,	35,	3),
(79,	22,	1,	3),
(80,	23,	1,	3),
(81,	24,	1,	3),
(82,	11,	29,	3),
(83,	25,	1,	3),
(84,	12,	1,	7),
(85,	16,	1,	7),
(86,	21,	29,	7),
(87,	20,	29,	7),
(88,	25,	36,	1),
(89,	11,	37,	1),
(90,    7,  36, 3),
(91,    9,  36, 7),
(92,    11, 36, 3),
(93,    19, 36, 3),
(94,    20, 36, 7),
(95,    21, 36, 7),
(96,    13, 36, 3);

-- disable some security questionnaire to test the following
-- 1. the app should still select a security questionniare that an end-user have created before the security question was disabled
-- 2. when a new end-user register for Opal, only active security questions should be available
INSERT INTO `SecurityQuestion` (`SecurityQuestionSerNum`, `QuestionText_EN`, `QuestionText_FR`, `CreationDate`, `LastUpdated`, `Active`) VALUES
(1,	'What is the name of your first pet?',	'Quel est le nom de votre premier animal de compagnie?',	'2016-10-18 15:03:56',	'2018-08-01 21:20:57',	1),
(2,	'What was the name of your favorite superhero as a child?',	'Quel était le nom de votre super-héros préféré durant votre enfance?',	'2016-10-18 15:03:56',	'2020-03-23 22:22:37',	0),
(3,	'What is your favorite cartoon?',	'Quel est votre programme de bande-dessin préféré?',	'2016-10-18 15:03:56',	'2020-03-23 22:22:37',	0),
(4,	'What is your favorite musical instrument?',	'Quel est votre instrument de musique préféré?',	'2016-10-18 15:03:56',	'2020-03-23 22:22:37',	0),
(5,	'What was the color of your first car?',	'Quelle était la couleur de votre première voiture?',	'2016-10-18 15:03:56',	'2020-03-23 22:22:38',	0),
(6,	'What is the first name of your childhood best friend?',	"Quel est le prénom de votre meilleur ami d'enfance?",	'2016-10-18 15:03:56',	'2019-05-28 18:30:49',	1),
(7,	'What is the name of your eldest niece?',	"Quel est le prénom de l'aînée de vos nièces?",	'2017-04-03 12:22:06',	'2019-05-28 18:33:40',	1),
(8,	'What is the name of your eldest nephew?',	"Quel est le prénom de l'aîné de vos neveux?",	'2017-04-03 12:22:06',	'2019-05-28 18:33:34',	1),
(9,	'What is the maiden name of your maternal grandmother?',	'Quel est le nom de jeune fille de votre grand-mère maternelle?',	'2017-04-03 12:22:32',	'2018-08-01 21:21:14',	1),
(10,	'What was the destination of your first trip by plane?',	'Quelle était la destination lors de votre premier voyage en avion?',	'2017-04-03 12:22:32',	'2020-03-23 22:22:41',	0),
(11,	'What was your favorite sport as a child?',	'Quel était votre sportif préféré durant votre enfance?',	'2017-04-03 12:22:49',	'2020-03-23 22:22:41',	0),
(12,	'Where did you go to on your first vacation?',	'Où êtes-vous allé lors de vos premières vacances?',	'2018-08-01 13:22:57',	'2018-08-01 21:22:57',	1);

INSERT INTO `SourceDatabase` (`SourceDatabaseSerNum`, `SourceDatabaseName`, `Enabled`) VALUES
(-1,	'Local',	1);

-- Insert the initial data required to run the cronjob.
INSERT INTO `Cron` (`CronSerNum`, `NextCronDate`, `RepeatUnits`, `NextCronTime`, `RepeatInterval`, `LastCron`)  VALUES
('1', '2023-06-06', 'Minutes', '11:53:06', '3', '2023-06-06 11:53:25');
