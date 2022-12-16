CREATE TABLE IF NOT EXISTS `Diagnosis` (
  `DiagnosisSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DiagnosisAriaSer` varchar(32) NOT NULL,
  `DiagnosisCode` varchar(50) NOT NULL,
  `Description_EN` varchar(200) NOT NULL,
  `Description_FR` varchar(255) NOT NULL,
  `Stage` varchar(32) DEFAULT NULL,
  `StageCriteria` varchar(32) DEFAULT NULL,
  `CreationDate` datetime NOT NULL,
  `createdBy` varchar(128) NOT NULL DEFAULT 'CronJob',
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(128) NOT NULL DEFAULT 'CronJob',
  PRIMARY KEY (`DiagnosisSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `DiagnosisAriaSer` (`DiagnosisAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  CONSTRAINT `Diagnosis_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `DiagnosisCode` (
  `DiagnosisCodeSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `DiagnosisTranslationSerNum` int(11) NOT NULL,
  `SourceUID` int(11) NOT NULL,
  `Source` int(6) NOT NULL DEFAULT -1,
  `DiagnosisCode` varchar(100) NOT NULL,
  `Description` varchar(2056) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`DiagnosisCodeSerNum`),
  UNIQUE KEY `SourceUID` (`SourceUID`),
  KEY `DiagnosisTranslationSerNum` (`DiagnosisTranslationSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `DiagnosisCode` (`DiagnosisCode`),
  KEY `DiagnosisCode_ibfk_3` (`Source`),
  CONSTRAINT `DiagnosisCode_ibfk_1` FOREIGN KEY (`DiagnosisTranslationSerNum`) REFERENCES `DiagnosisTranslation` (`DiagnosisTranslationSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `DiagnosisCode_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `DiagnosisCode_ibfk_3` FOREIGN KEY (`Source`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `DiagnosisCodeMH` (
  `DiagnosisTranslationSerNum` int(11) NOT NULL,
  `SourceUID` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `DiagnosisCode` varchar(100) NOT NULL,
  `Description` varchar(2056) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SourceUID`,`RevSerNum`),
  KEY `DiagnosisTranslationSerNum` (`DiagnosisTranslationSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `DiagnosisMH` (
  `DiagnosisSerNum` int(11) NOT NULL,
  `RevisionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(128) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DiagnosisAriaSer` varchar(32) NOT NULL,
  `DiagnosisCode` varchar(50) NOT NULL,
  `Description_EN` varchar(200) NOT NULL,
  `Description_FR` varchar(255) NOT NULL,
  `Stage` varchar(32) DEFAULT NULL,
  `StageCriteria` varchar(32) DEFAULT NULL,
  `CreationDate` datetime NOT NULL,
  `createdBy` varchar(128) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(128) NOT NULL,
  PRIMARY KEY (`DiagnosisSerNum`,`RevisionSerNum`) USING BTREE,
  KEY `updatedBy` (`updatedBy`) USING BTREE,
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `DiagnosisAriaSer` (`DiagnosisAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `DiagnosisTranslation` (
  `DiagnosisTranslationSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasName` varchar(100) NOT NULL,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `Name_EN` varchar(2056) NOT NULL,
  `Name_FR` varchar(2056) NOT NULL,
  `Description_EN` varchar(2056) NOT NULL,
  `Description_FR` varchar(2056) NOT NULL,
  `DiagnosisCode` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DiagnosisTranslationSerNum`),
  KEY `DiagnosisCode` (`DiagnosisCode`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  CONSTRAINT `DiagnosisTranslation_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `DiagnosisTranslation_ibfk_2` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `DiagnosisTranslationMH` (
  `DiagnosisTranslationSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `Name_EN` varchar(2056) NOT NULL,
  `Name_FR` varchar(2056) NOT NULL,
  `Description_EN` varchar(2056) NOT NULL,
  `Description_FR` varchar(2056) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DiagnosisTranslationSerNum`,`RevSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE FUNCTION `getDiagnosisDescription`(`in_DiagnosisCode` VARCHAR(100),
	`in_Language` VARCHAR(2)

) RETURNS varchar(2056) CHARSET latin1
    DETERMINISTIC
    COMMENT 'Return the description of the Diagnosis Code'
BEGIN
Declare wsReturn varchar(2056);
Declare wsLanguage varchar(2);
Declare wsDiagnosisCode varchar(100);


	set wsLanguage = in_Language;
	set wsDiagnosisCode = in_DiagnosisCode;

	if (wsLanguage = 'EN') then

		set wsReturn  = (select DT.Name_EN from DiagnosisCode DC, DiagnosisTranslation DT
			where DC.DiagnosisTranslationSerNum = DT.DiagnosisTranslationSerNum
				and DC.DiagnosisCode = in_DiagnosisCode
			limit 1);

	else

		set wsReturn  = (select DT.Name_FR from DiagnosisCode DC, DiagnosisTranslation DT
			where DC.DiagnosisTranslationSerNum = DT.DiagnosisTranslationSerNum
				and DC.DiagnosisCode = in_DiagnosisCode
			limit 1);

	end if;

	set wsReturn = (IfNull(wsReturn, 'N/A'));

	return wsReturn;
END;
