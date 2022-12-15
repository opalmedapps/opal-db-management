/* dbv_opaldb/data/revisions/1/ */

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_login` AS select `OAUser`.`OAUserSerNum` AS `id`,`OAUser`.`Username` AS `username`,`OAUser`.`Password` AS `password`,`OAUser`.`Language` AS `language`,`OAUser`.`oaRoleId` AS `role`,`OAUser`.`type` AS `type` from `OAUser` ;

CREATE EVENT `evt_DatabaseMaintenance`
	ON SCHEDULE
		EVERY 1 DAY STARTS '2021-01-01 23:50:00'
	ON COMPLETION NOT PRESERVE
	ENABLE
	COMMENT ''
	DO BEGIN

-- Clean up the Patient Device Identifier table
call proc_CleanPatientDeviceIdentifier;

END;

/* dbv_opaldb/data/revisions/2/ */

/* dbv_opaldb/data/revisions/3/ */

/* dbv_opaldb/data/revisions/4/ */

/* dbv_opaldb/data/revisions/5/ */

/* dbv_opaldb/data/revisions/6/ */

/* dbv_opaldb/data/revisions/7/ */

/* dbv_opaldb/data/revisions/8/ */

/* dbv_opaldb/data/revisions/9/ */

/* dbv_opaldb/data/revisions/10/ */

/* dbv_opaldb/data/revisions/11/ */