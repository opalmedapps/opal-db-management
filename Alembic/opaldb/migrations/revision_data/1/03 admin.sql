CREATE TABLE IF NOT EXISTS `Admin` (
  `AdminSerNum` int(11) NOT NULL,
  `ResourceSerNum` int(11) NOT NULL,
  `FirstName` text NOT NULL,
  `LastName` text NOT NULL,
  `Email` text NOT NULL,
  `Phone` bigint(20) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  KEY `ResourceSerNum` (`ResourceSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `OAActivityLog` (
  `ActivitySerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Activity` varchar(255) NOT NULL,
  `OAUserSerNum` int(11) NOT NULL,
  `SessionId` varchar(255) NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`ActivitySerNum`),
  KEY `OAUserSerNum` (`OAUserSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `oaRole` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment',
  `name_EN` varchar(64) NOT NULL COMMENT 'English name of the role',
  `name_FR` varchar(64) NOT NULL COMMENT 'French name of the role',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT 'has the data being deleted or not',
  `deletedBy` varchar(255) NOT NULL COMMENT 'username of who marked the record to be deleted',
  `creationDate` datetime NOT NULL COMMENT 'Date of creation of the record',
  `createdBy` varchar(255) NOT NULL COMMENT 'username of who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last time the record was updated',
  `updatedBy` varchar(255) NOT NULL COMMENT 'username of who updated the record',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `oaRoleModule` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment',
  `moduleId` bigint(20) NOT NULL COMMENT 'Module ID',
  `oaRoleId` bigint(20) NOT NULL COMMENT 'OA Role ID',
  `access` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Access level level (0-7) for this role on this module',
  PRIMARY KEY (`ID`),
  KEY `fk_oaRoleModule_oaRoleId_oaRole_ID_idx` (`oaRoleId`),
  KEY `fk_oaRoleModule_moduleId_module_ID_idx` (`moduleId`),
  CONSTRAINT `fk_oaRoleModule_moduleId_module_ID` FOREIGN KEY (`moduleId`) REFERENCES `module` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_oaRoleModule_oaRoleId_oaRole_ID` FOREIGN KEY (`oaRoleId`) REFERENCES `oaRole` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `OAUser` (
  `OAUserSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(1000) NOT NULL,
  `Password` varchar(1000) NOT NULL,
  `oaRoleId` bigint(20) NOT NULL DEFAULT 1 COMMENT 'Role of the user',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Type of user. 1 = ''human'' user. 2 = ''system'' user',
  `Language` enum('EN','FR') NOT NULL DEFAULT 'EN',
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`OAUserSerNum`),
  KEY `fk_OAUser_oaRoleId_oaRole_ID` (`oaRoleId`),
  CONSTRAINT `fk_OAUser_oaRoleId_oaRole_ID` FOREIGN KEY (`oaRoleId`) REFERENCES `oaRole` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `OAUserRole` (
  `OAUserSerNum` int(11) NOT NULL,
  `RoleSerNum` int(11) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`OAUserSerNum`,`RoleSerNum`),
  KEY `OAUserSerNum` (`OAUserSerNum`),
  KEY `RoleSerNum` (`RoleSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Role` (
  `RoleSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`RoleSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
