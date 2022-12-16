CREATE TABLE `auditSystem` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
	`module` VARCHAR(128) NOT NULL COMMENT 'Name of the module the user accessed',
	`method` VARCHAR(128) NOT NULL COMMENT 'Name of the method in the module the user activated',
	`argument` LONGTEXT NOT NULL COMMENT 'Arguments (if any) passed to the method called.',
	`access` VARCHAR(16) NOT NULL COMMENT 'If the access to the user was GRANTED or DENIED',
	`ipAddress` VARCHAR(64) NOT NULL COMMENT 'IP address of the user',
	`creationDate` DATETIME NOT NULL COMMENT 'Date of the user request',
	`createdBy` VARCHAR(128) NOT NULL COMMENT 'Username of the user who made the request',
	PRIMARY KEY (`ID`) USING BTREE
)
;