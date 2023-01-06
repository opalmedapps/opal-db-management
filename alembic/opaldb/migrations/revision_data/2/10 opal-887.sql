CREATE TABLE `resourcePending` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`sourceName` VARCHAR(128) NOT NULL,
	`appointmentId` BIGINT(20) NOT NULL,
	`resources` MEDIUMTEXT NOT NULL,
	`level` TINYINT NOT NULL DEFAULT 1,
	`creationDate` DATETIME NOT NULL,
	`createdBy` VARCHAR(255) NOT NULL,
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`updatedBy` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE `resourcePendingError` (
	`ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`sourceName` VARCHAR(128) NOT NULL,
	`appointmentId` BIGINT(20) NOT NULL,
	`resources` MEDIUMTEXT NOT NULL,
	`level` TINYINT NOT NULL DEFAULT 1,
	`error` MEDIUMTEXT NOT NULL,
	`creationDate` DATETIME NOT NULL,
	`createdBy` VARCHAR(255) NOT NULL,
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`updatedBy` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `resourcePendingMH` (
  `resourcePendingId` bigint(20) NOT NULL,
  `revisionId` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` varchar(128) NOT NULL,
	`sourceName` VARCHAR(128) NOT NULL,
	`appointmentId` BIGINT(20) NOT NULL,
	`resources` MEDIUMTEXT NOT NULL,
	`level` TINYINT NOT NULL DEFAULT 1,
	`creationDate` DATETIME NOT NULL,
	`createdBy` VARCHAR(255) NOT NULL,
	`lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`updatedBy` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`resourcePendingId`,`revisionId`) USING BTREE,
  KEY `updatedBy` (`updatedBy`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

REPLACE INTO `module` (`ID`, `operation`, `name_EN`, `name_FR`, `description_EN`, `description_FR`, `tableName`, `controlTableName`, `primaryKey`, `iconClass`, `url`, `active`, `categoryModuleId`, `publication`, `customCode`, `unique`, `order`, `sqlPublicationList`, `sqlDetails`, `sqlPublicationChartLog`, `sqlPublicationListLog`, `sqlPublicationMultiple`, `sqlPublicationUnique`) VALUES (21, 7, 'Resources (API only / No GUI)', 'Ressources (API seulement / pas de GUI)', 'Manage the resources for appointments.', 'Gestion des ressources pour les rendez-vous.', '', '', '', 'fa fa-list-ol', 'resource', 1, 2, 0, 0, 1, 21, '', '', '', '', '', '');

ALTER TABLE `Resource`
	ADD COLUMN `ResourceCode` VARCHAR(128) NOT NULL AFTER `ResourceAriaSer`;

ALTER TABLE `resourcePending`
	ADD UNIQUE INDEX `sourceAppointment` (`sourceName`, `appointmentId`);

CREATE TRIGGER `resourcePending_after_insert` AFTER INSERT ON `resourcePending` FOR EACH ROW BEGIN
	INSERT INTO resourcePendingMH (resourcePendingId, action, sourceName, appointmentId, resources, `level`, creationDate, createdBy, lastUpdated, updatedBy)
	VALUES
	(NEW.ID, 'INSERT', NEW.sourceName, NEW.appointmentId, NEW.resources, NEW.`level`, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy);
END;

CREATE TRIGGER `resourcePending_after_update` AFTER UPDATE ON `resourcePending` FOR EACH ROW BEGIN
	IF NEW.lastUpdated != OLD.lastUpdated THEN
		INSERT INTO resourcePendingMH (resourcePendingId, action, sourceName, appointmentId, resources, `level`, creationDate, createdBy, lastUpdated, updatedBy)
		VALUES
		(NEW.ID, 'UPDATE', NEW.sourceName, NEW.appointmentId, NEW.resources, NEW.`level`, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy);
	END IF;
END;

CREATE TRIGGER `resourcePending_after_delete` AFTER DELETE ON `resourcePending` FOR EACH ROW BEGIN
	INSERT INTO resourcePendingMH (resourcePendingId, action, sourceName, appointmentId, resources, `level`, creationDate, createdBy, lastUpdated, updatedBy)
	VALUES
	(OLD.ID, 'DELETE', OLD.sourceName, OLD.appointmentId, OLD.resources, OLD.`level`, NOW(), OLD.createdBy, OLD.lastUpdated, OLD.updatedBy);
END;
