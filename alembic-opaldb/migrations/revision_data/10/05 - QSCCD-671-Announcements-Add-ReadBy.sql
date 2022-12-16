ALTER TABLE `Announcement` DROP COLUMN  IF EXISTS `Readby`;
ALTER TABLE `Announcement` CHANGE `ReadStatus` `ReadStatus` int(11) NOT NULL COMMENT 'Deprecated' AFTER `DateAdded`;
ALTER TABLE `Announcement` ADD COLUMN  `ReadBy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`ReadBy`)) AFTER `ReadStatus`;

UPDATE `Announcement` Ann
SET `ReadBy` = JSON_ARRAY_APPEND(`ReadBy`,'$', (
    SELECT `Username`
    FROM `Users` Usr
    WHERE Usr.`UserTypeSerNum` = Ann.`PatientSerNum`
))
WHERE `ReadStatus` = 1;