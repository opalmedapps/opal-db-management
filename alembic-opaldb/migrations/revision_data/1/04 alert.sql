CREATE TABLE IF NOT EXISTS `alert` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key, auto-increment',
  `contact` mediumtext NOT NULL COMMENT 'list of contacts for the alert. JSON format field that contains phone number and email.',
  `subject` mediumtext NOT NULL COMMENT 'Subject of the alert. Should be plain text, no html.',
  `body` mediumtext NOT NULL COMMENT 'Body of the alert message. Plain text, no html.',
  `trigger` mediumtext NOT NULL COMMENT 'List of conditions to trigger the alert. JSON format.',
  `active` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the alert active (equals to 0) or not (equals to 1). By default, inactive.',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT ' 0 = not deleted, 1 = deleted',
  `deletedBy` varchar(128) NOT NULL COMMENT 'Username of the person who deleted the record',
  `creationDate` datetime NOT NULL COMMENT 'Date and time of creation of the record',
  `createdBy` varchar(128) NOT NULL COMMENT 'Username of the person who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date and time of last update of the record',
  `updatedBy` varchar(128) NOT NULL COMMENT 'Username of the person who updated the record',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `alertMH` (
  `alertId` bigint(20) NOT NULL COMMENT 'Primary key from alert table',
  `revisionId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'revision ID, combined with ID forms the primary key',
  `action` varchar(128) NOT NULL COMMENT 'Action taken',
  `contact` mediumtext NOT NULL COMMENT 'list of contacts for the alert. JSON format field that contains phone number and email.',
  `subject` mediumtext NOT NULL COMMENT 'Subject of the alert. Should be plain text, no html.',
  `body` mediumtext NOT NULL COMMENT 'Body of the alert message. Plain text, no html.',
  `trigger` mediumtext NOT NULL COMMENT 'List of conditions to trigger the alert. JSON format.',
  `active` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the alert active (equals to 0) or not (equals to 1). By default, inactive.',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT ' 0 = not deleted, 1 = deleted',
  `deletedBy` varchar(128) NOT NULL COMMENT 'Username of the person who deleted the record',
  `creationDate` datetime NOT NULL COMMENT 'Date and time of creation of the record',
  `createdBy` varchar(128) NOT NULL COMMENT 'Username of the person who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date and time of last update of the record',
  `updatedBy` varchar(128) NOT NULL COMMENT 'Username of the person who updated the record',
  PRIMARY KEY (`alertId`,`revisionId`) USING BTREE,
  KEY `updatedBy` (`updatedBy`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;