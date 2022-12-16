INSERT INTO `publicationSetting` (`ID`, `name_EN`, `name_FR`, `internalName`, `isTrigger`, `selectAll`, `opalDB`, `opalPK`) VALUES ('10', 'Trigger to Send By Study', 'Déclencheur par étude', 'Study', '1', '1', 'SELECT DISTINCT ID AS id, CONCAT (code, " ", title_EN) AS name, "Study" AS type, 0 AS added FROM study WHERE deleted = 0 ORDER BY code, title_EN;', 'id');

INSERT INTO `OpalDB`.`modulePublicationSetting` (`moduleId`, `publicationSettingId`) VALUES ('2', '10');
INSERT INTO `OpalDB`.`modulePublicationSetting` (`moduleId`, `publicationSettingId`) VALUES ('3', '10');
INSERT INTO `OpalDB`.`modulePublicationSetting` (`moduleId`, `publicationSettingId`) VALUES ('7', '10');

TRUNCATE `study`;

ALTER TABLE `study`
	CHANGE COLUMN `title` `title_EN` VARCHAR(256) NULL DEFAULT NULL COMMENT 'English title of the study. Mandatory.' COLLATE 'latin1_swedish_ci' AFTER `code`,
	ADD COLUMN `title_FR` VARCHAR(256) NULL DEFAULT NULL COMMENT 'French title of the study. Mandatory.' AFTER `title_EN`,
	ADD COLUMN `description_EN` TEXT NULL COMMENT 'English description of the study. Mandatory.' AFTER `title_FR`,
	ADD COLUMN `description_FR` TEXT NULL COMMENT 'French description of the study. Mandatory.' AFTER `description_EN`;