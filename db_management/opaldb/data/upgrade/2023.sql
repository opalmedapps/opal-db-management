-- Upgrade script to upgrade from the latest version (January 2022) at the MUHC to the new version (TBD in 2023)

-- Upgrade modules

-- Insert Hospital Settings and Clinician Dashboard
INSERT INTO `module` (`ID`, `operation`, `name_EN`, `name_FR`, `description_EN`, `description_FR`, `tableName`, `controlTableName`, `primaryKey`, `iconClass`, `url`, `subModule`, `subModuleMenu`, `core`, `active`, `categoryModuleId`, `publication`, `customCode`, `unique`, `order`, `sqlPublicationList`, `sqlDetails`, `sqlPublicationChartLog`, `sqlPublicationListLog`, `sqlPublicationMultiple`, `sqlPublicationUnique`) VALUES
(24,	3,	'Hospital Settings',	'Paramètres de l\'hôpital',	'Manage hospital settings.',	'Gérer les paramètres de configuration de l\'hôpital.',	'',	'',	'',	'fa fa-wrench',	'hospital-settings',	'',	0,	1,	1,	1,	0,	0,	1,	22,	'',	'',	'',	'',	'',	''),
(25,	3,	'Clinician Dashboard',	'Tableau de bord du clinicien',	'Clinician Dashboard Tools.',	'Outils du tableau de bord du clinicien.',	'',	'',	'',	'fa fa-user-md',	'clinician',	'',	0,	1,	1,	1,	0,	0,	1,	21,	'',	'',	'',	'',	'',	'');

-- Add Clinician Dashboard and Hospital Settings to System Administrator
INSERT INTO `oaRoleModule` (`moduleId`, `oaRoleId`, `access`) VALUES
(24, 36, 3),
(25, 36, 3);

-- TODO: add pathology aliasing
-- TODO: add databank consent form
