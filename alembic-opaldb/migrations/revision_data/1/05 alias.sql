CREATE TABLE IF NOT EXISTS `Alias` (
  `AliasSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasType` varchar(25) NOT NULL,
  `AliasUpdate` int(11) NOT NULL,
  `AliasName_FR` varchar(100) NOT NULL,
  `AliasName_EN` varchar(100) NOT NULL,
  `AliasDescription_FR` text NOT NULL,
  `AliasDescription_EN` text NOT NULL,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `HospitalMapSerNum` int(11) DEFAULT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 1,
  `ColorTag` varchar(25) NOT NULL DEFAULT '#777777',
  `WaitTimeValidity` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'This field exist in DEV. Usage is unknow',
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AliasSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `HospitalMapSerNum` (`HospitalMapSerNum`),
  CONSTRAINT `Alias_ibfk_1` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Alias_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Alias_ibfk_3` FOREIGN KEY (`HospitalMapSerNum`) REFERENCES `HospitalMap` (`HospitalMapSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `AliasExpression` (
  `AliasExpressionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasSerNum` int(11) NOT NULL DEFAULT 0,
  `ExpressionName` varchar(250) NOT NULL,
  `Description` varchar(250) NOT NULL COMMENT 'Resource Description',
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AliasExpressionSerNum`),
  UNIQUE KEY `ExpressionName_Description` (`ExpressionName`,`Description`),
  KEY `AliasSerNum` (`AliasSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `AliasExpression_ibfk_4` FOREIGN KEY (`AliasSerNum`) REFERENCES `Alias` (`AliasSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `AliasExpression_ibfk_5` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `AliasExpressionMH` (
  `AliasSerNum` int(11) NOT NULL DEFAULT 0,
  `ExpressionName` varchar(250) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ExpressionName`,`Description`,`RevSerNum`),
  KEY `AliasSerNum` (`AliasSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `AliasMH` (
  `AliasSerNum` int(11) NOT NULL,
  `AliasRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasType` varchar(25) NOT NULL,
  `AliasUpdate` int(11) NOT NULL,
  `AliasName_FR` varchar(100) NOT NULL,
  `AliasName_EN` varchar(100) NOT NULL,
  `AliasDescription_FR` text NOT NULL,
  `AliasDescription_EN` text NOT NULL,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `HospitalMapSerNum` int(11) DEFAULT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 1,
  `ColorTag` varchar(25) NOT NULL DEFAULT '#777777',
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`AliasSerNum`,`AliasRevSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `AllowableExtension` (
  `Type` enum('video','website','pdf','image') NOT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Type`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
