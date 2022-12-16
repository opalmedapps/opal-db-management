ALTER TABLE `TxTeamMessage` DROP COLUMN  IF EXISTS `Readby`;
ALTER TABLE `TxTeamMessage` CHANGE `ReadStatus` `ReadStatus` int(11) NOT NULL COMMENT 'Deprecated' AFTER `DateAdded`;
ALTER TABLE `TxTeamMessage` ADD COLUMN  `ReadBy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' CHECK (json_valid(`ReadBy`)) AFTER `ReadStatus`;

UPDATE `TxTeamMessage` Txt
SET `ReadBy` = JSON_ARRAY_APPEND(`ReadBy`,'$', (
    SELECT `Username`
    FROM `Users` Usr
    WHERE Usr.`UserTypeSerNum` = Txt.`PatientSerNum`
))
WHERE `ReadStatus` = 1;