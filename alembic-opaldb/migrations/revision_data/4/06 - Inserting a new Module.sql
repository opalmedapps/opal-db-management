-- Moving the buttons around by having the Patient Admin button in position 13
UPDATE module m SET m.`order` = m.`order` + 1 WHERE m.`order` > 12;

-- Inserting new module for the Patient Admin Role
INSERT IGNORE INTO module (operation, name_EN, name_FR, description_EN, description_FR, tableName, controlTableName, primaryKey, 
iconClass, url, active,categoryModuleId, `order`, sqlPublicationList, sqlDetails, sqlPublicationChartLog, 
sqlPublicationListLog, sqlPublicationMultiple, sqlPublicationUnique) VALUES (3, 'Patient Administration', 
'Administration des patients', 'Manage the patient account information', 'Gérer les informations du compte patient', '','','',
'fa fa-user-circle', 'patient-administration', 1, 2, 13, '', '', '','','','');

-- Giving Admin users access to the Patient Admin Role
INSERT IGNORE INTO oaRoleModule (moduleId, oaRoleId, access) VALUES (23,1,3);