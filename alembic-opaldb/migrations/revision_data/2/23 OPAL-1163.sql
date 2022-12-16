DROP TABLE IF EXISTS `cronControlPost`;
DROP TABLE IF EXISTS `cronControlPatient_Document`;
DROP TABLE IF EXISTS `cronControlPatient_PatientsForPatients`;

CREATE TABLE `cronControlPost_TreatmentTeamMessage` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPostSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PostControlSerNum from PostControl. Mandatory.',
	`publishFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that has been published from opalAdmin.',
	`lastPublished` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last publish date.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	`sessionId` VARCHAR(255) NULL DEFAULT NULL COMMENT 'SessionId of the user who last updated this field.' COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPost_cronContPostSerNum_PostControl_PostControlSerNum` (`cronControlPostSerNum`) USING BTREE,
	INDEX `publishFlag` (`publishFlag`) USING BTREE,
	CONSTRAINT `fk_cronContPost_Treat_cronContPSerNum_PostControl_PostContSerNum` FOREIGN KEY (`cronControlPostSerNum`) REFERENCES `OpalDB`.`PostControl` (`PostControlSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

CREATE TABLE `cronControlPost_Announcement` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`cronControlPostSerNum` INT(11) NOT NULL COMMENT 'Foreign key with PostControlSerNum from PostControl. Mandatory.',
	`publishFlag` SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that has been published from opalAdmin.',
	`lastPublished` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last publish date.',
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	`sessionId` VARCHAR(255) NULL DEFAULT NULL COMMENT 'SessionId of the user who last updated this field.' COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `fk_cronContPost_cronContPostSerNum_PostControl_PostControlSerNum` (`cronControlPostSerNum`) USING BTREE,
	INDEX `publishFlag` (`publishFlag`) USING BTREE,
	CONSTRAINT `fk_cronContPost_Anno_cronContPSerNum_PostControl_PostContSerNum` FOREIGN KEY (`cronControlPostSerNum`) REFERENCES `OpalDB`.`PostControl` (`PostControlSerNum`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;