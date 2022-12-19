CREATE TABLE IF NOT EXISTS `customPushNotificationLog` (
  `customPushNotificationID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` bigint(20) NOT NULL,
  `PatientDeviceIdentifierSerNum` bigint(20) NOT NULL,
  `SendStatus` varchar(3) NOT NULL,
  `NotificationTitle` varchar(100) NOT NULL,
  `NotificationMSG` text NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`customPushNotificationID`),
  KEY `idx_PatientSerNum` (`PatientSerNum`),
  KEY `idx_DateAdded` (`DateAdded`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Notification` (
  `NotificationSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `NotificationControlSerNum` int(11) NOT NULL,
  `RefTableRowSerNum` int(11) NOT NULL,
  `DateAdded` datetime DEFAULT NULL,
  `ReadStatus` tinyint(1) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `RefTableRowTitle_EN` varchar(500) NOT NULL,
  `RefTableRowTitle_FR` varchar(500) NOT NULL,
  PRIMARY KEY (`NotificationSerNum`),
  KEY `NotificationControlSerNum` (`NotificationControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `RefTableRowSerNum` (`RefTableRowSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `Notification_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Notification_ibfk_2` FOREIGN KEY (`NotificationControlSerNum`) REFERENCES `NotificationControl` (`NotificationControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Notification_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `NotificationControl` (
  `NotificationControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(100) NOT NULL,
  `Name_FR` varchar(100) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_FR` text NOT NULL,
  `NotificationType` varchar(100) NOT NULL,
  `NotificationTypeSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastPublished` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`NotificationControlSerNum`),
  KEY `NotificationTypeSerNum` (`NotificationTypeSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `NotificationControl_ibfk_1` FOREIGN KEY (`NotificationTypeSerNum`) REFERENCES `NotificationTypes` (`NotificationTypeSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `NotificationControl_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `NotificationControlMH` (
  `NotificationControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(100) NOT NULL,
  `Name_FR` varchar(100) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_FR` text NOT NULL,
  `NotificationTypeSerNum` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`NotificationControlSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `NotificationMH` (
  `NotificationSerNum` int(11) NOT NULL,
  `NotificationRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `NotificationControlSerNum` int(11) NOT NULL,
  `RefTableRowSerNum` int(11) NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `RefTableRowTitle_EN` varchar(500) NOT NULL,
  `RefTableRowTitle_FR` varchar(500) NOT NULL,
  PRIMARY KEY (`NotificationSerNum`,`NotificationRevSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `NotificationControlSerNum` (`NotificationControlSerNum`),
  KEY `RefTableRowSerNum` (`RefTableRowSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `NotificationTypes` (
  `NotificationTypeSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `NotificationTypeId` varchar(100) NOT NULL,
  `NotificationTypeName` varchar(200) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`NotificationTypeSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `PatientsForPatients` (
  `PatientsForPatientsSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientsForPatientsSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `PatientsForPatients_ibfk_1` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientsForPatients_ibfk_2` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientsForPatients_ibfk_3` FOREIGN KEY (`PostControlSerNum`) REFERENCES `PostControl` (`PostControlSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `PatientsForPatientsMH` (
  `PatientsForPatientsSerNum` int(11) NOT NULL,
  `PatientsForPatientsRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientsForPatientsSerNum`,`PatientsForPatientsRevSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostControlSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `PostControl` (
  `PostControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PostType` varchar(100) NOT NULL,
  `PublishFlag` int(11) NOT NULL DEFAULT 0,
  `PostName_FR` varchar(100) NOT NULL,
  `PostName_EN` varchar(100) NOT NULL,
  `Body_FR` text NOT NULL,
  `Body_EN` text NOT NULL,
  `PublishDate` datetime DEFAULT NULL,
  `Disabled` tinyint(1) NOT NULL DEFAULT 0,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PostControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `PostControl_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `PostControlMH` (
  `PostControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PostType` varchar(100) NOT NULL,
  `PublishFlag` int(11) NOT NULL DEFAULT 0,
  `PostName_FR` varchar(100) NOT NULL,
  `PostName_EN` varchar(100) NOT NULL,
  `Body_FR` text NOT NULL,
  `Body_EN` text NOT NULL,
  `PublishDate` datetime DEFAULT NULL,
  `Disabled` tinyint(1) NOT NULL DEFAULT 0,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PostControlSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `publicationSetting` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name_EN` varchar(512) NOT NULL COMMENT 'English name of the setting',
  `name_FR` varchar(512) NOT NULL COMMENT 'French name of the setting',
  `internalName` varchar(512) NOT NULL COMMENT 'Name of the field for the triggers when processing the data on the backend and frontend',
  `isTrigger` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the setting a trigger (1) or something else (0)',
  `isUnique` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the setting can have only one unique value (1) or not (0)',
  `selectAll` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Can the setting (mostly a trigger) has an "All" (1) value or not (0)',
  `opalDB` mediumtext NOT NULL COMMENT 'SQL or table name from the OpalDB to get or insert the data. Note: if the ariaDB field is filled, it must be run before this one.',
  `opalPK` varchar(512) NOT NULL COMMENT 'Primary key used for the OpalDB field',
  `custom` mediumtext NOT NULL COMMENT 'This field contains JSON format data for custom settings (like for age and sex for example)',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table list all the different settings a publication can have.';

CREATE TABLE IF NOT EXISTS `PushNotification` (
  `PushNotificationSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientDeviceIdentifierSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `NotificationControlSerNum` int(11) NOT NULL,
  `RefTableRowSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `SendStatus` varchar(3) NOT NULL,
  `SendLog` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PushNotificationSerNum`),
  KEY `PatientDeviceIdentifierSerNum` (`PatientDeviceIdentifierSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `NotificationControlSerNum` (`NotificationControlSerNum`),
  KEY `RefTableRowSerNum` (`RefTableRowSerNum`),
  CONSTRAINT `PushNotification_ibfk_3` FOREIGN KEY (`PatientDeviceIdentifierSerNum`) REFERENCES `PatientDeviceIdentifier` (`PatientDeviceIdentifierSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `TxTeamMessage` (
  `TxTeamMessageSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TxTeamMessageSerNum`),
  KEY `PostSerNum` (`PostControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `TxTeamMessage_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TxTeamMessage_ibfk_2` FOREIGN KEY (`PostControlSerNum`) REFERENCES `PostControl` (`PostControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TxTeamMessage_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `TxTeamMessageMH` (
  `TxTeamMessageSerNum` int(11) NOT NULL,
  `TxTeamMessageRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TxTeamMessageSerNum`,`TxTeamMessageRevSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PatientControlSerNum` (`PostControlSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
