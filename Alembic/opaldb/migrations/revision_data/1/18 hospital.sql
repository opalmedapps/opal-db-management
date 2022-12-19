CREATE TABLE IF NOT EXISTS `HospitalMap` (
  `HospitalMapSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `MapUrl` varchar(255) DEFAULT NULL,
  `MapURL_EN` varchar(512) DEFAULT NULL,
  `MapURL_FR` varchar(512) DEFAULT NULL,
  `QRMapAlias` varchar(255) DEFAULT NULL,
  `QRImageFileName` varchar(255) NOT NULL,
  `MapName_EN` varchar(255) DEFAULT NULL,
  `MapDescription_EN` varchar(255) DEFAULT NULL,
  `MapName_FR` varchar(255) DEFAULT NULL,
  `MapDescription_FR` varchar(255) DEFAULT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`HospitalMapSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `HospitalMap_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `HospitalMapMH` (
  `HospitalMapSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `MapUrl` varchar(255) DEFAULT NULL,
  `MapURL_EN` varchar(512) DEFAULT NULL,
  `MapURL_FR` varchar(512) DEFAULT NULL,
  `QRMapAlias` varchar(255) DEFAULT NULL,
  `QRImageFileName` varchar(255) NOT NULL,
  `MapName_EN` varchar(255) DEFAULT NULL,
  `MapDescription_EN` varchar(255) DEFAULT NULL,
  `MapName_FR` varchar(255) DEFAULT NULL,
  `MapDescription_FR` varchar(255) DEFAULT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`HospitalMapSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
