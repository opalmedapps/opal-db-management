ALTER TABLE `PatientTestResult` DROP COLUMN  IF EXISTS `Readby`;
ALTER TABLE `PatientTestResult` CHANGE `ReadStatus` `ReadStatus` int(11) NOT NULL COMMENT 'Deprecated' AFTER `DateAdded`;
ALTER TABLE `PatientTestResult` ADD COLUMN  `ReadBy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`ReadBy`)) AFTER `ReadStatus`;

UPDATE `PatientTestResult` Ptr
SET `ReadBy` = JSON_ARRAY_APPEND(`ReadBy`,'$', (
    SELECT `Username`
    FROM `Users` Usr
    WHERE Usr.`UserTypeSerNum` = Ptr.`PatientSerNum`
))
WHERE `ReadStatus` = 1;