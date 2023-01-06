
-- reset patient mrns
TRUNCATE TABLE Patient_Hospital_Identifier;

-- reset primary index count on TestExpression
SET @newid = 0;
UPDATE TestExpression SET TestExpressionSerNum = (@newid := @newid+1) ORDER BY TestExpressionSerNum;

-- Set the autoincrement on TestExpression to the largest index +1
SET @maxSer := (SELECT MAX(TestExpressionSerNum) FROM TestExpression);

SET @autoIncrementSql = concat('ALTER TABLE TestExpression AUTO_INCREMENT = ', @maxSer);
prepare stmt from @autoIncrementSql;
execute stmt;
deallocate prepare stmt;

-- changes for TestExpression
ALTER TABLE `TestExpression`
CHANGE COLUMN `DateAdded` `DateAdded` DATETIME NOT NULL DEFAULT NOW() AFTER `ExpressionName`,
CHANGE COLUMN `LastPublished` `LastPublished` DATETIME NULL DEFAULT NULL AFTER `DateAdded`,
CHANGE COLUMN `deletedBy` `deletedBy` VARCHAR(255) NULL DEFAULT NULL AFTER `deleted`,
ADD CONSTRAINT `TestExpression_ibfk_1` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT `TestExpression_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON UPDATE CASCADE ON DELETE SET NULL;

-- remove Oacis formatted data in TestExpression
-- also remove duplicates
DELETE FROM TestExpression WHERE TestExpressionSerNum IN (595,1345);

UPDATE TestExpression
SET TestCode = REGEXP_REPLACE(REGEXP_REPLACE(TestCode,'^MX',''),'\\*$','')
WHERE 1;

-- changes for TestGroupExpression
DROP TABLE IF EXISTS `TestGroupExpression`;
CREATE TABLE IF NOT EXISTS `TestGroupExpression` (
    `TestGroupExpressionSerNum` int(11) NOT NULL AUTO_INCREMENT,
    `TestCode` varchar(30) NOT NULL,
    `ExpressionName` varchar(100) NOT NULL,
    `DateAdded` datetime NOT NULL DEFAULT NOW(),
    `LastPublished` datetime DEFAULT NULL,
    `LastUpdatedBy` int(11) DEFAULT NULL,
    `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 4,
    `LastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `SessionId` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`TestGroupExpressionSerNum`),
    UNIQUE KEY `TestCode` (`TestCode`,`SourceDatabaseSerNum`),
    KEY `LastUpdatedBy` (`LastUpdatedBy`),
    KEY `TestExpression_ibfk_1` (`SourceDatabaseSerNum`),
    CONSTRAINT `TestGroupExpression_ibfk_2` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `TestGroupExpression_ibfk_3` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- changes for PatientTestResult
DROP TABLE IF EXISTS `PatientTestResult`;
CREATE TABLE IF NOT EXISTS `PatientTestResult` (
    `PatientTestResultSerNum` bigint(11) NOT NULL AUTO_INCREMENT,
    `TestGroupExpressionSerNum` int(11) NOT NULL,
    `TestExpressionSerNum` int(11) NOT NULL,
    `PatientSerNum` int(11) NOT NULL,
    `AbnormalFlag` varchar(10) NULL,
    `SequenceNum` int(11) DEFAULT NULL COMMENT 'Order of Lab Tests in which they should be displayed',
    `CollectedDateTime` datetime NOT NULL,
    `ResultDateTime` datetime NOT NULL,
    `NormalRangeMin` float DEFAULT NULL,
    `NormalRangeMax` float DEFAULT NULL,
    `NormalRange` varchar(30) NOT NULL DEFAULT '',
    `TestValueNumeric` float DEFAULT NULL,
    `TestValue` varchar(255) NOT NULL,
    `UnitDescription` varchar(40) NOT NULL,
    `DateAdded` datetime NOT NULL,
    `ReadStatus` int(11) NOT NULL DEFAULT 0,
    `LastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`PatientTestResultSerNum`),
    UNIQUE KEY `PatientTestCodeTestDate` (`PatientSerNum`,`TestExpressionSerNum`,`CollectedDateTime`),
    KEY `PatientSerNum` (`PatientSerNum`),
    KEY `TestResultExpressionSerNum` (`TestExpressionSerNum`),
    KEY `TestResultGroupSerNum` (`TestGroupExpressionSerNum`),
    CONSTRAINT `FK_PatientTestResult_TestExpression` FOREIGN KEY (`TestExpressionSerNum`) REFERENCES `TestExpression` (`TestExpressionSerNum`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `FK_PatientTestResult_TestGroupExpression` FOREIGN KEY (`TestGroupExpressionSerNum`) REFERENCES `TestGroupExpression` (`TestGroupExpressionSerNum`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `FK_PatientTestResult_Patient` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

-- TestResultNotificationQueue, TestResultNotificationProcessingLog and their triggers
DROP TRIGGER IF EXISTS `insert_test_result_notification_queue_trigger`;
DROP TRIGGER IF EXISTS `update_test_result_notification_queue_trigger`;
DROP TABLE IF EXISTS TestResultNotificationQueue;
DROP TABLE IF EXISTS TestResultNotificationProcessingLog;
