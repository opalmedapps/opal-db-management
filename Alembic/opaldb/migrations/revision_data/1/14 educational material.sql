CREATE TABLE IF NOT EXISTS `EducationalMaterial` (
  `EducationalMaterialSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialSerNum`),
  KEY `EducationalMaterialSerNum` (`EducationalMaterialControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `EducationalMaterial_ibfk_2` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EducationalMaterial_ibfk_3` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EducationalMaterial_ibfk_4` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EducationalMaterialControl` (
  `EducationalMaterialControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialType_EN` varchar(100) NOT NULL,
  `EducationalMaterialType_FR` varchar(100) NOT NULL,
  `PublishFlag` int(11) NOT NULL DEFAULT 0,
  `Name_EN` varchar(200) NOT NULL,
  `Name_FR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `URL_EN` varchar(2000) DEFAULT NULL,
  `URL_FR` varchar(2000) DEFAULT NULL,
  `URLType_EN` varchar(100) DEFAULT NULL,
  `URLType_FR` varchar(100) DEFAULT NULL,
  `ShareURL_EN` varchar(2000) DEFAULT NULL,
  `ShareURL_FR` varchar(2000) DEFAULT NULL,
  `PhaseInTreatmentSerNum` int(11) NOT NULL,
  `ParentFlag` int(11) NOT NULL DEFAULT 1,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EducationalMaterialControlSerNum`),
  KEY `PhaseInTreatmentSerNum` (`PhaseInTreatmentSerNum`),
  CONSTRAINT `EducationalMaterialControl_ibfk_1` FOREIGN KEY (`PhaseInTreatmentSerNum`) REFERENCES `PhaseInTreatment` (`PhaseInTreatmentSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EducationalMaterialMH` (
  `EducationalMaterialSerNum` int(11) NOT NULL,
  `EducationalMaterialRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialSerNum`,`EducationalMaterialRevSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EducationalMaterialPackageContent` (
  `EducationalMaterialPackageContentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) NOT NULL COMMENT 'Material contained in a package.',
  `OrderNum` int(11) NOT NULL COMMENT 'Position of the material in the package, starting at 1.',
  `ParentSerNum` int(11) NOT NULL COMMENT 'EducationalMaterialControlSerNum of the parent package.',
  `DateAdded` datetime NOT NULL,
  `AddedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `LastUpdatedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`EducationalMaterialPackageContentSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `ParentSerNum` (`ParentSerNum`),
  KEY `LastUpdated` (`LastUpdated`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Directory of each material that is contained in an educational material package. No foreign keys to facilitate order changes.';

CREATE TABLE IF NOT EXISTS `EducationalMaterialRating` (
  `EducationalMaterialRatingSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `RatingValue` tinyint(6) NOT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialRatingSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EducationalMaterialTOC` (
  `EducationalMaterialTOCSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `OrderNum` int(11) NOT NULL,
  `ParentSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialTOCSerNum`),
  KEY `EducationalMaterialSerNum` (`EducationalMaterialControlSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
