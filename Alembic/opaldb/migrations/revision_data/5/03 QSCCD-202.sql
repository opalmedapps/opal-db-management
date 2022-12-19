-- Insert into module Hospital Settings
INSERT IGNORE INTO module (ID, operation, name_EN, name_FR, description_EN, description_FR, tableName, controlTableName, primaryKey, iconClass, `url`, subModule, subModuleMenu, core, active, categoryModuleId, publication, customCode, `unique`, `order`, sqlPublicationList, sqlDetails, sqlPublicationChartLog, sqlPublicationListLog, sqlPublicationMultiple, sqlPublicationUnique)
	VALUES ('24', '3', 'Hospital Settings', 'Paramètres de l\'hôpital', 'Manage hospital settings.', 'Gérer les paramètres de configuration de l\'hôpital', '', '', '', 'fa fa-wrench', 'hospital-settings', '', '0', '1', '1', '1', '0', '0', '1', '22', '', '', '', '', '', '');

INSERT IGNORE INTO oaRoleModule (moduleId, oaRoleId, access) VALUES ('24', '1', '3');
