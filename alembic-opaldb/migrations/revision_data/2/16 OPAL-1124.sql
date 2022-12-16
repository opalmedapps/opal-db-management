CREATE TABLE `cronControlPatient_Document` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPatientSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
	`transferFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	`lastTransferred` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` (`cronControlPatientSerNum`) USING BTREE,
	CONSTRAINT `fk_cronContPatient_Doc_cronContPSerNum_Patient_PatientSerNum` FOREIGN KEY (`cronControlPatientSerNum`) REFERENCES `OpalDB`.`PatientControl` (`PatientSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
ENGINE=InnoDB
;
CREATE TABLE `cronControlPatient_EducationalMaterial` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPatientSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
	`transferFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	`lastTransferred` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` (`cronControlPatientSerNum`) USING BTREE,
	CONSTRAINT `fk_cronContPatient_Edu_cronContPSerNum_Patient_PatientSerNum` FOREIGN KEY (`cronControlPatientSerNum`) REFERENCES `OpalDB`.`PatientControl` (`PatientSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
ENGINE=InnoDB
;
CREATE TABLE `cronControlPatient_Announcement` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPatientSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
	`transferFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	`lastTransferred` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` (`cronControlPatientSerNum`) USING BTREE,
	CONSTRAINT `fk_cronContPatient_Anno_cronContPSerNum_Patient_PatientSerNum` FOREIGN KEY (`cronControlPatientSerNum`) REFERENCES `OpalDB`.`PatientControl` (`PatientSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
ENGINE=InnoDB
;
CREATE TABLE `cronControlPatient_LegacyQuestionnaire` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPatientSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
	`transferFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	`lastTransferred` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` (`cronControlPatientSerNum`) USING BTREE,
	CONSTRAINT `fk_cronContPatient_LegQ_cronContPSerNum_Patient_PatientSerNum` FOREIGN KEY (`cronControlPatientSerNum`) REFERENCES `OpalDB`.`PatientControl` (`PatientSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
ENGINE=InnoDB
;
CREATE TABLE `cronControlPatient_PatientsForPatients` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPatientSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
	`transferFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	`lastTransferred` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` (`cronControlPatientSerNum`) USING BTREE,
	CONSTRAINT `fk_cronContPatient_PFP_cronContPSerNum_Patient_PatientSerNum` FOREIGN KEY (`cronControlPatientSerNum`) REFERENCES `OpalDB`.`PatientControl` (`PatientSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
ENGINE=InnoDB
;
CREATE TABLE `cronControlPatient_TreatmentTeamMessage` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPatientSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
	`transferFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	`lastTransferred` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` (`cronControlPatientSerNum`) USING BTREE,
	CONSTRAINT `fk_cronContPatient_Treat_cronContPSerNum_Patient_PatientSerNum` FOREIGN KEY (`cronControlPatientSerNum`) REFERENCES `OpalDB`.`PatientControl` (`PatientSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
ENGINE=InnoDB
;
