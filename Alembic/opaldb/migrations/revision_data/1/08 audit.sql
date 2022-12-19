CREATE TABLE IF NOT EXISTS `audit` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `module` varchar(128) NOT NULL COMMENT 'Name of the module the user accessed',
  `method` varchar(128) NOT NULL COMMENT 'Name of the method in the module the user activated',
  `argument` longtext NOT NULL COMMENT 'Arguments (if any) passed to the method called.',
  `access` varchar(16) NOT NULL COMMENT 'If the access to the user was GRANTED or DENIED',
  `ipAddress` varchar(64) NOT NULL COMMENT 'IP address of the user',
  `creationDate` datetime NOT NULL COMMENT 'Date of the user request',
  `createdBy` varchar(128) NOT NULL COMMENT 'Username of the user who made the request',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
