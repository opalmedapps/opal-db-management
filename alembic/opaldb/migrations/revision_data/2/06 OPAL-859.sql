INSERT INTO module (ID, name_EN, name_FR,description_EN,description_FR,tableName,controltableName,primaryKey,iconClass
,url,active,categoryModuleId,publication,`order`,sqlPublicationList,sqlDetails,sqlPublicationChartLog,
sqlPublicationListLog,sqlPublicationMultiple,sqlPublicationUnique,`operation`)
VALUES (22, "SMS","SMS","Manage the sms appointments","Gestion des rendez-vous de sms","SmsAppointment","SmsAppointment",
"SmsAppointmentId","glyphicon glyphicon-phone","sms",1,2,-1,20,"","","","","","", "3");

INSERT INTO oaRoleModule(moduleId,oaRoleID,access)
VALUES(22,1,3);
