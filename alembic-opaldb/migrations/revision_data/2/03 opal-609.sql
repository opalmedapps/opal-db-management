DELETE FROM masterSourceAlias WHERE source != 1;

ALTER TABLE `masterSourceAlias`
	ADD UNIQUE INDEX `f_externalId_code_source_type` (`externalId`, `code`, `source`, `type`) USING BTREE;

ALTER TABLE `masterSourceAlias`
	CHANGE COLUMN `externalId` `externalId` VARCHAR(512) NOT NULL DEFAULT '-1' COMMENT 'External ID from the other database' AFTER `ID`;

ALTER TABLE `masterSourceDiagnosis`
	ADD UNIQUE INDEX `masterSourceDiagnosisKey` (`externalId`, `code`, `source`) USING BTREE;

ALTER TABLE `masterSourceDiagnosis`
	CHANGE COLUMN `externalId` `externalId` VARCHAR(512) NOT NULL DEFAULT '-1' COMMENT 'External ID from the other database' AFTER `ID`;

DROP TABLE IF EXISTS `masterSourceTestResult`;

ALTER TABLE `TestExpression`
	ADD COLUMN `externalId` VARCHAR(512) NOT NULL DEFAULT '-1' AFTER `SessionId`,
	ADD COLUMN `deleted` INT(1) NOT NULL DEFAULT 0 AFTER `externalId`,
	ADD COLUMN `deletedBy` VARCHAR(255) NOT NULL AFTER `deleted`,
	ADD COLUMN `createdBy` VARCHAR(255) NOT NULL DEFAULT 'cronjob' AFTER `deletedBy`,
	ADD COLUMN `updatedBy` VARCHAR(255) NOT NULL DEFAULT 'cronjob' AFTER `createdBy`;

CREATE OR REPLACE VIEW v_masterSourceTestResult AS
SELECT TestExpressionSerNum AS ID, externalId, TestCode AS `code`, ExpressionName AS description, SourceDatabaseSerNum AS `source`,
deleted, deletedBy, DateAdded AS creationDate, createdBy, LastUpdated AS lastUpdated, updatedBy FROM TestExpression;
	
TRUNCATE masterSourceAlias;
TRUNCATE masterSourceDiagnosis;

/* removing custom codes module and GUI */
DELETE FROM oaRoleModule WHERE moduleId = 15;
DELETE FROM modulePublicationSetting WHERE moduleId = 15;
DELETE FROM module WHERE ID = 15;

/* Trim the code and description in Diagnosis and DiagnosisCode, and invert the sourceUID to avoid duplicate issues in the key for the future */
UPDATE Diagnosis SET DiagnosisCode = RTRIM(DiagnosisCode), Description_EN = RTRIM(Description_EN);
UPDATE DiagnosisCode SET DiagnosisCode = RTRIM(DiagnosisCode), Description = RTRIM(Description), SourceUID = SourceUID * -1;
ALTER TABLE `DiagnosisCode`
	CHANGE COLUMN `SourceUID` `SourceUID` BIGINT(20) NOT NULL DEFAULT 0 AFTER `DiagnosisTranslationSerNum`;
	
ALTER TABLE `DiagnosisCode`
	DROP INDEX `SourceUID`,
	ADD UNIQUE INDEX `SourceUID` (`SourceUID`, `Source`) USING BTREE;

/* Create a backup of the DiagnosisCodeMH table as a legacy and empty the current table for future references */
CREATE TABLE `OpalDB`.`DiagnosisCodeMH_legacy` (
	`DiagnosisTranslationSerNum` INT(11) NOT NULL,
	`SourceUID` INT(11) NOT NULL,
	`RevSerNum` INT(11) NOT NULL AUTO_INCREMENT,
	`DiagnosisCode` VARCHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`Description` VARCHAR(2056) NOT NULL COLLATE 'latin1_swedish_ci',
	`DateAdded` DATETIME NOT NULL,
	`ModificationAction` VARCHAR(25) NOT NULL COLLATE 'latin1_swedish_ci',
	`LastUpdatedBy` INT(11) NULL DEFAULT NULL,
	`SessionId` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`SourceUID`, `RevSerNum`) USING BTREE,
	INDEX `DiagnosisTranslationSerNum` (`DiagnosisTranslationSerNum`) USING BTREE,
	INDEX `LastUpdatedBy` (`LastUpdatedBy`) USING BTREE
)
 COLLATE 'latin1_swedish_ci' ENGINE=MyISAM ROW_FORMAT=Dynamic AUTO_INCREMENT=1;
INSERT INTO `OpalDB`.`DiagnosisCodeMH_legacy` (`DiagnosisTranslationSerNum`, `SourceUID`, `RevSerNum`, `DiagnosisCode`, `Description`, `DateAdded`, `ModificationAction`, `LastUpdatedBy`, `SessionId`) SELECT `DiagnosisTranslationSerNum`, `SourceUID`, `RevSerNum`, `DiagnosisCode`, `Description`, `DateAdded`, `ModificationAction`, `LastUpdatedBy`, `SessionId` FROM `DiagnosisCodeMH`;

TRUNCATE `DiagnosisCodeMH`;

/* Backup AliasExpressionMH into a new table and empty it */
CREATE TABLE `OpalDB`.`AliasExpressionMH_legacy` (
	`AliasSerNum` INT(11) NOT NULL DEFAULT '0',
	`ExpressionName` VARCHAR(250) NOT NULL COLLATE 'latin1_swedish_ci',
	`Description` VARCHAR(250) NOT NULL COLLATE 'latin1_swedish_ci',
	`RevSerNum` INT(11) NOT NULL AUTO_INCREMENT,
	`LastTransferred` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00',
	`LastUpdatedBy` INT(11) NULL DEFAULT NULL,
	`DateAdded` DATETIME NOT NULL,
	`ModificationAction` VARCHAR(25) NOT NULL COLLATE 'latin1_swedish_ci',
	`SessionId` VARCHAR(255) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`ExpressionName`, `Description`, `RevSerNum`) USING BTREE,
	INDEX `AliasSerNum` (`AliasSerNum`) USING BTREE,
	INDEX `LastUpdatedBy` (`LastUpdatedBy`) USING BTREE
)
 COLLATE 'latin1_swedish_ci' ENGINE=MyISAM ROW_FORMAT=Dynamic AUTO_INCREMENT=1;
INSERT INTO `OpalDB`.`AliasExpressionMH_legacy` (`AliasSerNum`, `ExpressionName`, `Description`, `RevSerNum`, `LastTransferred`, `LastUpdatedBy`, `DateAdded`, `ModificationAction`, `SessionId`) SELECT `AliasSerNum`, `ExpressionName`, `Description`, `RevSerNum`, `LastTransferred`, `LastUpdatedBy`, `DateAdded`, `ModificationAction`, `SessionId` FROM `AliasExpressionMH`;

TRUNCATE `AliasExpressionMH`;

/* Add the masterSourceAliasId field to AliasExpression and AliasExpressionMH and modify the triggers */

ALTER TABLE `AliasExpression`
	ADD COLUMN `masterSourceAliasId` BIGINT(20) NULL DEFAULT NULL AFTER `AliasSerNum`,
	ADD CONSTRAINT `AliasExpression_masterSourceAliasId` FOREIGN KEY (`masterSourceAliasId`) REFERENCES `masterSourceAlias` (`ID`);

ALTER TABLE `AliasExpressionMH`
	ADD COLUMN `masterSourceAliasId` BIGINT(20) NOT NULL DEFAULT 0 AFTER `AliasSerNum`,
	ADD INDEX `masterSourceAliasId` (`masterSourceAliasId`);

DROP TRIGGER `alias_expression_delete_trigger`;
DROP TRIGGER `alias_expression_insert_trigger`;
DROP TRIGGER `alias_expression_update_trigger`;

CREATE TRIGGER `alias_expression_delete_trigger` AFTER DELETE ON `AliasExpression` FOR EACH ROW BEGIN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (OLD.AliasSerNum, OLD.masterSourceAliasId, OLD.ExpressionName, OLD.Description, OLD.LastTransferred, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END;

CREATE TRIGGER `alias_expression_insert_trigger` AFTER INSERT ON `AliasExpression` FOR EACH ROW BEGIN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.masterSourceAliasId, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END;

CREATE TRIGGER `alias_expression_update_trigger` AFTER UPDATE ON `AliasExpression` FOR EACH ROW BEGIN
if NEW.LastTransferred <=> OLD.LastTransferred THEN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, Description, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.masterSourceAliasId, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END IF;
END;

ALTER TABLE `AliasExpression`
	DROP INDEX `ExpressionName_Description`;

ALTER TABLE `AliasExpression`
	ADD UNIQUE INDEX `key_masterSourceAliasId` (`masterSourceAliasId`) USING BTREE;

ALTER TABLE `AliasExpression`
	ADD INDEX `idx_ExpressionName_Description` (`ExpressionName`, `Description`);