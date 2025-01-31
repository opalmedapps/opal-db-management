CREATE TABLE IF NOT EXISTS `Filters` (
  `FilterSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `ControlTable` varchar(100) NOT NULL,
  `ControlTableSerNum` int(11) NOT NULL,
  `FilterType` varchar(100) NOT NULL,
  `FilterId` varchar(150) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`FilterSerNum`),
  KEY `FilterTableSerNum` (`ControlTableSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `FiltersMH` (
  `FilterSerNum` int(11) NOT NULL,
  `ControlTable` varchar(100) NOT NULL,
  `ControlTableSerNum` int(11) NOT NULL,
  `FilterType` varchar(100) NOT NULL,
  `FilterId` varchar(150) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  KEY `FilterTableSerNum` (`ControlTableSerNum`),
  KEY `FilterSerNum` (`FilterSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `FrequencyEvents` (
  `ControlTable` varchar(50) NOT NULL,
  `ControlTableSerNum` int(11) NOT NULL,
  `MetaKey` varchar(50) NOT NULL,
  `MetaValue` varchar(150) NOT NULL,
  `CustomFlag` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `ControlTable` (`ControlTable`,`ControlTableSerNum`,`MetaKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
