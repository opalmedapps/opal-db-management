CREATE TABLE IF NOT EXISTS cronControlPatient (
	ID BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	cronControlPatientSerNum INT(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
	cronType VARCHAR(100) NOT NULL COMMENT 'Field refers to what cron controller is using this transfer flag. eg TxTeamMessage, Document, Announcement, etc. Mandatory',
	transferFlag SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	lastTransferred DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	lastUpdated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ID),
	CONSTRAINT fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum FOREIGN KEY (cronControlPatientSerNum) REFERENCES PatientControl(PatientSerNum)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE IF NOT EXISTS cronControlAlias (
	ID BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	cronControlAliasSerNum INT(11) NOT NULL COMMENT 'Foreign key with AliasSerNum from Alias. Mandatory.',
	cronType VARCHAR(100) NOT NULL COMMENT 'Field refers to what cron controller is using this transfer flag. eg TxTeamMessages, Document, Announcement, etc. Mandatory',
	aliasUpdate SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that needs to be read on next cron.',
	lastTransferred DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
	lastUpdated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	sessionId VARCHAR(255) COMMENT 'SessionId of the user who last updated this field.',
	PRIMARY KEY (ID),
	CONSTRAINT fk_cronContAlias_cronContAliasSerNum_Alias_AliasSerNum FOREIGN KEY (cronControlAliasSerNum) REFERENCES Alias(AliasSerNum)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE IF NOT EXISTS cronControlPost (
	ID BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	cronControlPostSerNum INT(11) NOT NULL COMMENT 'Foreign key with PostControlSerNum from PostControl. Mandatory.',
	cronType VARCHAR(100) NOT NULL COMMENT 'Field refers to what cron controller is using this transfer flag. eg TxTeamMessages, Document, Announcement, etc. Mandatory',
	publishFlag SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that has been published from opalAdmin.',
	lastPublished DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last publish date.',
	lastUpdated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	sessionId VARCHAR(255) COMMENT 'SessionId of the user who last updated this field.',
	PRIMARY KEY (ID),
	CONSTRAINT fk_cronContPost_cronContPostSerNum_PostControl_PostControlSerNum FOREIGN KEY (cronControlPostSerNum) REFERENCES PostControl(PostControlSerNum)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;

CREATE TABLE IF NOT EXISTS cronControlEducationalMaterial (
	ID BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	cronControlEducationalMaterialControlSerNum INT(11) NOT NULL COMMENT 'Foreign key with EducMatControlSerNum from EMC. Mandatory.',
	publishFlag SMALLINT(6) NOT NULL DEFAULT '0' COMMENT 'Marker for data that has been published from opalAdmin.',
	lastPublished DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last publish date.',
	lastUpdated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	sessionId VARCHAR(255) COMMENT 'SessionId of the user who last updated this field.',
	PRIMARY KEY (ID),
	CONSTRAINT fk_cronContEM_cronContEMCSerNum_EMC_EMCSerNum FOREIGN KEY (cronControlEducationalMaterialControlSerNum) REFERENCES EducationalMaterialControl(EducationalMaterialControlSerNum)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
