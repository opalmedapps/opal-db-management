CREATE TABLE IF NOT EXISTS `EmailControl` (
  `EmailControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Subject_EN` varchar(100) NOT NULL,
  `Subject_FR` varchar(100) NOT NULL,
  `Body_EN` text NOT NULL,
  `Body_FR` text NOT NULL,
  `EmailTypeSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EmailControlSerNum`),
  KEY `EmailTypeSerNum` (`EmailTypeSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `EmailControl_ibfk_1` FOREIGN KEY (`EmailTypeSerNum`) REFERENCES `EmailType` (`EmailTypeSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EmailControl_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EmailControlMH` (
  `EmailControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Subject_EN` varchar(100) NOT NULL,
  `Subject_FR` varchar(100) NOT NULL,
  `Body_EN` text NOT NULL,
  `Body_FR` text NOT NULL,
  `EmailTypeSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EmailControlSerNum`,`RevSerNum`),
  KEY `EmailTypeSerNum` (`EmailTypeSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EmailLog` (
  `EmailLogSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `EmailControlSerNum` int(11) NOT NULL,
  `Status` varchar(5) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EmailLogSerNum`),
  KEY `EmailControlSerNum` (`EmailControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  CONSTRAINT `EmailLog_ibfk_1` FOREIGN KEY (`EmailControlSerNum`) REFERENCES `EmailControl` (`EmailControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EmailLog_ibfk_2` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EmailLog_ibfk_3` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EmailLogMH` (
  `EmailLogSerNum` int(11) NOT NULL,
  `EmailLogRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `EmailControlSerNum` int(11) NOT NULL,
  `Status` varchar(5) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  PRIMARY KEY (`EmailLogSerNum`,`EmailLogRevSerNum`),
  KEY `EmailControlSerNum` (`EmailControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `EmailType` (
  `EmailTypeSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EmailTypeId` varchar(100) NOT NULL,
  `EmailTypeName` varchar(200) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EmailTypeSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
