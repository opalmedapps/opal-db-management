CREATE TABLE IF NOT EXISTS `masterSourceAlias` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `externalId` bigint(20) NOT NULL DEFAULT -1 COMMENT 'External ID from the other database',
  `code` varchar(128) NOT NULL COMMENT 'Code of the alias source',
  `description` varchar(128) NOT NULL COMMENT 'Expression of the alias source',
  `type` int(3) NOT NULL DEFAULT -1 COMMENT '-1 = no type, 1 = Task, 2 = Appointment, 3 = Document',
  `source` int(3) NOT NULL DEFAULT -1 COMMENT '-1 = no source type, 1 = Aria, 2 = Medivisit',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT 'has the data being deleted or not',
  `deletedBy` varchar(255) NOT NULL COMMENT 'username of who marked the record to be deleted',
  `creationDate` datetime NOT NULL COMMENT 'Date of creation of the record',
  `createdBy` varchar(255) NOT NULL COMMENT 'username of who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last time the record was updated',
  `updatedBy` varchar(255) NOT NULL COMMENT 'username of who updated the record',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Imported list of all the aliases from different sources';

CREATE TABLE IF NOT EXISTS `masterSourceDiagnosis` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `externalId` bigint(20) NOT NULL DEFAULT -1 COMMENT 'External ID from the other database',
  `code` varchar(256) NOT NULL COMMENT 'Diagnosis Code',
  `description` varchar(256) NOT NULL COMMENT 'Description of the diagnostic',
  `source` int(3) NOT NULL DEFAULT -1 COMMENT '-1 = no source type, 1 = Aria',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT 'has the data being deleted or not',
  `deletedBy` varchar(255) NOT NULL COMMENT 'username of who marked the record to be deleted',
  `creationDate` datetime NOT NULL COMMENT 'Date of creation of the record',
  `createdBy` varchar(255) NOT NULL COMMENT 'username of who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last time the record was updated',
  `updatedBy` varchar(255) NOT NULL COMMENT 'username of who updated the record',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Imported list of all the diagnosis from different sources';

CREATE TABLE IF NOT EXISTS `masterSourceTestResult` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `externalId` bigint(20) NOT NULL DEFAULT -1 COMMENT 'External ID from the other database',
  `code` varchar(128) NOT NULL COMMENT 'Code of the test result',
  `description` varchar(128) NOT NULL COMMENT 'Description of the test result',
  `source` int(3) NOT NULL DEFAULT -1 COMMENT '-1 = no source type, 1 = Aria',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT 'has the data being deleted or not',
  `deletedBy` varchar(255) NOT NULL COMMENT 'username of who marked the record to be deleted',
  `creationDate` datetime NOT NULL COMMENT 'Date of creation of the record',
  `createdBy` varchar(255) NOT NULL COMMENT 'username of who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last time the record was updated',
  `updatedBy` varchar(255) NOT NULL COMMENT 'username of who updated the record',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Imported list of all the test results from different sources';
