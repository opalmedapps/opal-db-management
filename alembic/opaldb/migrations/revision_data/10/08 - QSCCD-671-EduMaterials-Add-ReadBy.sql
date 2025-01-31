ALTER TABLE `EducationalMaterial` DROP COLUMN  IF EXISTS `Readby`;
ALTER TABLE `EducationalMaterial` CHANGE `ReadStatus` `ReadStatus` int(11) NOT NULL COMMENT 'Deprecated' AFTER `DateAdded`;
ALTER TABLE `EducationalMaterial` ADD COLUMN  `ReadBy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`ReadBy`)) AFTER `ReadStatus`;

UPDATE `EducationalMaterial` Edu
SET `ReadBy` = JSON_ARRAY_APPEND(`ReadBy`,'$', (
    SELECT `Username`
    FROM `Users` Usr
    WHERE Usr.`UserTypeSerNum` = Edu.`PatientSerNum`
))
WHERE `ReadStatus` = 1;
