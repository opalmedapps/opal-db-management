-- --------------------------------------------------------
-- Host:                         lxkvmap96
-- Server version:               10.5.9-MariaDB - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for OpalDB
CREATE DATABASE IF NOT EXISTS `OpalDB` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `OpalDB`;

-- Dumping structure for table OpalDB.accesslevel
CREATE TABLE IF NOT EXISTS `accesslevel` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccessLevelName_EN` varchar(200) NOT NULL,
  `AccessLevelName_FR` varchar(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Table to store level of access in opal application. There are two levels 1- Need to Know and 2-All. ';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Admin
CREATE TABLE IF NOT EXISTS `Admin` (
  `AdminSerNum` int(11) NOT NULL,
  `ResourceSerNum` int(11) NOT NULL,
  `FirstName` text NOT NULL,
  `LastName` text NOT NULL,
  `Email` text NOT NULL,
  `Phone` bigint(20) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  KEY `ResourceSerNum` (`ResourceSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.alert
CREATE TABLE IF NOT EXISTS `alert` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key, auto-increment',
  `contact` mediumtext NOT NULL COMMENT 'list of contacts for the alert. JSON format field that contains phone number and email.',
  `subject` mediumtext NOT NULL COMMENT 'Subject of the alert. Should be plain text, no html.',
  `body` mediumtext NOT NULL COMMENT 'Body of the alert message. Plain text, no html.',
  `trigger` mediumtext NOT NULL COMMENT 'List of conditions to trigger the alert. JSON format.',
  `active` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the alert active (equals to 0) or not (equals to 1). By default, inactive.',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT ' 0 = not deleted, 1 = deleted',
  `deletedBy` varchar(128) NOT NULL COMMENT 'Username of the person who deleted the record',
  `creationDate` datetime NOT NULL COMMENT 'Date and time of creation of the record',
  `createdBy` varchar(128) NOT NULL COMMENT 'Username of the person who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date and time of last update of the record',
  `updatedBy` varchar(128) NOT NULL COMMENT 'Username of the person who updated the record',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.alertMH
CREATE TABLE IF NOT EXISTS `alertMH` (
  `alertId` bigint(20) NOT NULL COMMENT 'Primary key from alert table',
  `revisionId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'revision ID, combined with ID forms the primary key',
  `action` varchar(128) NOT NULL COMMENT 'Action taken',
  `contact` mediumtext NOT NULL COMMENT 'list of contacts for the alert. JSON format field that contains phone number and email.',
  `subject` mediumtext NOT NULL COMMENT 'Subject of the alert. Should be plain text, no html.',
  `body` mediumtext NOT NULL COMMENT 'Body of the alert message. Plain text, no html.',
  `trigger` mediumtext NOT NULL COMMENT 'List of conditions to trigger the alert. JSON format.',
  `active` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the alert active (equals to 0) or not (equals to 1). By default, inactive.',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT ' 0 = not deleted, 1 = deleted',
  `deletedBy` varchar(128) NOT NULL COMMENT 'Username of the person who deleted the record',
  `creationDate` datetime NOT NULL COMMENT 'Date and time of creation of the record',
  `createdBy` varchar(128) NOT NULL COMMENT 'Username of the person who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date and time of last update of the record',
  `updatedBy` varchar(128) NOT NULL COMMENT 'Username of the person who updated the record',
  PRIMARY KEY (`alertId`,`revisionId`) USING BTREE,
  KEY `updatedBy` (`updatedBy`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Alias
CREATE TABLE IF NOT EXISTS `Alias` (
  `AliasSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasType` varchar(25) NOT NULL,
  `AliasUpdate` int(11) NOT NULL,
  `AliasName_FR` varchar(100) NOT NULL,
  `AliasName_EN` varchar(100) NOT NULL,
  `AliasDescription_FR` text NOT NULL,
  `AliasDescription_EN` text NOT NULL,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `HospitalMapSerNum` int(11) DEFAULT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 1,
  `ColorTag` varchar(25) NOT NULL DEFAULT '#777777',
  `WaitTimeValidity` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'This field exist in DEV. Usage is unknow',
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AliasSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `HospitalMapSerNum` (`HospitalMapSerNum`),
  KEY `AliasType` (`AliasType`),
  KEY `AliasUpdate` (`AliasUpdate`),
  KEY `AliasSerNum` (`AliasSerNum`),
  CONSTRAINT `Alias_ibfk_1` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Alias_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Alias_ibfk_3` FOREIGN KEY (`HospitalMapSerNum`) REFERENCES `HospitalMap` (`HospitalMapSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AliasExpression
CREATE TABLE IF NOT EXISTS `AliasExpression` (
  `AliasExpressionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasSerNum` int(11) NOT NULL DEFAULT 0,
  `masterSourceAliasId` bigint(20) DEFAULT NULL,
  `ExpressionName` varchar(250) NOT NULL,
  `Description` varchar(250) NOT NULL COMMENT 'Resource Description',
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AliasExpressionSerNum`),
  UNIQUE KEY `key_masterSourceAliasId` (`masterSourceAliasId`) USING BTREE,
  KEY `AliasSerNum` (`AliasSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `idx_ExpressionName_Description` (`ExpressionName`,`Description`),
  KEY `AliasExpressionSerNum` (`AliasExpressionSerNum`),
  CONSTRAINT `AliasExpression_ibfk_4` FOREIGN KEY (`AliasSerNum`) REFERENCES `Alias` (`AliasSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `AliasExpression_ibfk_5` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `AliasExpression_masterSourceAliasId` FOREIGN KEY (`masterSourceAliasId`) REFERENCES `masterSourceAlias` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7264 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AliasExpressionMH
CREATE TABLE IF NOT EXISTS `AliasExpressionMH` (
  `AliasSerNum` int(11) NOT NULL DEFAULT 0,
  `masterSourceAliasId` bigint(20) NOT NULL DEFAULT 0,
  `ExpressionName` varchar(250) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ExpressionName`,`Description`,`RevSerNum`),
  KEY `AliasSerNum` (`AliasSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `masterSourceAliasId` (`masterSourceAliasId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AliasMH
CREATE TABLE IF NOT EXISTS `AliasMH` (
  `AliasSerNum` int(11) NOT NULL,
  `AliasRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasType` varchar(25) NOT NULL,
  `AliasUpdate` int(11) NOT NULL,
  `AliasName_FR` varchar(100) NOT NULL,
  `AliasName_EN` varchar(100) NOT NULL,
  `AliasDescription_FR` text NOT NULL,
  `AliasDescription_EN` text NOT NULL,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `HospitalMapSerNum` int(11) DEFAULT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 1,
  `ColorTag` varchar(25) NOT NULL DEFAULT '#777777',
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`AliasSerNum`,`AliasRevSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AllowableExtension
CREATE TABLE IF NOT EXISTS `AllowableExtension` (
  `Type` enum('video','website','pdf','image') NOT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Type`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Announcement
CREATE TABLE IF NOT EXISTS `Announcement` (
  `AnnouncementSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`AnnouncementSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `AnnouncementSerNum` (`AnnouncementSerNum`),
  CONSTRAINT `Announcement_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Announcement_ibfk_2` FOREIGN KEY (`PostControlSerNum`) REFERENCES `PostControl` (`PostControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Announcement_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=552 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AnnouncementMH
CREATE TABLE IF NOT EXISTS `AnnouncementMH` (
  `AnnouncementSerNum` int(11) NOT NULL,
  `AnnouncementRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`AnnouncementSerNum`,`AnnouncementRevSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostControlSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Appointment
CREATE TABLE IF NOT EXISTS `Appointment` (
  `AppointmentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasExpressionSerNum` int(11) NOT NULL,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `AppointmentAriaSer` int(11) NOT NULL,
  `PrioritySerNum` int(11) NOT NULL,
  `DiagnosisSerNum` int(11) NOT NULL,
  `Status` varchar(100) NOT NULL,
  `State` varchar(25) NOT NULL,
  `ScheduledStartTime` datetime NOT NULL,
  `ScheduledEndTime` datetime NOT NULL,
  `ActualStartDate` datetime NOT NULL,
  `ActualEndDate` datetime NOT NULL,
  `Location` int(10) NOT NULL DEFAULT 10,
  `RoomLocation_EN` varchar(100) NOT NULL,
  `RoomLocation_FR` varchar(100) NOT NULL,
  `Checkin` tinyint(4) NOT NULL,
  `ChangeRequest` tinyint(4) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`AppointmentSerNum`),
  KEY `AliasExpressionSerNum` (`AliasExpressionSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `AppointmentAriaSer` (`AppointmentAriaSer`),
  KEY `DiagnosisSerNum` (`DiagnosisSerNum`),
  KEY `PrioritySerNum` (`PrioritySerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `AppointmentSerNum` (`AppointmentSerNum`),
  KEY `Status` (`Status`),
  KEY `State` (`State`),
  KEY `ScheduledStartTime` (`ScheduledStartTime`),
  CONSTRAINT `Appointment_ibfk_2` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Appointment_ibfk_3` FOREIGN KEY (`AliasExpressionSerNum`) REFERENCES `AliasExpression` (`AliasExpressionSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Appointment_ibfk_4` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5101 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AppointmentCheckin
CREATE TABLE IF NOT EXISTS `AppointmentCheckin` (
  `AliasSerNum` int(11) NOT NULL,
  `CheckinPossible` tinyint(4) NOT NULL,
  `CheckinInstruction_EN` text NOT NULL,
  `CheckinInstruction_FR` text NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`AliasSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `AliasSerNum` (`AliasSerNum`),
  CONSTRAINT `AppointmentCheckin_ibfk_1` FOREIGN KEY (`AliasSerNum`) REFERENCES `Alias` (`AliasSerNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `AppointmentCheckin_ibfk_3` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AppointmentDelay
CREATE TABLE IF NOT EXISTS `AppointmentDelay` (
  `Type` varchar(30) NOT NULL,
  `Hour` int(2) NOT NULL,
  `Weekday` int(1) NOT NULL,
  `Count0` int(8) NOT NULL,
  `Count15` int(8) NOT NULL,
  `Count30` int(8) NOT NULL,
  `Count45` int(8) NOT NULL,
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5576 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AppointmentMH
CREATE TABLE IF NOT EXISTS `AppointmentMH` (
  `AppointmentSerNum` int(11) NOT NULL,
  `AppointmentRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SessionId` text DEFAULT NULL,
  `AliasExpressionSerNum` int(11) NOT NULL,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `AppointmentAriaSer` int(11) NOT NULL,
  `PrioritySerNum` int(11) NOT NULL,
  `DiagnosisSerNum` int(11) NOT NULL,
  `Status` varchar(100) NOT NULL,
  `State` varchar(25) NOT NULL,
  `ScheduledStartTime` datetime NOT NULL,
  `ScheduledEndTime` datetime NOT NULL,
  `ActualStartDate` datetime NOT NULL,
  `ActualEndDate` datetime NOT NULL,
  `Location` int(10) NOT NULL,
  `RoomLocation_EN` varchar(100) NOT NULL,
  `RoomLocation_FR` varchar(100) NOT NULL,
  `Checkin` tinyint(4) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`AppointmentSerNum`,`AppointmentRevSerNum`),
  KEY `AliasExpressionSerNum` (`AliasExpressionSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `AppointmentAriaSer` (`AppointmentAriaSer`),
  KEY `PrioritySerNum` (`PrioritySerNum`),
  KEY `DiagnosisSerNum` (`DiagnosisSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.AppointmentTemp
CREATE TABLE IF NOT EXISTS `AppointmentTemp` (
  `LastUpdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `PatientId` varchar(45) DEFAULT NULL,
  `RAMQ` varchar(45) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `AppointmentType` varchar(55) DEFAULT NULL,
  `AppointmentID` varchar(25) DEFAULT NULL,
  `AppointmentStartTime` datetime DEFAULT NULL,
  `AppointmentEndTime` datetime DEFAULT NULL,
  `AppointmentTypeCode` varchar(55) DEFAULT NULL,
  `AppointmentReasonCode` varchar(30) DEFAULT NULL,
  `AppointmentReason` varchar(100) DEFAULT NULL,
  `EventReasonCode` varchar(20) DEFAULT NULL,
  `EventReason` varchar(100) DEFAULT NULL COMMENT 'Contains Reason for Cancellation, when Cancelling an appointment\\nContains other less important info when Add or Modify an appointment like: New Appointment or Appointment Modification',
  `StatusCode` varchar(40) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Source` varchar(45) DEFAULT NULL COMMENT 'Source: possible values: MediVisit, eCliniBase, MOSAIC, etc…',
  `ActionFlag` varchar(10) DEFAULT NULL COMMENT 'Possible values: A, M or C\\nA: Add new appointment\\nM: Modify existing appointment\\nC: Cancel an appointment',
  `StatusAsInOpalDB` varchar(45) DEFAULT NULL COMMENT 'Status: value as it appears in Appointment table in OpalDB. \nPossible values: Open, Cancelled, etc…',
  `StateAsInOpalDB` varchar(45) DEFAULT NULL COMMENT 'State: value as it appears in Appointment table in OpalDB. Possible value: Active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.audit
CREATE TABLE IF NOT EXISTS `audit` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `module` varchar(128) NOT NULL COMMENT 'Name of the module the user accessed',
  `method` varchar(128) NOT NULL COMMENT 'Name of the method in the module the user activated',
  `argument` longtext NOT NULL COMMENT 'Arguments (if any) passed to the method called.',
  `access` varchar(16) NOT NULL COMMENT 'If the access to the user was GRANTED or DENIED',
  `ipAddress` varchar(64) NOT NULL COMMENT 'IP address of the user',
  `creationDate` datetime NOT NULL COMMENT 'Date of the user request',
  `createdBy` varchar(128) NOT NULL COMMENT 'Username of the user who made the request',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=604099 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.BuildType
CREATE TABLE IF NOT EXISTS `BuildType` (
  `Name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.categoryModule
CREATE TABLE IF NOT EXISTS `categoryModule` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment',
  `name_EN` varchar(128) NOT NULL COMMENT 'English name of the category',
  `name_FR` varchar(128) NOT NULL COMMENT 'French name of the category',
  `order` int(3) NOT NULL DEFAULT 999 COMMENT 'Order in the navigation menu',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.CheckinLog
CREATE TABLE IF NOT EXISTS `CheckinLog` (
  `CheckinLogSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AppointmentSerNum` int(11) NOT NULL,
  `DeviceId` varchar(100) NOT NULL,
  `Latitude` double NOT NULL COMMENT 'In meters, from 45.474127399999996, -73.6011402',
  `Longitude` double NOT NULL,
  `Accuracy` double NOT NULL COMMENT 'Accuracy in meters',
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`CheckinLogSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=461 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Cron
CREATE TABLE IF NOT EXISTS `Cron` (
  `CronSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `NextCronDate` date NOT NULL,
  `RepeatUnits` varchar(50) NOT NULL,
  `NextCronTime` time NOT NULL,
  `RepeatInterval` int(11) NOT NULL,
  `LastCron` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`CronSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.cronControlAlias
CREATE TABLE IF NOT EXISTS `cronControlAlias` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `cronControlAliasSerNum` int(11) NOT NULL COMMENT 'Foreign key with AliasSerNum from Alias. Mandatory.',
  `cronType` varchar(100) NOT NULL COMMENT 'Field refers to what cron controller is using this transfer flag. eg TxTeamMessages, Document, Announcement, etc. Mandatory',
  `aliasUpdate` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Marker for data that needs to be read on next cron.',
  `lastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sessionId` varchar(255) DEFAULT NULL COMMENT 'SessionId of the user who last updated this field.',
  PRIMARY KEY (`ID`),
  KEY `fk_cronContAlias_cronContAliasSerNum_Alias_AliasSerNum` (`cronControlAliasSerNum`),
  KEY `cronType` (`cronType`),
  KEY `aliasUpdate` (`aliasUpdate`),
  CONSTRAINT `fk_cronContAlias_cronContAliasSerNum_Alias_AliasSerNum` FOREIGN KEY (`cronControlAliasSerNum`) REFERENCES `Alias` (`AliasSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.cronControlEducationalMaterial
CREATE TABLE IF NOT EXISTS `cronControlEducationalMaterial` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `cronControlEducationalMaterialControlSerNum` int(11) NOT NULL COMMENT 'Foreign key with EducMatControlSerNum from EMC. Mandatory.',
  `publishFlag` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Marker for data that has been published from opalAdmin.',
  `lastPublished` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last publish date.',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sessionId` varchar(255) DEFAULT NULL COMMENT 'SessionId of the user who last updated this field.',
  PRIMARY KEY (`ID`),
  KEY `fk_cronContEM_cronContEMCSerNum_EMC_EMCSerNum` (`cronControlEducationalMaterialControlSerNum`),
  KEY `publishFlag` (`publishFlag`),
  CONSTRAINT `fk_cronContEM_cronContEMCSerNum_EMC_EMCSerNum` FOREIGN KEY (`cronControlEducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.cronControlPatient
CREATE TABLE IF NOT EXISTS `cronControlPatient` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `cronControlPatientSerNum` int(11) NOT NULL COMMENT 'Foreign key with PatientSerNum from patient control. Mandatory.',
  `cronType` varchar(100) NOT NULL COMMENT 'Field refers to what cron controller is using this transfer flag. eg TxTeamMessage, Document, Announcement, etc. Mandatory',
  `transferFlag` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Marker for data that needs to be read on next cron.',
  `lastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last transfer date. Updated after any given cron job finishes.',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` (`cronControlPatientSerNum`),
  KEY `cronType` (`cronType`),
  CONSTRAINT `fk_cronContPatient_cronContPatientSerNum_Patient_PatientSerNum` FOREIGN KEY (`cronControlPatientSerNum`) REFERENCES `PatientControl` (`PatientSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.cronControlPost
CREATE TABLE IF NOT EXISTS `cronControlPost` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `cronControlPostSerNum` int(11) NOT NULL COMMENT 'Foreign key with PostControlSerNum from PostControl. Mandatory.',
  `cronType` varchar(100) NOT NULL COMMENT 'Field refers to what cron controller is using this transfer flag. eg TxTeamMessages, Document, Announcement, etc. Mandatory',
  `publishFlag` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Marker for data that has been published from opalAdmin.',
  `lastPublished` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'Last publish date.',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sessionId` varchar(255) DEFAULT NULL COMMENT 'SessionId of the user who last updated this field.',
  PRIMARY KEY (`ID`),
  KEY `fk_cronContPost_cronContPostSerNum_PostControl_PostControlSerNum` (`cronControlPostSerNum`),
  KEY `cronType` (`cronType`),
  KEY `publishFlag` (`publishFlag`),
  CONSTRAINT `fk_cronContPost_cronContPostSerNum_PostControl_PostControlSerNum` FOREIGN KEY (`cronControlPostSerNum`) REFERENCES `PostControl` (`PostControlSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.CronDelayLog
CREATE TABLE IF NOT EXISTS `CronDelayLog` (
  `Date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Status` varchar(30) NOT NULL,
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.CronLog
CREATE TABLE IF NOT EXISTS `CronLog` (
  `CronLogSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronSerNum` int(11) NOT NULL,
  `CronStatus` varchar(25) NOT NULL,
  `CronDateTime` datetime NOT NULL,
  PRIMARY KEY (`CronLogSerNum`),
  KEY `CronSerNum` (`CronSerNum`),
  CONSTRAINT `CronLog_ibfk_1` FOREIGN KEY (`CronSerNum`) REFERENCES `Cron` (`CronSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1034354 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.customPushNotificationLog
CREATE TABLE IF NOT EXISTS `customPushNotificationLog` (
  `customPushNotificationID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` bigint(20) NOT NULL,
  `PatientDeviceIdentifierSerNum` bigint(20) NOT NULL,
  `SendStatus` varchar(3) NOT NULL,
  `NotificationTitle` varchar(100) NOT NULL,
  `NotificationMSG` text NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`customPushNotificationID`),
  KEY `idx_PatientSerNum` (`PatientSerNum`),
  KEY `idx_DateAdded` (`DateAdded`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Diagnosis
CREATE TABLE IF NOT EXISTS `Diagnosis` (
  `DiagnosisSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DiagnosisAriaSer` varchar(32) NOT NULL,
  `DiagnosisCode` varchar(50) NOT NULL,
  `Description_EN` varchar(200) NOT NULL,
  `Description_FR` varchar(255) NOT NULL,
  `Stage` varchar(32) DEFAULT NULL,
  `StageCriteria` varchar(32) DEFAULT NULL,
  `CreationDate` datetime NOT NULL,
  `createdBy` varchar(128) NOT NULL DEFAULT 'CronJob',
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(128) NOT NULL DEFAULT 'CronJob',
  PRIMARY KEY (`DiagnosisSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `DiagnosisAriaSer` (`DiagnosisAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `DiagnosisSerNum` (`DiagnosisSerNum`),
  KEY `DiagnosisCode` (`DiagnosisCode`),
  CONSTRAINT `Diagnosis_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DiagnosisCode
CREATE TABLE IF NOT EXISTS `DiagnosisCode` (
  `DiagnosisCodeSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `DiagnosisTranslationSerNum` int(11) NOT NULL,
  `SourceUID` int(11) NOT NULL,
  `Source` int(6) NOT NULL DEFAULT -1,
  `DiagnosisCode` varchar(100) NOT NULL,
  `Description` varchar(2056) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`DiagnosisCodeSerNum`),
  UNIQUE KEY `Source` (`SourceUID`,`Source`),
  KEY `DiagnosisTranslationSerNum` (`DiagnosisTranslationSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `DiagnosisCode` (`DiagnosisCode`),
  KEY `DiagnosisCode_ibfk_3` (`Source`),
  CONSTRAINT `DiagnosisCode_ibfk_1` FOREIGN KEY (`DiagnosisTranslationSerNum`) REFERENCES `DiagnosisTranslation` (`DiagnosisTranslationSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `DiagnosisCode_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `DiagnosisCode_ibfk_3` FOREIGN KEY (`Source`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=2685 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DiagnosisCodeMH
CREATE TABLE IF NOT EXISTS `DiagnosisCodeMH` (
  `DiagnosisTranslationSerNum` int(11) NOT NULL,
  `SourceUID` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `DiagnosisCode` varchar(100) NOT NULL,
  `Description` varchar(2056) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SourceUID`,`RevSerNum`),
  KEY `DiagnosisTranslationSerNum` (`DiagnosisTranslationSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DiagnosisMH
CREATE TABLE IF NOT EXISTS `DiagnosisMH` (
  `DiagnosisSerNum` int(11) NOT NULL,
  `RevisionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(128) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DiagnosisAriaSer` varchar(32) NOT NULL,
  `DiagnosisCode` varchar(50) NOT NULL,
  `Description_EN` varchar(200) NOT NULL,
  `Description_FR` varchar(255) NOT NULL,
  `Stage` varchar(32) DEFAULT NULL,
  `StageCriteria` varchar(32) DEFAULT NULL,
  `CreationDate` datetime NOT NULL,
  `createdBy` varchar(128) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(128) NOT NULL,
  PRIMARY KEY (`DiagnosisSerNum`,`RevisionSerNum`) USING BTREE,
  KEY `updatedBy` (`updatedBy`) USING BTREE,
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `DiagnosisAriaSer` (`DiagnosisAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DiagnosisTranslation
CREATE TABLE IF NOT EXISTS `DiagnosisTranslation` (
  `DiagnosisTranslationSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `AliasName` varchar(100) NOT NULL,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `Name_EN` varchar(2056) NOT NULL,
  `Name_FR` varchar(2056) NOT NULL,
  `Description_EN` varchar(2056) NOT NULL,
  `Description_FR` varchar(2056) NOT NULL,
  `DiagnosisCode` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DiagnosisTranslationSerNum`),
  KEY `DiagnosisCode` (`DiagnosisCode`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  CONSTRAINT `DiagnosisTranslation_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `DiagnosisTranslation_ibfk_2` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1159 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DiagnosisTranslationMH
CREATE TABLE IF NOT EXISTS `DiagnosisTranslationMH` (
  `DiagnosisTranslationSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `Name_EN` varchar(2056) NOT NULL,
  `Name_FR` varchar(2056) NOT NULL,
  `Description_EN` varchar(2056) NOT NULL,
  `Description_FR` varchar(2056) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DiagnosisTranslationSerNum`,`RevSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DNC
CREATE TABLE IF NOT EXISTS `DNC` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` bigint(20) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `DateAdded` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PatientSerNum` (`PatientSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='The purpose of this table is to keep track of Do Not Communicate by email.';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Doctor
CREATE TABLE IF NOT EXISTS `Doctor` (
  `DoctorSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `ResourceSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DoctorAriaSer` int(20) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Role` varchar(100) NOT NULL,
  `Workplace` varchar(100) NOT NULL,
  `Email` text DEFAULT NULL,
  `Phone` bigint(20) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `ProfileImage` varchar(255) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `BIO_EN` text DEFAULT NULL,
  `BIO_FR` text DEFAULT NULL,
  PRIMARY KEY (`DoctorSerNum`),
  KEY `DoctorAriaSer` (`DoctorAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `DoctorSerNum` (`DoctorSerNum`),
  KEY `ResourceSerNum` (`ResourceSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DoctorMH
CREATE TABLE IF NOT EXISTS `DoctorMH` (
  `DoctorSerNum` int(11) NOT NULL,
  `DoctorRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `ResourceSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DoctorAriaSer` int(20) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Role` varchar(100) NOT NULL,
  `Workplace` varchar(100) NOT NULL,
  `Email` text DEFAULT NULL,
  `Phone` int(20) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `ProfileImage` varchar(255) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `BIO_EN` text DEFAULT NULL,
  `BIO_FR` text DEFAULT NULL,
  PRIMARY KEY (`DoctorSerNum`,`DoctorRevSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Document
CREATE TABLE IF NOT EXISTS `Document` (
  `DocumentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DocumentId` varchar(100) NOT NULL,
  `AliasExpressionSerNum` int(11) NOT NULL,
  `ApprovedBySerNum` int(11) NOT NULL,
  `ApprovedTimeStamp` datetime NOT NULL,
  `AuthoredBySerNum` int(11) NOT NULL,
  `DateOfService` datetime NOT NULL,
  `Revised` varchar(5) NOT NULL,
  `ValidEntry` varchar(5) NOT NULL,
  `ErrorReasonText` text NOT NULL,
  `OriginalFileName` varchar(500) NOT NULL,
  `FinalFileName` varchar(500) NOT NULL,
  `CreatedBySerNum` int(11) NOT NULL,
  `CreatedTimeStamp` datetime NOT NULL,
  `TransferStatus` varchar(10) NOT NULL,
  `TransferLog` varchar(1000) NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `SessionId` text NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`DocumentSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `AliasExpressionSerNum` (`AliasExpressionSerNum`),
  KEY `ApprovedBySerNum` (`ApprovedBySerNum`),
  KEY `AuthoredBySerNum` (`AuthoredBySerNum`),
  KEY `CreatedBySerNum` (`CreatedBySerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `Document_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Document_ibfk_2` FOREIGN KEY (`AliasExpressionSerNum`) REFERENCES `AliasExpression` (`AliasExpressionSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Document_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Document_ibfk_4` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.DocumentMH
CREATE TABLE IF NOT EXISTS `DocumentMH` (
  `DocumentSerNum` int(11) NOT NULL,
  `DocumentRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `SessionId` text DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `DocumentId` varchar(100) NOT NULL,
  `AliasExpressionSerNum` int(11) NOT NULL,
  `ApprovedBySerNum` int(11) NOT NULL,
  `ApprovedTimeStamp` datetime NOT NULL,
  `AuthoredBySerNum` int(11) NOT NULL,
  `DateOfService` datetime NOT NULL,
  `Revised` varchar(5) NOT NULL,
  `ValidEntry` varchar(5) NOT NULL,
  `ErrorReasonText` text NOT NULL,
  `OriginalFileName` varchar(500) NOT NULL,
  `FinalFileName` varchar(500) NOT NULL,
  `CreatedBySerNum` int(11) NOT NULL,
  `CreatedTimeStamp` datetime NOT NULL,
  `TransferStatus` varchar(10) NOT NULL,
  `TransferLog` varchar(1000) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`DocumentSerNum`,`DocumentRevSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EducationalMaterial
CREATE TABLE IF NOT EXISTS `EducationalMaterial` (
  `EducationalMaterialSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialSerNum`),
  KEY `EducationalMaterialSerNum` (`EducationalMaterialControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `EducationalMaterial_ibfk_2` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EducationalMaterial_ibfk_3` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EducationalMaterial_ibfk_4` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EducationalMaterialControl
CREATE TABLE IF NOT EXISTS `EducationalMaterialControl` (
  `EducationalMaterialControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialType_EN` varchar(100) NOT NULL,
  `EducationalMaterialType_FR` varchar(100) NOT NULL,
  `PublishFlag` int(11) NOT NULL DEFAULT 0,
  `Name_EN` varchar(200) NOT NULL,
  `Name_FR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `URL_EN` varchar(2000) DEFAULT NULL,
  `URL_FR` varchar(2000) DEFAULT NULL,
  `URLType_EN` varchar(100) DEFAULT NULL,
  `URLType_FR` varchar(100) DEFAULT NULL,
  `ShareURL_EN` varchar(2000) DEFAULT NULL,
  `ShareURL_FR` varchar(2000) DEFAULT NULL,
  `PhaseInTreatmentSerNum` int(11) NOT NULL,
  `ParentFlag` int(11) NOT NULL DEFAULT 1,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EducationalMaterialControlSerNum`),
  KEY `PhaseInTreatmentSerNum` (`PhaseInTreatmentSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `PublishFlag` (`PublishFlag`),
  CONSTRAINT `EducationalMaterialControl_ibfk_1` FOREIGN KEY (`PhaseInTreatmentSerNum`) REFERENCES `PhaseInTreatment` (`PhaseInTreatmentSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=667 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EducationalMaterialMH
CREATE TABLE IF NOT EXISTS `EducationalMaterialMH` (
  `EducationalMaterialSerNum` int(11) NOT NULL,
  `EducationalMaterialRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialSerNum`,`EducationalMaterialRevSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EducationalMaterialPackageContent
CREATE TABLE IF NOT EXISTS `EducationalMaterialPackageContent` (
  `EducationalMaterialPackageContentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) NOT NULL COMMENT 'Material contained in a package.',
  `OrderNum` int(11) NOT NULL COMMENT 'Position of the material in the package, starting at 1.',
  `ParentSerNum` int(11) NOT NULL COMMENT 'EducationalMaterialControlSerNum of the parent package.',
  `DateAdded` datetime NOT NULL,
  `AddedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `LastUpdatedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`EducationalMaterialPackageContentSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `ParentSerNum` (`ParentSerNum`),
  KEY `LastUpdated` (`LastUpdated`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1 COMMENT='Directory of each material that is contained in an educational material package. No foreign keys to facilitate order changes.';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EducationalMaterialRating
CREATE TABLE IF NOT EXISTS `EducationalMaterialRating` (
  `EducationalMaterialRatingSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `RatingValue` tinyint(6) NOT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialRatingSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=348 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EducationalMaterialTOC
CREATE TABLE IF NOT EXISTS `EducationalMaterialTOC` (
  `EducationalMaterialTOCSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EducationalMaterialControlSerNum` int(11) NOT NULL,
  `OrderNum` int(11) NOT NULL,
  `ParentSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EducationalMaterialTOCSerNum`),
  KEY `EducationalMaterialSerNum` (`EducationalMaterialControlSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=548 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EmailControl
CREATE TABLE IF NOT EXISTS `EmailControl` (
  `EmailControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Subject_EN` varchar(100) NOT NULL,
  `Subject_FR` varchar(100) NOT NULL,
  `Body_EN` text NOT NULL,
  `Body_FR` text NOT NULL,
  `EmailTypeSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EmailControlSerNum`),
  KEY `EmailTypeSerNum` (`EmailTypeSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `EmailControl_ibfk_1` FOREIGN KEY (`EmailTypeSerNum`) REFERENCES `EmailType` (`EmailTypeSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EmailControl_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EmailControlMH
CREATE TABLE IF NOT EXISTS `EmailControlMH` (
  `EmailControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Subject_EN` varchar(100) NOT NULL,
  `Subject_FR` varchar(100) NOT NULL,
  `Body_EN` text NOT NULL,
  `Body_FR` text NOT NULL,
  `EmailTypeSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EmailControlSerNum`,`RevSerNum`),
  KEY `EmailTypeSerNum` (`EmailTypeSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EmailLog
CREATE TABLE IF NOT EXISTS `EmailLog` (
  `EmailLogSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `EmailControlSerNum` int(11) NOT NULL,
  `Status` varchar(5) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EmailLogSerNum`),
  KEY `EmailControlSerNum` (`EmailControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  CONSTRAINT `EmailLog_ibfk_1` FOREIGN KEY (`EmailControlSerNum`) REFERENCES `EmailControl` (`EmailControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EmailLog_ibfk_2` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `EmailLog_ibfk_3` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EmailLogMH
CREATE TABLE IF NOT EXISTS `EmailLogMH` (
  `EmailLogSerNum` int(11) NOT NULL,
  `EmailLogRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `EmailControlSerNum` int(11) NOT NULL,
  `Status` varchar(5) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  PRIMARY KEY (`EmailLogSerNum`,`EmailLogRevSerNum`),
  KEY `EmailControlSerNum` (`EmailControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.EmailType
CREATE TABLE IF NOT EXISTS `EmailType` (
  `EmailTypeSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `EmailTypeId` varchar(100) NOT NULL,
  `EmailTypeName` varchar(200) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EmailTypeSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for event OpalDB.evt_DatabaseMaintenance
DELIMITER //
CREATE EVENT `evt_DatabaseMaintenance` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-17 23:50:00' ON COMPLETION PRESERVE ENABLE DO BEGIN

-- Clean up the Patient Device Identifier table
call proc_CleanPatientDeviceIdentifier;

END//
DELIMITER ;

-- Dumping structure for table OpalDB.Feedback
CREATE TABLE IF NOT EXISTS `Feedback` (
  `FeedbackSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `FeedbackContent` varchar(255) DEFAULT NULL,
  `AppRating` tinyint(4) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`FeedbackSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  CONSTRAINT `Feedback_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Filters
CREATE TABLE IF NOT EXISTS `Filters` (
  `FilterSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `ControlTable` varchar(100) NOT NULL,
  `ControlTableSerNum` int(11) NOT NULL,
  `FilterType` varchar(100) NOT NULL,
  `FilterId` varchar(150) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`FilterSerNum`),
  KEY `FilterTableSerNum` (`ControlTableSerNum`),
  KEY `ControlTable` (`ControlTable`),
  KEY `FilterType` (`FilterType`)
) ENGINE=InnoDB AUTO_INCREMENT=796 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.FiltersMH
CREATE TABLE IF NOT EXISTS `FiltersMH` (
  `FilterSerNum` int(11) NOT NULL,
  `ControlTable` varchar(100) NOT NULL,
  `ControlTableSerNum` int(11) NOT NULL,
  `FilterType` varchar(100) NOT NULL,
  `FilterId` varchar(150) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  KEY `FilterTableSerNum` (`ControlTableSerNum`),
  KEY `FilterSerNum` (`FilterSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.FrequencyEvents
CREATE TABLE IF NOT EXISTS `FrequencyEvents` (
  `ControlTable` varchar(50) NOT NULL,
  `ControlTableSerNum` int(11) NOT NULL,
  `MetaKey` varchar(50) NOT NULL,
  `MetaValue` varchar(150) NOT NULL,
  `CustomFlag` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `ControlTable` (`ControlTable`,`ControlTableSerNum`,`MetaKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for procedure OpalDB.Generate_Test_Appointment2
DELIMITER //
CREATE PROCEDURE `Generate_Test_Appointment2`()
    COMMENT 'Create 1 blood appointment and 2 checkin appointment'
BEGIN




Select @GetTime1 := IfNull((Select max(ScheduledTime) from MediVisitAppointmentList where PatientSerNum = 827 and ScheduledDate = DATE_FORMAT(now(), '%Y-%m-%d')), '21:00:00') AS 'Current Time';


Select @GetTime1 := ADDTIME(@GetTime1,'0 00:02:00') AS 'Blood Test appt Time';


select @GetTime2 := ADDTIME(@GetTime1,'0 00:02:00') AS 'Hip Fracture appt Time';


select @GetTime3 := ADDTIME(@GetTime2,'0 00:02:00') AS 'Hip Fracture appt Time';


insert into MediVisitAppointmentList (PatientSerNum, Resource, ResourceDescription, ClinicResourcesSerNum, 
	ScheduledDateTime, ScheduledDate, ScheduledTime, AppointmentCode, AppointId, AppointIdIn, AppointSys, Status, LastUpdated, LastUpdatedUserIP)
values(827, 'NSBLD', 'NS - prise de sang/blood tests pre/post tx', 1357,
	concat(DATE_FORMAT(now(), '%Y-%m-%d'), ' ', @GetTime1 ), DATE_FORMAT(now(), '%Y-%m-%d'), @GetTime1, 'BLD-X', concat('OTES01161973-', DATE_FORMAT(now(), '%Y-%m-%d'), '-', @GetTime1),
	'InstantAddOn', 'InstantAddOn', 'Open', now(), '172.28.183.17');


insert into MediVisitAppointmentList (PatientSerNum, Resource, ResourceDescription, ClinicResourcesSerNum, 
	ScheduledDateTime, ScheduledDate, ScheduledTime, AppointmentCode, AppointId, AppointIdIn, AppointSys, Status, LastUpdated, LastUpdatedUserIP)
values(827, 'ADD-ON', 'Oncologie Traitement - Glen', 3213,
	concat(DATE_FORMAT(now(), '%Y-%m-%d'), ' ', @GetTime2), DATE_FORMAT(now(), '%Y-%m-%d'), @GetTime2, 'ADD-ON', concat('OTES01161973-', DATE_FORMAT(now(), '%Y-%m-%d'), '-', @GetTime2),
	'InstantAddOn', 'InstantAddOn', 'Open', now(), '172.28.183.17');


insert into MediVisitAppointmentList (PatientSerNum, Resource, ResourceDescription, ClinicResourcesSerNum, 
	ScheduledDateTime, ScheduledDate, ScheduledTime, AppointmentCode, AppointId, AppointIdIn, AppointSys, Status, LastUpdated, LastUpdatedUserIP)
values(827, 'ADD-ON', 'Oncologie Traitement - Glen', 3213,
	concat(DATE_FORMAT(now(), '%Y-%m-%d'), ' ', @GetTime3), DATE_FORMAT(now(), '%Y-%m-%d'), @GetTime3, 'ADD-ON', concat('OTES01161973-', DATE_FORMAT(now(), '%Y-%m-%d'), '-', @GetTime3),
	'InstantAddOn', 'InstantAddOn', 'Open', now(), '172.28.183.17');


select * from MediVisitAppointmentList where PatientSerNum = 827 order by ScheduledDateTime Desc limit 1000;


END//
DELIMITER ;

-- Dumping structure for function OpalDB.getDiagnosisDescription
DELIMITER //
CREATE FUNCTION `getDiagnosisDescription`(`in_DiagnosisCode` VARCHAR(100),
	`in_Language` VARCHAR(2)

) RETURNS varchar(2056) CHARSET latin1
    DETERMINISTIC
    COMMENT 'Return the description of the Diagnosis Code'
BEGIN
Declare wsReturn varchar(2056);
Declare wsLanguage varchar(2);
Declare wsDiagnosisCode varchar(100);


	set wsLanguage = in_Language;
	set wsDiagnosisCode = in_DiagnosisCode;
	
	if (wsLanguage = 'EN') then
	
		set wsReturn  = (select DT.Name_EN from DiagnosisCode DC, DiagnosisTranslation DT 
			where DC.DiagnosisTranslationSerNum = DT.DiagnosisTranslationSerNum
				and DC.DiagnosisCode = in_DiagnosisCode
			limit 1);
	
	else
	
		set wsReturn  = (select DT.Name_FR from DiagnosisCode DC, DiagnosisTranslation DT 
			where DC.DiagnosisTranslationSerNum = DT.DiagnosisTranslationSerNum
				and DC.DiagnosisCode = in_DiagnosisCode
			limit 1);
	
	end if;

	set wsReturn = (IfNull(wsReturn, 'N/A'));
	
	return wsReturn;
END//
DELIMITER ;

-- Dumping structure for function OpalDB.getLevel
DELIMITER //
CREATE FUNCTION `getLevel`(`in_DateTime` DATETIME,
	`in_Description` VARCHAR(255),
	`in_HospitalMap` INT
) RETURNS int(11)
    DETERMINISTIC
    COMMENT 'Get the RC or S1 level for the patient appointments'
BEGIN


	
	Declare wsDateTime DateTime;
	Declare wsDescription, wsCurrentHospitalMap, wsRCLevel, wsDSLevel VarChar(255);
	Declare wsDayOfWeek, wsBloodTest, wsDS_Area VarChar(3);
	Declare wsAMFM, wsReturnLevel VarChar(3);
	Declare wsReturnHospitalMap Int;
	
	
	set wsDateTime = in_DateTime;
	set wsDescription = in_Description;
	set wsCurrentHospitalMap = concat('|', IfNull(in_HospitalMap, ''), '|');

	
	set wsRCLevel = '|20|21|22|23|24|25|'; 
	set wsDSLevel = '|10|19|26|'; 

	
	set wsDayOfWeek = left(DAYNAME(ADDDATE(wsDateTime, INTERVAL 0 DAY)), 3);
	
	
	set wsAMFM = if(hour(ADDTIME(wsDateTime, '0 0:00:00')) >= 13, 'PM', 'AM');
	
	
	set wsBloodTest = 'No';
	set wsDS_Area = 'No';
	
	
	set wsBloodTest = if(ltrim(rtrim(wsDescription)) = 'NS - prise de sang/blood tests pre/post tx', 'Yes', 'No');

	
	if (wsBloodTest = 'No') then
		if (wsDescription like '.EBC%' 
			or wsDescription like '.EBP%'
			or wsDescription like '.EBM%'
			or wsDescription like 'CT%'
			or wsDescription like '.BXC%'
			or wsDescription like 'FOLLOW%'
			or wsDescription like 'F-U%'
			or wsDescription like 'CONSULT%'
			or wsDescription like 'Injection%'
			or wsDescription like 'Transfusion%'
			or wsDescription like 'Nursing Consult%'
			or wsDescription like 'INTRA%'
			or wsDescription like 'Hydration%') then
				if (
					(wsDescription <> 'CONSULT RETURN TELEMED') AND
					(wsDescription <> 'CONSULT NEW TELEMED') AND
					(wsDescription <> 'FOLLOW UP TELEMED LESS/30 DAYS') AND
					(wsDescription <> 'FOLLOW UP TELEMED MORE/30 DAYS') AND
					(wsDescription <> 'FU TELEMED LESS/30DAYS') AND
					(wsDescription <> 'FU TELEMED MORE/30DAYS') AND
					(wsDescription <> 'INTRA TREAT TELEMED')
					)then			
					set wsDS_Area = 'Yes';
				else
					set wsDS_Area = 'No';
				end if;
		else 
			set wsDS_Area = 'No';
		end if;
	end if;

	/*
	if ((wsBloodTest = 'No') and (wsDS_Area = 'No')) then
		
		
		
		set wsReturnLevel = 
			(SELECT Level 
				FROM WaitRoomManagementFED.DoctorSchedule USE INDEX (ID_ResourceNameDayAMPM)
				WHERE ResourceName = wsDescription
					AND DAY = wsDayOfWeek
					AND AMPM = wsAMFM
				limit 1);

		
		set wsReturnLevel = (IfNull(wsReturnLevel, 'N/A'));
		
	end if;
  */

	
	set wsReturnHospitalMap = -1;
	
	if ((wsBloodTest = 'Yes') and (wsDS_Area = 'No')) then
		set wsReturnHospitalMap = 23; 
	else 
		if ((wsBloodTest = 'No') and (wsDS_Area = 'Yes')) then
			set wsReturnHospitalMap = 19; 
		else
			
			if ( 	((wsReturnLevel = 'S1') and (instr(wsDSLevel, wsCurrentHospitalMap) > 0))  or  
					((wsReturnLevel = 'RC')  and (instr(wsRCLevel, wsCurrentHospitalMap) > 0)) or 
					((wsReturnLevel = 'N/A') and (wsCurrentHospitalMap <> '||')) ) then
				set wsReturnHospitalMap = in_HospitalMap; 
			else
				
				if (wsReturnLevel = 'S1') then
					set wsReturnHospitalMap = 19; 
				else
					if (wsReturnLevel = 'RC') then
						set wsReturnHospitalMap = 20; 
					end if;
				end if;
			end if;
			
		end if;
	end if;
	
	if (wsReturnHospitalMap = -1) then
		set wsReturnHospitalMap = 20; 
	end if;
	
 	Return wsReturnHospitalMap;

END//
DELIMITER ;

-- Dumping structure for procedure OpalDB.getPatientAppointmentsTableFields
DELIMITER //
CREATE PROCEDURE `getPatientAppointmentsTableFields`(
	IN `pUsername` VARCHAR(255),
	IN `pApptLastUpdated` VARCHAR(50),
	IN `pALastUpdated` VARCHAR(50),
	IN `pAELastUpdated` VARCHAR(50),
	IN `pRLastUpdated` VARCHAR(50),
	IN `pHMLastUpdated` VARCHAR(50)
)
BEGIN

SELECT DISTINCT Appt.AppointmentSerNum, 
        A.AliasSerNum, 
        IfNull(A.AliasName_EN, '') AS AppointmentType_EN, 
        IfNull(A.AliasName_FR, '') AS AppointmentType_FR, 
        IfNull(A.AliasDescription_EN, '') AS AppointmentDescription_EN, 
        IfNull(A.AliasDescription_FR, '') AS AppointmentDescription_FR, 
        IfNull(AE.Description, '') AS ResourceDescription, 
        Appt.ScheduledStartTime, 
        Appt.ScheduledEndTime, 
        Appt.Checkin, 
        Appt.AppointmentAriaSer, 
        Appt.ReadStatus, 
        R.ResourceName, 
        R.ResourceType, 
        IfNull(HM.MapUrl, '') AS MapUrl, 
        IfNull(HM.MapName_EN, '') AS MapName_EN, 
        IfNull(HM.MapName_FR, '') AS MapName_FR, 
        IfNull(HM.MapDescription_EN, '') AS MapDescription_EN, 
        IfNull(HM.MapDescription_FR, '') AS MapDescription_FR, 
        Appt.Status, 
        IfNull(Appt.RoomLocation_EN, '') AS RoomLocation_EN, 
        IfNull(Appt.RoomLocation_FR, '') AS RoomLocation_FR, 
        Appt.LastUpdated, 
        IfNull(emc.URL_EN, '') AS URL_EN, 
        IfNull(emc.URL_FR, '') AS URL_FR, 
        IfNull(AC.CheckinPossible, 0) AS CheckinPossible, 
        IfNull(AC.CheckinInstruction_EN, '') AS CheckinInstruction_EN, 
        IfNull(AC.CheckinInstruction_FR, '') AS CheckinInstruction_FR 
        
        FROM Patient P 
        
        INNER JOIN Users U ON U.UserTypeSerNum = P.PatientSerNum 
        INNER JOIN Appointment Appt ON Appt.PatientSerNum = P.PatientSerNum 
        INNER JOIN ResourceAppointment RA ON RA.AppointmentSerNum = Appt.AppointmentSerNum 
        INNER JOIN Resource R ON RA.ResourceSerNum = R.ResourceSerNum 
        INNER JOIN AliasExpression AE ON AE.AliasExpressionSerNum=Appt.AliasExpressionSerNum 
        INNER JOIN Alias A ON AE.AliasSerNum=A.AliasSerNum 
        LEFT JOIN HospitalMap HM ON HM.HospitalMapSerNum=A.HospitalMapSerNum 
        INNER JOIN AppointmentCheckin AC ON AE.AliasSerNum=AC.AliasSerNum 
        LEFT JOIN EducationalMaterialControl emc ON emc.EducationalMaterialControlSerNum = A.EducationalMaterialControlSerNum 
        
        WHERE 
				U.Username = 'a51fba18-3810-4808-9238-4d0e487785c8'
        AND Appt.State = 'Active' 
        AND (Appt.LastUpdated > '1970-01-01' OR A.LastUpdated > '1970-01-01' OR AE.LastUpdated > '1970-01-01' OR R.LastUpdated > '1970-01-01' OR HM.LastUpdated > '1970-01-01') 



        
        ORDER BY Appt.AppointmentSerNum, ScheduledStartTime;

END//
DELIMITER ;

-- Dumping structure for function OpalDB.getPatientSerNum
DELIMITER //
CREATE FUNCTION `getPatientSerNum`(`in_PatientId` VARCHAR(20)
) RETURNS int(11)
    DETERMINISTIC
BEGIN

	Declare wsPatientSerNum INT;
	
	set wsPatientSerNum = 0;
	
	select PatientSerNum	into wsPatientSerNum
	from Patient 
	where PatientId = in_PatientId 
	Limit 1;
	
	Return wsPatientSerNum;

END//
DELIMITER ;

-- Dumping structure for function OpalDB.getRefTableRowTitle
DELIMITER //
CREATE FUNCTION `getRefTableRowTitle`(`in_RefTableRowSerNum` INT,
	`in_NotificationRequestType` VARCHAR(50),
	`in_Language` VARCHAR(2)

) RETURNS varchar(2056) CHARSET latin1
    DETERMINISTIC
    COMMENT 'Return the title for the notification'
BEGIN

	Declare wsReturn varchar(2000);
	Declare wsLanguage varchar(2);
	Declare wsRefTableRowSerNum int;
	Declare wsNotificationRequestType varchar(50);
	
	Declare wsLanguage_EN, wsLanguage_FR varchar(2000);

	set wsReturn = '';
	set wsLanguage = in_Language;
	set wsRefTableRowSerNum = in_RefTableRowSerNum;
	set wsNotificationRequestType = in_NotificationRequestType;


	if (ucase(wsNotificationRequestType) = 'ALIAS') then
		Select A.AliasName_EN, A.AliasName_FR
			into wsLanguage_EN, wsLanguage_FR
		from Alias A, AliasExpression AE 
		where A.AliasSerNum = AE.AliasSerNum
			and AE.AliasExpressionSerNum = wsRefTableRowSerNum;
	end if;
	

	if (ucase(wsNotificationRequestType) = 'DOCUMENT') then
		Select A.AliasName_EN, A.AliasName_FR
			into wsLanguage_EN, wsLanguage_FR
		from Document D, Alias A, AliasExpression AE 
		where A.AliasSerNum = AE.AliasSerNum
			and AE.AliasExpressionSerNum = D.AliasExpressionSerNum
			and D.DocumentSerNum = wsRefTableRowSerNum;
	end if;


	if (ucase(wsNotificationRequestType) = 'APPOINTMENT') then
		Select A.AliasName_EN, A.AliasName_FR
			into wsLanguage_EN, wsLanguage_FR
		from Appointment Apt, Alias A, AliasExpression AE 
		where A.AliasSerNum = AE.AliasSerNum
			and AE.AliasExpressionSerNum = Apt.AliasExpressionSerNum
			and Apt.AppointmentSerNum = wsRefTableRowSerNum;
	end if;


	if (ucase(wsNotificationRequestType) = 'POST') then
		select PC.PostName_EN, PC.PostName_FR
			into wsLanguage_EN, wsLanguage_FR
		from PostControl PC
		where PC.PostControlSerNum = wsRefTableRowSerNum;
	end if;	


	if (ucase(wsNotificationRequestType) = 'EDUCATIONAL') then
		select EC.Name_EN, EC.Name_FR
			into wsLanguage_EN, wsLanguage_FR
		from 	EducationalMaterial E, EducationalMaterialControl EC
		where E.EducationalMaterialControlSerNum = EC.EducationalMaterialControlSerNum
			and E.EducationalMaterialSerNum = wsRefTableRowSerNum;
		
	end if;


	if (ucase(wsNotificationRequestType) = 'QUESTIONNAIRE') then
		select QC.QuestionnaireName_EN, QC.QuestionnaireName_FR
			into wsLanguage_EN, wsLanguage_FR
		from QuestionnaireControl QC
		where QC.QuestionnaireControlSerNum = wsRefTableRowSerNum;	
	end if;
		
	if (wsLanguage = 'EN') then	
		set wsReturn  = wsLanguage_EN;
	else
		set wsReturn  = wsLanguage_FR;
	end if;

	set wsReturn = (IfNull(wsReturn, ''));

	return wsReturn;
END//
DELIMITER ;

-- Dumping structure for function OpalDB.getTranslation
DELIMITER //
CREATE FUNCTION `getTranslation`(`in_TableName` VARCHAR(150),
	`in_ColumnName` VARCHAR(150),
	`in_Text` VARCHAR(250)
,
	`in_RecNo` BIGINT

) RETURNS varchar(250) CHARSET latin1
    DETERMINISTIC
BEGIN

  
  
	
	Declare wsTableName, wsColumnName, wsText, wsReturnText, wsReturn VarChar(255);
	Declare wsActive, wsCount int;
	Declare wsRecNo bigint;

	
	set wsTableName = in_TableName;
	set wsColumnName = in_ColumnName;
	set wsText = in_Text;
	set wsRecNo = in_RecNo;
	set wsActive = 0;
	set wsCount = 0;
	
	
	select count(*) Total, ifnull(TranslationReplace, '') TranslationReplace
	into wsCount, wsReturnText
	from Translation 
	where TranslationTableName = wsTableName 
		and TranslationColumnName = wsColumnName
		and TranslationCurrent = wsText
		and RefTableRecNo = wsRecNo
	Limit 1;
	
  
  
  	if (wsCount = 0) then
		set wsReturn = wsText;
	else
		set wsReturn = wsReturnText;
	end if;
	
	Return wsReturn;

END//
DELIMITER ;

-- Dumping structure for table OpalDB.HospitalMap
CREATE TABLE IF NOT EXISTS `HospitalMap` (
  `HospitalMapSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `MapUrl` varchar(255) DEFAULT NULL,
  `MapURL_EN` varchar(512) DEFAULT NULL,
  `MapURL_FR` varchar(512) DEFAULT NULL,
  `QRMapAlias` varchar(255) DEFAULT NULL,
  `QRImageFileName` varchar(255) NOT NULL,
  `MapName_EN` varchar(255) DEFAULT NULL,
  `MapDescription_EN` varchar(255) DEFAULT NULL,
  `MapName_FR` varchar(255) DEFAULT NULL,
  `MapDescription_FR` varchar(255) DEFAULT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`HospitalMapSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `HospitalMapSerNum` (`HospitalMapSerNum`),
  CONSTRAINT `HospitalMap_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.HospitalMapMH
CREATE TABLE IF NOT EXISTS `HospitalMapMH` (
  `HospitalMapSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `MapUrl` varchar(255) DEFAULT NULL,
  `MapURL_EN` varchar(512) DEFAULT NULL,
  `MapURL_FR` varchar(512) DEFAULT NULL,
  `QRMapAlias` varchar(255) DEFAULT NULL,
  `QRImageFileName` varchar(255) NOT NULL,
  `MapName_EN` varchar(255) DEFAULT NULL,
  `MapDescription_EN` varchar(255) DEFAULT NULL,
  `MapName_FR` varchar(255) DEFAULT NULL,
  `MapDescription_FR` varchar(255) DEFAULT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`HospitalMapSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Hospital_Identifier_Type
CREATE TABLE IF NOT EXISTS `Hospital_Identifier_Type` (
  `Hospital_Identifier_Type_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(20) NOT NULL,
  `ADT_Web_Service_Code` varchar(20) NOT NULL,
  `Description_EN` varchar(250) NOT NULL,
  `Description_FR` varchar(250) NOT NULL,
  PRIMARY KEY (`Hospital_Identifier_Type_Id`),
  UNIQUE KEY `HIT_code` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for function OpalDB.insertPatient
DELIMITER //
CREATE FUNCTION `insertPatient`(`i_FirstName` VARCHAR(50),
	`i_LastName` VARCHAR(50),
	`i_Sex` VARCHAR(25),
	`i_DateOfBirth` DATETIME,
	`i_TelNum` BIGINT,
	`i_SSN` VARCHAR(16)


) RETURNS bigint(20)
    DETERMINISTIC
    COMMENT 'Inserting Patient Record'
BEGIN

declare wsfirstName, wslastName, wssex, wsramqNumber, wsDOB varchar(100);
declare wshomePhoneNumber bigint;
declare wsPatientSerNum bigint;

set wsfirstName = i_FirstName;
set wslastName = i_LastName;
set wssex = i_Sex;
set wsramqNumber = ifnull(i_SSN, '');
set wsDOB = LEFT(i_DateOfBirth,10);
set wshomePhoneNumber = i_TelNum;
set wsPatientSerNum = -1;

if (wsramqNumber <> '') then

	set wsPatientSerNum = (select ifnull((select PatientSerNum from Patient where (SSN = wsramqNumber) limit 1), -1) as PatientSerNum);

	if (wsPatientSerNum < 0) then
		INSERT INTO Patient
			(FirstName,LastName,Sex,DateOfBirth,Age,TelNum,EnableSMS,SSN)
		VALUES (wsfirstName, wslastName, wssex, wsDOB, TIMESTAMPDIFF(year, wsDOB, now()), wshomePhoneNumber, 0, wsramqNumber);
		
		set wsPatientSerNum = (select ifnull((select PatientSerNum from Patient where (SSN = wsramqNumber) limit 1), -1) as PatientSerNum);
	else
		update Patient set FirstName = wsfirstName, LastName = wslastName, Sex=wssex , DateOfBirth=wsDOB, Age = TIMESTAMPDIFF(year, wsDOB, now()), TelNum=wshomePhoneNumber, SSN=wsramqNumber
		where PatientSerNum = wsPatientSerNum;
		
	end if;
	
end if;

Return wsPatientSerNum;

END//
DELIMITER ;

-- Dumping structure for table OpalDB.jsonTrigger
CREATE TABLE IF NOT EXISTS `jsonTrigger` (
  `ID` int(11) NOT NULL,
  `sourceContentId` int(11) NOT NULL,
  `sourceModuleId` varchar(50) NOT NULL,
  `description` tinytext DEFAULT NULL,
  `onCondition` mediumtext NOT NULL,
  `eventType` varchar(50) NOT NULL,
  `targetContentId` int(11) NOT NULL,
  `targetModuleId` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(50) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(50) NOT NULL,
  `sessionId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `SourceId` (`sourceContentId`),
  KEY `targetId` (`targetContentId`),
  KEY `targetModuleId` (`targetModuleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.language
CREATE TABLE IF NOT EXISTS `language` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Prefix` varchar(100) NOT NULL,
  `LanguageName_EN` varchar(200) NOT NULL,
  `LanguageName_FR` varchar(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Table to store language list.';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.list_patient
CREATE TABLE IF NOT EXISTS `list_patient` (
  `Patient_id` varchar(20) NOT NULL,
  `Site` varchar(10) NOT NULL,
  PRIMARY KEY (`Patient_id`,`Site`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.masterSourceAlias
CREATE TABLE IF NOT EXISTS `masterSourceAlias` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `externalId` varchar(512) NOT NULL DEFAULT '-1' COMMENT 'External ID from the other database',
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `f_externalId_code_source_type` (`externalId`,`code`,`source`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6016 DEFAULT CHARSET=latin1 COMMENT='Imported list of all the aliases from different sources';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.masterSourceDiagnosis
CREATE TABLE IF NOT EXISTS `masterSourceDiagnosis` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `externalId` varchar(512) NOT NULL DEFAULT '-1' COMMENT 'External ID from the other database',
  `code` varchar(256) NOT NULL COMMENT 'Diagnosis Code',
  `description` varchar(256) NOT NULL COMMENT 'Description of the diagnostic',
  `source` int(3) NOT NULL DEFAULT -1 COMMENT '-1 = no source type, 1 = Aria',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT 'has the data being deleted or not',
  `deletedBy` varchar(255) NOT NULL COMMENT 'username of who marked the record to be deleted',
  `creationDate` datetime NOT NULL COMMENT 'Date of creation of the record',
  `createdBy` varchar(255) NOT NULL COMMENT 'username of who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last time the record was updated',
  `updatedBy` varchar(255) NOT NULL COMMENT 'username of who updated the record',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `masterSourceDiagnosisKey` (`externalId`,`code`,`source`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1768 DEFAULT CHARSET=latin1 COMMENT='Imported list of all the diagnosis from different sources';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Messages
CREATE TABLE IF NOT EXISTS `Messages` (
  `MessageSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SenderRole` enum('Doctor','Patient','Admin') NOT NULL,
  `ReceiverRole` enum('Doctor','Patient','Admin') NOT NULL,
  `SenderSerNum` int(10) unsigned NOT NULL COMMENT 'Sender''s SerNum',
  `ReceiverSerNum` int(11) unsigned NOT NULL COMMENT 'Recipient''s SerNum',
  `MessageContent` varchar(255) NOT NULL,
  `ReadStatus` smallint(6) NOT NULL COMMENT 'Whether it  has been answered by the medical team',
  `Attachment` varchar(255) NOT NULL,
  `MessageDate` datetime NOT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`MessageSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.MessagesMH
CREATE TABLE IF NOT EXISTS `MessagesMH` (
  `MessageSerNum` int(11) NOT NULL DEFAULT 0,
  `MessageRevSerNum` int(6) NOT NULL AUTO_INCREMENT,
  `SessionId` text NOT NULL,
  `SenderRole` enum('Doctor','Patient','Admin') NOT NULL,
  `ReceiverRole` enum('Doctor','Patient','Admin') NOT NULL,
  `SenderSerNum` int(10) unsigned NOT NULL COMMENT 'Sender''s SerNum',
  `ReceiverSerNum` int(11) unsigned NOT NULL COMMENT 'Recipient''s SerNum',
  `MessageContent` varchar(255) NOT NULL,
  `ReadStatus` smallint(6) NOT NULL COMMENT 'Whether it  has been answered by the medical team',
  `Attachment` varchar(255) NOT NULL,
  `MessageDate` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`MessageSerNum`,`MessageRevSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.module
CREATE TABLE IF NOT EXISTS `module` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `operation` tinyint(1) NOT NULL DEFAULT 7 COMMENT 'List of available operations for the module (R/W/D)',
  `name_EN` varchar(512) NOT NULL COMMENT 'English name of the module',
  `name_FR` varchar(512) NOT NULL COMMENT 'French name of the module',
  `description_EN` varchar(512) NOT NULL COMMENT 'English description of the module',
  `description_FR` varchar(512) NOT NULL COMMENT 'French description of the module',
  `tableName` varchar(256) NOT NULL COMMENT 'Table name of the module in the DB',
  `controlTableName` varchar(256) NOT NULL COMMENT 'Table name for the control table field in the Filters table',
  `primaryKey` varchar(256) NOT NULL COMMENT 'Primary key of the table name',
  `iconClass` varchar(512) NOT NULL COMMENT 'Icon classes for html display',
  `url` varchar(255) NOT NULL COMMENT 'URL of the module. Used to generate the nav menus.',
  `subModule` longtext DEFAULT NULL COMMENT 'Contains all the submodule info in a JSON format',
  `subModuleMenu` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'If the module has submodules, can these being displayed in a navigation menu',
  `core` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'An essential module that can never being deactivated',
  `active` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the module active or not in opalAdmin',
  `categoryModuleId` bigint(20) DEFAULT NULL COMMENT 'Attach the module to a specific category',
  `publication` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the module is linked to the publication module',
  `customCode` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the module allows custom codes',
  `unique` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'To determine if an entry of the specified module can be published multiple times or not',
  `order` int(3) NOT NULL DEFAULT 999 COMMENT 'Order to display the list of modlues',
  `sqlPublicationList` longtext NOT NULL COMMENT 'SQL query to list the publications associated to the module',
  `sqlDetails` longtext NOT NULL COMMENT 'SQL query to list the details of a publication',
  `sqlPublicationChartLog` longtext NOT NULL COMMENT 'SQL query to list the chart log publications associated to the module',
  `sqlPublicationListLog` longtext NOT NULL COMMENT 'SQL query to list the detailled logs publications associated to the module',
  `sqlPublicationMultiple` longtext NOT NULL COMMENT 'When publication is not unique. use this field to list available publication',
  `sqlPublicationUnique` longtext NOT NULL COMMENT 'When publication is unique. use this field to list available publication',
  PRIMARY KEY (`ID`),
  KEY `fk_module_categoryModuleId_categoryModule_ID` (`categoryModuleId`),
  CONSTRAINT `fk_module_categoryModuleId_categoryModule_ID` FOREIGN KEY (`categoryModuleId`) REFERENCES `categoryModule` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.modulePublicationSetting
CREATE TABLE IF NOT EXISTS `modulePublicationSetting` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `moduleId` bigint(20) NOT NULL COMMENT 'Foreign key from the module table',
  `publicationSettingId` bigint(20) NOT NULL COMMENT 'Foreign key from the publicationSettings table',
  PRIMARY KEY (`ID`),
  KEY `fk_module_ID_modulePublicationSetting_moduleId_idx` (`moduleId`),
  KEY `fk_pubSetting_ID_modulePubSetting_pubSettingId_idx` (`publicationSettingId`),
  CONSTRAINT `fk_module_ID_moduleTriggerSetting_moduleId` FOREIGN KEY (`moduleId`) REFERENCES `module` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pubSetting_ID_modulePubSetting_pubSettingId` FOREIGN KEY (`publicationSettingId`) REFERENCES `publicationsetting` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='Intersection table between module and publicationSetting to reproduce a N-N relationships between the tables';

-- Data exporting was unselected.

-- Dumping structure for procedure OpalDB.my_memory
DELIMITER //
CREATE PROCEDURE `my_memory`()
    COMMENT 'Purpose of this procedure is to retrieve some basic MySQL stats'
BEGIN

# Yick Mo
# 2017-12-11
# 
# Got the information from this website
# URL: http://kedar.nitty-witty.com/blog/calculte-mysql-memory-usage-quick-stored-proc
#
# Retrieving from Global Variables and Global Session Variable (AKA Session Status)
#

DECLARE var VARCHAR(1000);
DECLARE val VARCHAR(1000);
DECLARE done INT;

#Variables for storing calculations
DECLARE GLOBAL_SUM DOUBLE;
DECLARE PER_THREAD_SUM DOUBLE;
DECLARE MAX_CONN DOUBLE;
DECLARE HEAP_TABLE DOUBLE;
DECLARE TEMP_TABLE DOUBLE;

#Variables from current session
DECLARE wsLOG_TIME BIGINT;
DECLARE wsABORTED_CLIENTS DOUBLE;
DECLARE wsABORTED_CONNECTS DOUBLE;
DECLARE wsCONNECTIONS DOUBLE;
DECLARE wsMAX_USED_CONNECTIONS DOUBLE;
DECLARE wsSLOW_QUERIES DOUBLE;
DECLARE wsTHREADS_CACHED DOUBLE;
DECLARE wsTHREADS_CONNECTED DOUBLE;
DECLARE wsTHREADS_CREATED DOUBLE;
DECLARE wsTHREADS_RUNNING DOUBLE;

#Cursor for Global Variables

#### For < MySQL 5.1 
#### DECLARE CUR_GBLVAR CURSOR FOR SHOW GLOBAL VARIABLES;

#### For MySQL 5.1+
DECLARE CUR_GBLVAR CURSOR FOR SELECT * FROM information_schema.GLOBAL_VARIABLES;
#### Ref: http://bugs.mysql.com/bug.php?id=49758

#### DECLARE CUR_SESVAR CURSOR FOR SHOW GLOBAL SESSION VARIABLES;
DECLARE CUR_SESVAR CURSOR FOR SELECT * FROM information_schema.SESSION_STATUS;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

# Initialize all variables
SET GLOBAL_SUM=0;
SET PER_THREAD_SUM=0;
SET MAX_CONN=0;
SET HEAP_TABLE=0;
SET TEMP_TABLE=0;

SET wsLOG_TIME=0;
SET wsABORTED_CLIENTS=0;
SET wsABORTED_CONNECTS=0;
SET wsCONNECTIONS=0;
SET wsMAX_USED_CONNECTIONS=0;
SET wsSLOW_QUERIES=0;
SET wsTHREADS_CACHED=0;
SET wsTHREADS_CONNECTED=0;
SET wsTHREADS_CREATED=0;
SET wsTHREADS_RUNNING=0;

# Begin looping GLobal Variables
OPEN CUR_GBLVAR;
mylp:LOOP
      FETCH CUR_GBLVAR INTO var,val;
  IF done=1 THEN
    LEAVE mylp;
  END IF;
    IF var in ('key_buffer_size','innodb_buffer_pool_size','innodb_additional_mem_pool_size','innodb_log_buffer_size','query_cache_size') THEN
    #Summing Up Global Memory Usage
      SET GLOBAL_SUM=GLOBAL_SUM+val;
    ELSEIF var in ('read_buffer_size','read_rnd_buffer_size','sort_buffer_size','join_buffer_size','thread_stack','max_allowed_packet','net_buffer_length') THEN
    #Summing Up Per Thread Memory Variables
      SET PER_THREAD_SUM=PER_THREAD_SUM+val;
    ELSEIF var in ('max_connections') THEN
    #Maximum allowed connections
      SET MAX_CONN=val;
    ELSEIF var in ('max_heap_table_size') THEN
    #Size of Max Heap tables created
      SET HEAP_TABLE=val;
    #Size of possible Temporary Table = Maximum of tmp_table_size / max_heap_table_size.
    ELSEIF var in ('tmp_table_size','max_heap_table_size') THEN
      SET TEMP_TABLE=if((TEMP_TABLE>val),TEMP_TABLE,val);
    END IF;

END LOOP;
CLOSE CUR_GBLVAR;
# End looping GLobal Variables

# Reset the LOOP back to zero because one indicate it that the loop is completed
set done = 0;
# Begin looping GLobal Session Variables
OPEN CUR_SESVAR;
mylp:LOOP
      FETCH CUR_SESVAR INTO var,val;
  IF done=1 THEN
    LEAVE mylp;
  END IF;
  	IF var in ('ABORTED_CLIENTS') then 
		set wsABORTED_CLIENTS = val;
	ELSEIF var in ('ABORTED_CONNECTS') then
		set wsABORTED_CONNECTS = val;
	ELSEIF var in ('CONNECTIONS') then
		set wsCONNECTIONS = val;
	ELSEIF var in ('MAX_USED_CONNECTIONS') then
		set wsMAX_USED_CONNECTIONS = val;
	ELSEIF var in ('SLOW_QUERIES') then
		set wsSLOW_QUERIES = val;
	ELSEIF var in ('THREADS_CACHED') then
		set wsTHREADS_CACHED = val;
	ELSEIF var in ('THREADS_CONNECTED') then
		set wsTHREADS_CONNECTED = val;
	ELSEIF var in ('THREADS_CREATED') then
		set wsTHREADS_CREATED = val;
	ELSEIF var in ('THREADS_RUNNING') then	
		set wsTHREADS_CREATED = val;
		
	END IF;

END LOOP;

CLOSE CUR_SESVAR;
# End looping GLobal Session Variables

Set wsLOG_TIME = (select UNIX_TIMESTAMP());

#Summerizing:
select "Log Time" as "Parameter", from_unixtime(wsLOG_TIME) as "Value" union
select "Global Buffers",CONCAT(GLOBAL_SUM/(1024*1024),' M') union
select "Per Thread",CONCAT(PER_THREAD_SUM/(1024*1024),' M')  union
select "Maximum Connections",MAX_CONN union
select "Total Memory Usage",CONCAT((GLOBAL_SUM + (MAX_CONN * PER_THREAD_SUM))/(1024*1024),' M') union
select "+ Per Heap Table",CONCAT(HEAP_TABLE / (1024*1024),' M') union
select "+ Per Temp Table",CONCAT(TEMP_TABLE / (1024*1024),' M') union
select "Aborted Clients", wsABORTED_CLIENTS union
select "Aborted Connects", wsABORTED_CONNECTS union
select "Connections", wsCONNECTIONS union
select "Max Used Connection", wsMAX_USED_CONNECTIONS union
select "Slow Queries", wsSLOW_QUERIES union
select "Thread Cached", wsTHREADS_CACHED union
select "Thread Connected", wsTHREADS_CONNECTED union
select "Threads Created", wsTHREADS_CREATED union
select "Threads Running", wsTHREADS_RUNNING union
SELECT "Timestamp", wsLOG_TIME;

END//
DELIMITER ;

-- Dumping structure for table OpalDB.Notification
CREATE TABLE IF NOT EXISTS `Notification` (
  `NotificationSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `NotificationControlSerNum` int(11) NOT NULL,
  `RefTableRowSerNum` int(11) NOT NULL,
  `DateAdded` datetime DEFAULT NULL,
  `ReadStatus` tinyint(1) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `RefTableRowTitle_EN` varchar(500) NOT NULL,
  `RefTableRowTitle_FR` varchar(500) NOT NULL,
  PRIMARY KEY (`NotificationSerNum`),
  KEY `NotificationControlSerNum` (`NotificationControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `RefTableRowSerNum` (`RefTableRowSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `Notification_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Notification_ibfk_2` FOREIGN KEY (`NotificationControlSerNum`) REFERENCES `NotificationControl` (`NotificationControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Notification_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8610 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.NotificationControl
CREATE TABLE IF NOT EXISTS `NotificationControl` (
  `NotificationControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(100) NOT NULL,
  `Name_FR` varchar(100) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_FR` text NOT NULL,
  `NotificationType` varchar(100) NOT NULL,
  `NotificationTypeSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastPublished` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`NotificationControlSerNum`),
  KEY `NotificationTypeSerNum` (`NotificationTypeSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `NotificationControl_ibfk_1` FOREIGN KEY (`NotificationTypeSerNum`) REFERENCES `NotificationTypes` (`NotificationTypeSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `NotificationControl_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.NotificationControlMH
CREATE TABLE IF NOT EXISTS `NotificationControlMH` (
  `NotificationControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(100) NOT NULL,
  `Name_FR` varchar(100) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_FR` text NOT NULL,
  `NotificationTypeSerNum` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`NotificationControlSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.NotificationMH
CREATE TABLE IF NOT EXISTS `NotificationMH` (
  `NotificationSerNum` int(11) NOT NULL,
  `NotificationRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `NotificationControlSerNum` int(11) NOT NULL,
  `RefTableRowSerNum` int(11) NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `RefTableRowTitle_EN` varchar(500) NOT NULL,
  `RefTableRowTitle_FR` varchar(500) NOT NULL,
  PRIMARY KEY (`NotificationSerNum`,`NotificationRevSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `NotificationControlSerNum` (`NotificationControlSerNum`),
  KEY `RefTableRowSerNum` (`RefTableRowSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.NotificationTypes
CREATE TABLE IF NOT EXISTS `NotificationTypes` (
  `NotificationTypeSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `NotificationTypeId` varchar(100) NOT NULL,
  `NotificationTypeName` varchar(200) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`NotificationTypeSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.OAActivityLog
CREATE TABLE IF NOT EXISTS `OAActivityLog` (
  `ActivitySerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Activity` varchar(255) NOT NULL,
  `OAUserSerNum` int(11) NOT NULL,
  `SessionId` varchar(255) NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`ActivitySerNum`),
  KEY `OAUserSerNum` (`OAUserSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=13214 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.oaRole
CREATE TABLE IF NOT EXISTS `oaRole` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment',
  `name_EN` varchar(64) NOT NULL COMMENT 'English name of the role',
  `name_FR` varchar(64) NOT NULL COMMENT 'French name of the role',
  `deleted` int(1) NOT NULL DEFAULT 0 COMMENT 'has the data being deleted or not',
  `deletedBy` varchar(255) NOT NULL COMMENT 'username of who marked the record to be deleted',
  `creationDate` datetime NOT NULL COMMENT 'Date of creation of the record',
  `createdBy` varchar(255) NOT NULL COMMENT 'username of who created the record',
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last time the record was updated',
  `updatedBy` varchar(255) NOT NULL COMMENT 'username of who updated the record',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.oaRoleModule
CREATE TABLE IF NOT EXISTS `oaRoleModule` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment',
  `moduleId` bigint(20) NOT NULL COMMENT 'Module ID',
  `oaRoleId` bigint(20) NOT NULL COMMENT 'OA Role ID',
  `access` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Access level level (0-7) for this role on this module',
  PRIMARY KEY (`ID`),
  KEY `fk_oaRoleModule_oaRoleId_oaRole_ID_idx` (`oaRoleId`),
  KEY `fk_oaRoleModule_moduleId_module_ID_idx` (`moduleId`),
  CONSTRAINT `fk_oaRoleModule_moduleId_module_ID` FOREIGN KEY (`moduleId`) REFERENCES `module` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_oaRoleModule_oaRoleId_oaRole_ID` FOREIGN KEY (`oaRoleId`) REFERENCES `oaRole` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.OAUser
CREATE TABLE IF NOT EXISTS `OAUser` (
  `OAUserSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(1000) NOT NULL,
  `Password` varchar(1000) NOT NULL,
  `oaRoleId` bigint(20) NOT NULL DEFAULT 1 COMMENT 'Role of the user',
  `type` tinyint(1) DEFAULT 1 COMMENT 'Type of user. 1 = ''human'' user. 2 = ''system'' user',
  `Language` enum('EN','FR') NOT NULL DEFAULT 'EN',
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`OAUserSerNum`),
  KEY `fk_OAUser_oaRoleId_oaRole_ID` (`oaRoleId`),
  CONSTRAINT `fk_OAUser_oaRoleId_oaRole_ID` FOREIGN KEY (`oaRoleId`) REFERENCES `oaRole` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Patient
CREATE TABLE IF NOT EXISTS `Patient` (
  `PatientSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientAriaSer` int(11) NOT NULL,
  `PatientId` varchar(50) NOT NULL,
  `PatientId2` varchar(50) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Alias` varchar(100) DEFAULT NULL,
  `ProfileImage` longtext DEFAULT NULL,
  `Sex` varchar(25) NOT NULL,
  `DateOfBirth` datetime NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `TelNum` bigint(11) DEFAULT NULL,
  `EnableSMS` tinyint(4) NOT NULL DEFAULT 0,
  `Email` varchar(50) NOT NULL,
  `Language` enum('EN','FR','SN') NOT NULL,
  `SSN` varchar(16) NOT NULL,
  `AccessLevel` enum('1','2','3') NOT NULL DEFAULT '1',
  `RegistrationDate` datetime NOT NULL DEFAULT '2018-01-01 00:00:00',
  `ConsentFormExpirationDate` datetime DEFAULT NULL,
  `BlockedStatus` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'to block user on Firebase',
  `StatusReasonTxt` text NOT NULL,
  `DeathDate` datetime DEFAULT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `TestUser` tinyint(4) NOT NULL DEFAULT 0,
  `TermsAndAgreementSign` tinyint(4) DEFAULT NULL,
  `TermsAndAgreementSignDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`PatientSerNum`),
  KEY `PatientAriaSer` (`PatientAriaSer`),
  KEY `PatientSerNum` (`PatientSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientActionLog
CREATE TABLE IF NOT EXISTS `PatientActionLog` (
  `PatientActionLogSerNum` bigint(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `Action` varchar(125) NOT NULL DEFAULT '' COMMENT 'Action the user took.',
  `RefTable` varchar(125) NOT NULL DEFAULT '' COMMENT 'Table containing the item that was acted upon.',
  `RefTableSerNum` int(11) NOT NULL COMMENT 'SerNum identifying the item in RefTable.',
  `ActionTime` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Timestamp when the user took the action.',
  PRIMARY KEY (`PatientActionLogSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `RefTable` (`RefTable`),
  KEY `ActionTime` (`ActionTime`),
  CONSTRAINT `PatientActionLog_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=940 DEFAULT CHARSET=latin1 COMMENT='Log of the actions a user takes in the app (clicking, scrolling to bottom, etc.)';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientActivityLog
CREATE TABLE IF NOT EXISTS `PatientActivityLog` (
  `ActivitySerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Request` varchar(255) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `DeviceId` varchar(255) NOT NULL COMMENT 'This will have information about the previous and current values of fields',
  `SessionId` text NOT NULL,
  `DateTime` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `AppVersion` varchar(50) NOT NULL,
  PRIMARY KEY (`ActivitySerNum`),
  KEY `ID_Request` (`Request`),
  KEY `ID_Username` (`Username`),
  KEY `ID_DateTime` (`DateTime`),
  KEY `ID_AppVersion` (`AppVersion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientControl
CREATE TABLE IF NOT EXISTS `PatientControl` (
  `PatientSerNum` int(11) NOT NULL,
  `PatientUpdate` int(11) NOT NULL DEFAULT 1,
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `TransferFlag` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`PatientSerNum`),
  KEY `TransferFlag_IDX` (`TransferFlag`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PatientUpdate` (`PatientUpdate`),
  CONSTRAINT `PatientControl_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientDeviceIdentifier
CREATE TABLE IF NOT EXISTS `PatientDeviceIdentifier` (
  `PatientDeviceIdentifierSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `DeviceId` varchar(255) NOT NULL,
  `RegistrationId` varchar(256) NOT NULL,
  `DeviceType` tinyint(4) NOT NULL,
  `appVersion` varchar(16) DEFAULT NULL COMMENT 'Version of Opal App installed on patient device. Eg 1.10.9. Optional.',
  `SessionId` text NOT NULL,
  `SecurityAnswerSerNum` int(11) DEFAULT NULL,
  `Attempt` int(11) NOT NULL,
  `Trusted` tinyint(1) NOT NULL DEFAULT 0,
  `TimeoutTimestamp` timestamp NULL DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientDeviceIdentifierSerNum`),
  UNIQUE KEY `patient_device` (`PatientSerNum`,`DeviceId`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `SecurityAnswerSerNum` (`SecurityAnswerSerNum`),
  CONSTRAINT `PatientDeviceIdentifier_ibfk_2` FOREIGN KEY (`SecurityAnswerSerNum`) REFERENCES `SecurityAnswer` (`SecurityAnswerSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientDeviceIdentifier_ibfk_3` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientDoctor
CREATE TABLE IF NOT EXISTS `PatientDoctor` (
  `PatientDoctorSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `DoctorSerNum` int(11) NOT NULL,
  `OncologistFlag` int(11) NOT NULL,
  `PrimaryFlag` int(11) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientDoctorSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `DoctorSerNum` (`DoctorSerNum`),
  KEY `OncologistFlag` (`OncologistFlag`),
  KEY `PrimaryFlag` (`PrimaryFlag`),
  CONSTRAINT `PatientDoctor_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientDoctor_ibfk_2` FOREIGN KEY (`DoctorSerNum`) REFERENCES `Doctor` (`DoctorSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientHospitalIdentifier
CREATE TABLE IF NOT EXISTS `PatientHospitalIdentifier` (
  `PatientSerNum` int(11) NOT NULL,
  `Mrn` varchar(50) NOT NULL,
  `Site` varchar(50) NOT NULL,
  `ExpirayDate` date DEFAULT NULL,
  `Active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`PatientSerNum`,`Mrn`,`Site`),
  CONSTRAINT `FK_HospitalPatientIdentity_Patient` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientLocation
CREATE TABLE IF NOT EXISTS `PatientLocation` (
  `PatientLocationSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `SourceUID` int(11) NOT NULL,
  `AppointmentSerNum` int(11) NOT NULL,
  `RevCount` int(11) NOT NULL,
  `CheckedInFlag` tinyint(4) NOT NULL,
  `ArrivalDateTime` datetime NOT NULL,
  `VenueSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientLocationSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `SourceUID` (`SourceUID`),
  KEY `AppointmentSerNum` (`AppointmentSerNum`),
  KEY `RevCount` (`RevCount`),
  KEY `CheckedInFlag` (`CheckedInFlag`),
  KEY `VenueSerNum` (`VenueSerNum`),
  CONSTRAINT `PatientLocation_ibfk_2` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientLocation_ibfk_3` FOREIGN KEY (`AppointmentSerNum`) REFERENCES `Appointment` (`AppointmentSerNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1023 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientLocationMH
CREATE TABLE IF NOT EXISTS `PatientLocationMH` (
  `PatientLocationMHSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `SourceUID` int(11) NOT NULL,
  `AppointmentSerNum` int(11) NOT NULL,
  `RevCount` int(11) NOT NULL,
  `CheckedInFlag` tinyint(4) NOT NULL,
  `ArrivalDateTime` datetime NOT NULL,
  `VenueSerNum` int(11) NOT NULL,
  `HstryDateTime` datetime NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientLocationMHSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `SourceUID` (`SourceUID`),
  KEY `AppointmentSerNum` (`AppointmentSerNum`),
  KEY `RevCount` (`RevCount`),
  KEY `CheckedInFlag` (`CheckedInFlag`),
  KEY `VenueSerNum` (`VenueSerNum`),
  CONSTRAINT `PatientLocationMH_ibfk_2` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientLocationMH_ibfk_3` FOREIGN KEY (`AppointmentSerNum`) REFERENCES `Appointment` (`AppointmentSerNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5433 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientMH
CREATE TABLE IF NOT EXISTS `PatientMH` (
  `PatientSerNum` int(11) NOT NULL,
  `PatientRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SessionId` text DEFAULT NULL,
  `PatientAriaSer` int(11) NOT NULL,
  `PatientId` varchar(50) NOT NULL,
  `PatientId2` varchar(50) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Alias` varchar(100) DEFAULT NULL,
  `Sex` varchar(25) NOT NULL,
  `DateOfBirth` datetime NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `TelNum` bigint(11) DEFAULT NULL,
  `EnableSMS` tinyint(4) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Language` enum('EN','FR','SN') NOT NULL,
  `SSN` text NOT NULL,
  `AccessLevel` enum('1','2','3') NOT NULL,
  `RegistrationDate` datetime NOT NULL,
  `ConsentFormExpirationDate` datetime DEFAULT NULL,
  `BlockedStatus` tinyint(4) NOT NULL DEFAULT 0,
  `StatusReasonTxt` text NOT NULL,
  `DeathDate` datetime DEFAULT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientSerNum`,`PatientRevSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientsForPatients
CREATE TABLE IF NOT EXISTS `PatientsForPatients` (
  `PatientsForPatientsSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientsForPatientsSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `PatientsForPatients_ibfk_1` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientsForPatients_ibfk_2` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientsForPatients_ibfk_3` FOREIGN KEY (`PostControlSerNum`) REFERENCES `PostControl` (`PostControlSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientsForPatientsMH
CREATE TABLE IF NOT EXISTS `PatientsForPatientsMH` (
  `PatientsForPatientsSerNum` int(11) NOT NULL,
  `PatientsForPatientsRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientsForPatientsSerNum`,`PatientsForPatientsRevSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostControlSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientsForPatientsPersonnel
CREATE TABLE IF NOT EXISTS `PatientsForPatientsPersonnel` (
  `PatientsForPatientsPersonnelSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Bio_EN` text NOT NULL,
  `Bio_FR` text NOT NULL,
  `Website` varchar(100) NOT NULL,
  `ProfileImage` varchar(255) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientsForPatientsPersonnelSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientsForPatientsPersonnelMH
CREATE TABLE IF NOT EXISTS `PatientsForPatientsPersonnelMH` (
  `PatientsForPatientsPersonnelSerNum` int(11) NOT NULL,
  `PatientsForPatientsPersonnelRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` int(11) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Bio_EN` text NOT NULL,
  `Bio_FR` text NOT NULL,
  `Website` varchar(100) NOT NULL,
  `ProfileImage` varchar(255) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientsForPatientsPersonnelSerNum`,`PatientsForPatientsPersonnelRevSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.patientStudy
CREATE TABLE IF NOT EXISTS `patientStudy` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key. Auto-increment.',
  `patientId` int(11) NOT NULL COMMENT 'Foreign key with PatientSerNum in Patient table',
  `studyId` bigint(20) NOT NULL COMMENT 'Foreign key with Id in study table.',
  `consentStatus` int(11) NOT NULL COMMENT 'Patient consent status for this study. 1 = invited; 2 = opalConsented; 3 = otherConsented; 4 = declined. Mandatory.',
  `readStatus` int(11) NOT NULL COMMENT 'Patient read status for this consent form.',
  PRIMARY KEY (`ID`),
  KEY `fk_patientStudy_patientId_Patient_PatientSerNum_idx` (`patientId`),
  KEY `fk_patientStudy_patientId_study_ID_idx` (`studyId`),
  CONSTRAINT `fk_patientStudy_patientId_Patient_PatientSerNum` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`PatientSerNum`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patientStudy_patientId_study_ID` FOREIGN KEY (`studyId`) REFERENCES `study` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientTestResult
CREATE TABLE IF NOT EXISTS `PatientTestResult` (
  `PatientTestResultSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `TestGroupExpressionSerNum` int(11) DEFAULT NULL,
  `TestExpressionSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `AbnormalFlag` varchar(10) NOT NULL,
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
  `ReadStatus` int(11) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientTestResultSerNum`),
  UNIQUE KEY `PatientTestCodeTestDate` (`PatientSerNum`,`TestExpressionSerNum`,`CollectedDateTime`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `TestResultExpressionSerNum` (`TestExpressionSerNum`),
  KEY `TestResultGroupSerNum` (`TestGroupExpressionSerNum`),
  CONSTRAINT `FK_PatientTestResult_TestExpression` FOREIGN KEY (`TestExpressionSerNum`) REFERENCES `TestExpression` (`TestExpressionSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `FK_PatientTestResult_TestGroupExpression` FOREIGN KEY (`TestGroupExpressionSerNum`) REFERENCES `TestGroupExpression` (`TestGroupExpressionSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1396100 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PatientVerifyOpalVsOacis
CREATE TABLE IF NOT EXISTS `PatientVerifyOpalVsOacis` (
  `Mrn` varchar(20) NOT NULL,
  `Site` varchar(20) NOT NULL,
  `LastNameInOacis` varchar(50) DEFAULT NULL,
  `LastNameInOpal` varchar(50) DEFAULT NULL,
  `FirstNameInOacis` varchar(50) DEFAULT NULL,
  `FirstNameInOpal` varchar(50) DEFAULT NULL,
  `RamqInOacis` varchar(20) DEFAULT NULL,
  `RamqInOpal` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Mrn`,`Site`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Patient_Hospital_Identifier
CREATE TABLE IF NOT EXISTS `Patient_Hospital_Identifier` (
  `Patient_Hospital_Identifier_Id` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `Hospital_Identifier_Type_Code` varchar(20) NOT NULL,
  `MRN` varchar(20) NOT NULL,
  `Is_Active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Patient_Hospital_Identifier_Id`),
  UNIQUE KEY `IX_PatientHospitalIdentifier` (`PatientSerNum`,`Hospital_Identifier_Type_Code`,`MRN`),
  KEY `FK_HPI_HospIdType` (`Hospital_Identifier_Type_Code`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `MRN` (`MRN`),
  FULLTEXT KEY `IdxSiteMrn` (`Hospital_Identifier_Type_Code`,`MRN`),
  CONSTRAINT `FK_HPI_HospIdType` FOREIGN KEY (`Hospital_Identifier_Type_Code`) REFERENCES `Hospital_Identifier_Type` (`Code`),
  CONSTRAINT `FK_HPI_Patient` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=5616 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PhaseInTreatment
CREATE TABLE IF NOT EXISTS `PhaseInTreatment` (
  `PhaseInTreatmentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(200) NOT NULL,
  `Name_FR` varchar(200) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PhaseInTreatmentSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PlanWorkflow
CREATE TABLE IF NOT EXISTS `PlanWorkflow` (
  `PlanWorkflowSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PlanSerNum` int(11) NOT NULL,
  `OrderNum` int(11) NOT NULL,
  `Type` varchar(255) NOT NULL,
  `TypeSerNum` int(11) NOT NULL,
  `PublishedName_EN` varchar(255) NOT NULL,
  `PublishedName_FR` varchar(255) NOT NULL,
  `PublishedDescription_EN` varchar(255) NOT NULL,
  `PublishedDescription_FR` varchar(255) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PlanWorkflowSerNum`),
  UNIQUE KEY `PlanSerNum` (`PlanSerNum`,`OrderNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PostControl
CREATE TABLE IF NOT EXISTS `PostControl` (
  `PostControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PostType` varchar(100) NOT NULL,
  `PublishFlag` int(11) NOT NULL DEFAULT 0,
  `PostName_FR` varchar(100) NOT NULL,
  `PostName_EN` varchar(100) NOT NULL,
  `Body_FR` text NOT NULL,
  `Body_EN` text NOT NULL,
  `PublishDate` datetime DEFAULT NULL,
  `Disabled` tinyint(1) NOT NULL DEFAULT 0,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PostControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `PostType` (`PostType`),
  KEY `PublishFlag` (`PublishFlag`),
  KEY `PostControlSerNum` (`PostControlSerNum`),
  CONSTRAINT `PostControl_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PostControlMH
CREATE TABLE IF NOT EXISTS `PostControlMH` (
  `PostControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PostType` varchar(100) NOT NULL,
  `PublishFlag` int(11) NOT NULL DEFAULT 0,
  `PostName_FR` varchar(100) NOT NULL,
  `PostName_EN` varchar(100) NOT NULL,
  `Body_FR` text NOT NULL,
  `Body_EN` text NOT NULL,
  `PublishDate` datetime DEFAULT NULL,
  `Disabled` tinyint(1) NOT NULL DEFAULT 0,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PostControlSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Priority
CREATE TABLE IF NOT EXISTS `Priority` (
  `PrioritySerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `PriorityAriaSer` int(11) NOT NULL,
  `PriorityDateTime` datetime NOT NULL,
  `PriorityCode` varchar(25) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PrioritySerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for procedure OpalDB.proc_CleanPatientDeviceIdentifier
DELIMITER //
CREATE PROCEDURE `proc_CleanPatientDeviceIdentifier`()
BEGIN
/****************************************************************************************************
Purpose: This stored procedure is to remove records from the table PatientDeviceIdentifier with
the following condition. 
1. Any device type = 3 will be deleted. Device type 3 are generated by the browsers
2. Any registration ID that is empty
3. Any test accounts that are over a specified date

Reason: 
1. Remove useless records that is not in use. Especially caused by testing.
2. People change cell phones
3. Updating the app changles the device ID
4. Some tester are actually real patient
****************************************************************************************************/

/****************************************************************************************************
Remove any device type 3 or empty registration ID
****************************************************************************************************/
delete from PatientDeviceIdentifier
where DeviceType = 3
	or isnull(RegistrationId)
	or trim(RegistrationId) = ''
;

/****************************************************************************************************
Remove old push notification that were sent to test accounts
****************************************************************************************************/
delete from PushNotification 
where PatientDeviceIdentifierSerNum in 
	(Select PatientDeviceIdentifierSerNum from PatientDeviceIdentifier
	where LastUpdated <= DATE_SUB(curdate(), INTERVAL 14 DAY)
		and PatientSerNum in 
		(select PatientSerNum from Patient
		where PatientID in ('9999996', '3333', 'AAAA1', '1092300', '5324122', 'Opal6', 'Opal1',
			'Opal2', 'Opal5', 'Opal4', 'Opal3', 'QA_0630', 'QA_ DAW_APP_HEAD',
			'Opal4temp', '9999993', '9999997', 'OpalDemo1', '9999995', '9999992', '9999991'
			)
		)
	)
;

/****************************************************************************************************
Remove any records that are older than specified date
****************************************************************************************************/
delete from PatientDeviceIdentifier
where LastUpdated <= DATE_SUB(curdate(), INTERVAL 14 DAY)
	and PatientSerNum in 
	(select PatientSerNum from Patient
	where PatientID in ('9999996', '3333', 'AAAA1', '1092300', '5324122', 'Opal6', 'Opal1',
		'Opal2', 'Opal5', 'Opal4', 'Opal3', 'QA_0630', 'QA_ DAW_APP_HEAD',
		'Opal4temp', '9999993', '9999997', 'OpalDemo1', '9999995', '9999992', '9999991'
		)
	)
;

END//
DELIMITER ;

-- Dumping structure for table OpalDB.publicationSetting
CREATE TABLE IF NOT EXISTS `publicationSetting` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name_EN` varchar(512) NOT NULL COMMENT 'English name of the setting',
  `name_FR` varchar(512) NOT NULL COMMENT 'French name of the setting',
  `internalName` varchar(512) NOT NULL COMMENT 'Name of the field for the triggers when processing the data on the backend and frontend',
  `isTrigger` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the setting a trigger (1) or something else (0)',
  `isUnique` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is the setting can have only one unique value (1) or not (0)',
  `selectAll` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Can the setting (mostly a trigger) has an "All" (1) value or not (0)',
  `opalDB` mediumtext NOT NULL COMMENT 'SQL or table name from the opalDB to get or insert the data. Note: if the ariaDB field is filled, it must be run before this one.',
  `opalPK` varchar(512) NOT NULL COMMENT 'Primary key used for the opalDB field',
  `custom` mediumtext NOT NULL COMMENT 'This field contains JSON format data for custom settings (like for age and sex for example)',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='This table list all the different settings a publication can have.';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.PushNotification
CREATE TABLE IF NOT EXISTS `PushNotification` (
  `PushNotificationSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientDeviceIdentifierSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `NotificationControlSerNum` int(11) NOT NULL,
  `RefTableRowSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `SendStatus` varchar(3) NOT NULL,
  `SendLog` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PushNotificationSerNum`),
  KEY `PatientDeviceIdentifierSerNum` (`PatientDeviceIdentifierSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `NotificationControlSerNum` (`NotificationControlSerNum`),
  KEY `RefTableRowSerNum` (`RefTableRowSerNum`),
  CONSTRAINT `PushNotification_ibfk_3` FOREIGN KEY (`PatientDeviceIdentifierSerNum`) REFERENCES `PatientDeviceIdentifier` (`PatientDeviceIdentifierSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=108750 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Questionnaire
CREATE TABLE IF NOT EXISTS `Questionnaire` (
  `QuestionnaireSerNum` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `QuestionnaireControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `PatientQuestionnaireDBSerNum` int(11) DEFAULT NULL,
  `CompletedFlag` tinyint(4) NOT NULL,
  `CompletionDate` datetime DEFAULT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`QuestionnaireSerNum`),
  KEY `QuestionnaireControlSerNum` (`QuestionnaireControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientQuestionnaireDBSerNum` (`PatientQuestionnaireDBSerNum`),
  CONSTRAINT `Questionnaire_ibfk_1` FOREIGN KEY (`QuestionnaireControlSerNum`) REFERENCES `QuestionnaireControl` (`QuestionnaireControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Questionnaire_ibfk_2` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Questionnaire_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=897 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.QuestionnaireControl
CREATE TABLE IF NOT EXISTS `QuestionnaireControl` (
  `QuestionnaireControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionnaireDBSerNum` int(11) NOT NULL,
  `QuestionnaireName_EN` varchar(2056) NOT NULL,
  `QuestionnaireName_FR` varchar(2056) NOT NULL,
  `Intro_EN` text NOT NULL,
  `Intro_FR` text NOT NULL,
  `PublishFlag` tinyint(4) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`QuestionnaireControlSerNum`),
  KEY `QuestionnaireDBSerNum` (`QuestionnaireDBSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `PublishFlag` (`PublishFlag`),
  KEY `QuestionnaireControlSerNum` (`QuestionnaireControlSerNum`),
  CONSTRAINT `QuestionnaireControl_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.QuestionnaireControlMH
CREATE TABLE IF NOT EXISTS `QuestionnaireControlMH` (
  `QuestionnaireControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionnaireDBSerNum` int(11) NOT NULL,
  `QuestionnaireName_EN` varchar(2056) NOT NULL,
  `QuestionnaireName_FR` varchar(2056) NOT NULL,
  `Intro_EN` text NOT NULL,
  `Intro_FR` text NOT NULL,
  `PublishFlag` tinyint(4) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastPublished` datetime NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`QuestionnaireControlSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.QuestionnaireControlNewMH
CREATE TABLE IF NOT EXISTS `QuestionnaireControlNewMH` (
  `serNum` int(11) unsigned NOT NULL,
  `rev_serNum` int(11) NOT NULL AUTO_INCREMENT,
  `name_EN` varchar(128) NOT NULL,
  `name_FR` varchar(128) NOT NULL,
  `private` tinyint(1) NOT NULL,
  `publish` tinyint(1) NOT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_updated_by` int(11) unsigned DEFAULT NULL,
  `created_by` int(11) unsigned NOT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `modification_action` varchar(25) NOT NULL,
  PRIMARY KEY (`serNum`,`rev_serNum`),
  KEY `last_updated_by` (`last_updated_by`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.QuestionnaireMH
CREATE TABLE IF NOT EXISTS `QuestionnaireMH` (
  `QuestionnaireSerNum` int(11) NOT NULL,
  `QuestionnaireRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `QuestionnaireControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `PatientQuestionnaireDBSerNum` int(11) DEFAULT NULL,
  `CompletedFlag` tinyint(4) NOT NULL,
  `CompletionDate` datetime DEFAULT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  PRIMARY KEY (`QuestionnaireSerNum`,`QuestionnaireRevSerNum`),
  KEY `QuestionnaireControlSerNum` (`QuestionnaireControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientQuestionnaireDBSerNum` (`PatientQuestionnaireDBSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.questionnaireStudy
CREATE TABLE IF NOT EXISTS `questionnaireStudy` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `studyId` bigint(20) NOT NULL,
  `questionnaireId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_questionnaireStudy_study_id_study_ID` (`studyId`),
  KEY `questionnaireId` (`questionnaireId`),
  CONSTRAINT `fk_questionnaireStudy_study_id_study_ID` FOREIGN KEY (`studyId`) REFERENCES `study` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for procedure OpalDB.reg_BranchSearch
DELIMITER //
CREATE PROCEDURE `reg_BranchSearch`(
	IN `in_Branch` VARCHAR(515)
)
BEGIN

	declare wsBranchID varchar(515);
	declare wsReturn varchar(50);
	declare wsRAMQ varchar(50);
	declare wsRegistrationCode varchar(50);
	declare wsPatientSerNum bigint;
	declare wsStatus varchar(50);

	set wsBranchID = in_Branch;
	set @wsRAMQ = null;
	set @wsPatientSerNum = null;
	set @wsRegistrationCode = null;
	set @wsStatus = null;
	
	if wsBranchID is not null then		
		
		prepare stmt from 
		'Select R.PatientSerNum, R.RegistrationCode, R.`Status`
		into @wsPatientSerNum, @wsRegistrationCode, @wsStatus
		from registerdb.registrationcode R
		where R.FirebaseBranch = ?'
		;

		set @A = wsBranchID;
		
		EXECUTE stmt USING @A;
		DEALLOCATE PREPARE stmt;
		
		if @wsRegistrationCode is not null then
			
			prepare stmt2 from
			'Select P.SSN
			into @wsRAMQ
			from OpalDB.Patient P
			where P.PatientSerNum = ?'
			;
			
			
			set @A = @wsPatientSerNum;
			EXECUTE stmt2 USING @A;
			DEALLOCATE PREPARE stmt2;
			
			if @wsRAMQ is NULL then
				set @wsStatus = 'UNKNOWN CODE';
			end if;
			
		else

			set @wsStatus = 'UNKNOWN BRANCH';
		end if;
		
	else
	
		set @wsStatus = 'MISSING INFO';
		
	end if;
	
	Select @wsRegistrationCode as RegistrationCode, @wsRAMQ as RAMQ, @wsStatus as Status;



END//
DELIMITER ;

-- Dumping structure for procedure OpalDB.reg_getAccessLevelList
DELIMITER //
CREATE PROCEDURE `reg_getAccessLevelList`(
	IN `i_RAMQ` VARCHAR(20)

)
    COMMENT 'Procedure to get accesslevel data.'
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;


set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select Id, AccessLevelName_EN, AccessLevelName_FR from accesslevel order by Id;
else 
Select 0 AS Error;
end if;
END//
DELIMITER ;

-- Dumping structure for procedure OpalDB.reg_getLanguageList
DELIMITER //
CREATE PROCEDURE `reg_getLanguageList`(
	IN `i_RAMQ` VARCHAR(20)

)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;


set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select Id,Prefix, LanguageName_EN, LanguageName_FR from language order by Id;
else 
Select 0 AS Error;
end if;
END//
DELIMITER ;

-- Dumping structure for procedure OpalDB.reg_getSecurityQuestions
DELIMITER //
CREATE PROCEDURE `reg_getSecurityQuestions`(
	IN `i_RAMQ` VARCHAR(20)


)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;


set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select SecurityQuestionSerNum, QuestionText_EN, QuestionText_FR from SecurityQuestion where Active = 1 order by SecurityQuestionSerNum;
else 
Select 0 AS Error;
end if;
END//
DELIMITER ;

-- Dumping structure for procedure OpalDB.reg_getTermsandAggrementDocuments
DELIMITER //
CREATE PROCEDURE `reg_getTermsandAggrementDocuments`(
	IN `i_RAMQ` VARCHAR(20)

)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;


set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select Id,DocumentLink_EN, DocumentLink_FR, PDFLink_EN, PDFLink_FR from termsandagreement where Active = 1 order by Id;
else 
Select 0 AS Error;
end if;
END//
DELIMITER ;

-- Dumping structure for procedure OpalDB.reg_getUserName
DELIMITER //
CREATE PROCEDURE `reg_getUserName`(
	IN `i_RAMQ` VARCHAR(20)
)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;


set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select FirstName,LastName from Patient as result where SSN = wsRAMQ;
else 
Select 0 AS Error;
end if;
END//
DELIMITER ;

-- Dumping structure for function OpalDB.reg_insertPatientHospitalIdentifier
DELIMITER //
CREATE FUNCTION `reg_insertPatientHospitalIdentifier`(`i_PatientSerNum` BIGINT,
	`i_Mrn` VARCHAR(50),
	`i_Site` VARCHAR(50)
) RETURNS varchar(50) CHARSET latin1
    DETERMINISTIC
BEGIN

	declare wsPatientSerNum bigint;
	declare wsMrn VARCHAR(50);
	declare wsSite VARCHAR(50);
	
	declare wsCount int;
	declare wsReturn int;
	
	set wsPatientSerNum = i_PatientSerNum;
	set wsMrn = i_Mrn;
	set wsSite = i_Site;
	
	set wsCount = -1;
	SET wsReturn = -1;
	SET wsCount = (SELECT COUNT(*) FROM Patient_Hospital_Identifier where MRN = wsMrn and Hospital_Identifier_Type_Code = wsSite AND Is_Active = 1);

	if (wsCount > 0) then
		SET wsReturn = -1;
	else
		insert into Patient_Hospital_Identifier(PatientSerNum, MRN, Hospital_Identifier_Type_Code) values (wsPatientSerNum, wsMrn, wsSite);
		SET wsReturn = 1; --  (SELECT COUNT(*) FROM Patient_Hospital_Identifier where PatientSerNum = wsPatientSerNum);
	END if;

 return wsReturn;



END//
DELIMITER ;

-- Dumping structure for function OpalDB.reg_UpdatePatientInfo
DELIMITER //
CREATE FUNCTION `reg_UpdatePatientInfo`(`i_RAMQ` VARCHAR(20),
	`i_Email` CHAR(50),
	`i_Password` VARCHAR(255),
	`i_UniqueID` VARCHAR(255),
	`i_SecurityQuestion1` INT,
	`i_Answer1` VARCHAR(1000),
	`i_SecurityQuestion2` INT,
	`i_Answer2` VARCHAR(1000),
	`i_SecurityQuestion3` INT,
	`i_Answer3` VARCHAR(1000),
	`i_Language` VARCHAR(2),
	`i_AccessLevelID` BIGINT,
	`i_AccessLevelSign` TINYINT,
	`i_TermsAndAgreementID` BIGINT,
	`i_TermsAndAgreementSign` TINYINT
) RETURNS varchar(100) CHARSET latin1
    DETERMINISTIC
BEGIN

	Declare wsSecurityQuestion1, wsSecurityQuestion2, wsSecurityQuestion3, wsAccessLevelID INT;
	Declare wsAnswer1, wsAnswer2, wsAnswer3 VARCHAR(1000);
	Declare wsPassword,wsUniqueID  VARCHAR(255);
	Declare wsRAMQ VARCHAR(20);
	Declare wsEmail CHAR(50);
	Declare wsLanguage VARCHAR(2);
	Declare wsTermsAndAgreementSign, wsAccessLevelSign TINYINT;
	Declare wsPatientSerNum, wsTermsAndAgreementID BIGINT;
	Declare wsValid,wsPass int;
	Declare wsStatus VARCHAR(100);
	
	set wsPass = 0;
	set wsValid = 0;	
	set wsRAMQ = IfNull(i_RAMQ, 'Error');
	set wsEmail = ifNull(i_Email, '');
	set wsPassword = IfNull(i_Password, '');
	set wsUniqueId = Ifnull(i_UniqueId,'');
	set wsSecurityQuestion1 = ifnull(i_SecurityQuestion1,0);
   set wsAnswer1 = ifnull(i_Answer1,'');
   set wsSecurityQuestion2 = ifnull(i_SecurityQuestion2,0);
   set wsAnswer2 = ifnull(i_Answer2,'');
   set wsSecurityQuestion3 = ifnull(i_SecurityQuestion3,0);
   set wsAnswer3 = ifnull(i_Answer3,'');
   set wsLanguage = ifnull(i_Language,'');
   set wsAccessLevelID = ifnull(i_AccessLevelID,0);
   set wsAccessLevelSign = ifnull(i_AccessLevelSign,0);
	set wsTermsAndAgreementID = ifnull(i_TermsAndAgreementID,0);
	set wsTermsAndAgreementSign = ifnull(i_TermsAndAgreementSign,0);
   

	set wsValid = (select count(*) from Patient where SSN = wsRAMQ);
	
	if (wsValid = 1) then

		set wsPatientSerNum = (select PatientSerNum from Patient where SSN = wsRAMQ);
		
		update Patient set Email = wsEmail, `Language` = wsLanguage, `AccessLevel` = wsAccessLevelID, SessionId='Opalmedapps' , RegistrationDate = NOW(), ConsentFormExpirationDate = Date_add(Now(), interval 1 year), `TermsAndAgreementSign`=wsTermsAndAgreementSign, TermsAndAgreementSignDateTime = NOW()
		where PatientSerNum = wsPatientSerNum;
		
		
		Insert Into Users (UserType, UserTypeSerNum, Username, `Password`, SessionId)
		Values ('Patient', wsPatientSerNum, wsUniqueId, wsPassword, 'Opalmedapps');
		
		Insert Into SecurityAnswer (SecurityQuestionSerNum, PatientSerNum, AnswerText, CreationDate)
		Values (wsSecurityQuestion1, wsPatientSerNum, wsAnswer1, NOW());
		
		Insert Into SecurityAnswer (SecurityQuestionSerNum, PatientSerNum, AnswerText, CreationDate)
		Values (wsSecurityQuestion2, wsPatientSerNum, wsAnswer2, NOW());

		Insert Into SecurityAnswer (SecurityQuestionSerNum, PatientSerNum, AnswerText, CreationDate)
		Values (wsSecurityQuestion3, wsPatientSerNum, wsAnswer3, NOW());

		Insert Into PatientControl(PatientSerNum) Values(wsPatientSerNum);
		
		Insert Into registerdb.accesslevelconsent (PatientSerNum, AccessLevelId, AccessLevelSign, AccessLevelSignDateTime, CreationDate)
		Values (wsPatientSerNum, wsAccessLevelId, wsAccessLevelSign, now(), now() );
		
		Insert Into registerdb.termsandagreementsign (PatientSerNum, TermsAndAgreementID, `TermsAndAgreementSign`, TermsAndAgreementSignDateTime)
		Values (wsPatientSerNum, wsTermsAndAgreementID, wsTermsAndAgreementSign, now() );

		Update registerdb.registrationcode
		Set `Status` = 'Completed', DeleteBranch = 2
		where PatientSerNum = wsPatientSerNum and `Status` = 'New';
		
		set wsStatus = 'Successfully Update';		
 	else
		set wsStatus = 'Failed to Update';
	end if;

	return wsStatus;

END//
DELIMITER ;

-- Dumping structure for procedure OpalDB.RemovePatient
DELIMITER //
CREATE PROCEDURE `RemovePatient`(
	IN `in_PatientSSN` CHAR(50)
)
    COMMENT 'Remove Patient from the database'
BEGIN



SET FOREIGN_KEY_CHECKS=0;


CREATE TEMPORARY TABLE tempPatientSerNum
select PatientSerNum, PatientAriaSer, PatientId, Email, SSN from Patient where SSN = in_PatientSSN;
CREATE TEMPORARY TABLE tempAppointment
select AppointmentSerNum from Appointment where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
CREATE TEMPORARY TABLE tempUser
Select * from Users where UserTypeSerNum in (select PatientSerNum from tempPatientSerNum);


Delete from SecurityAnswer where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from AnnouncementMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Announcement where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from AppointmentMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Appointment where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete From CheckinLog where AppointmentSerNum in (select AppointmentSerNum from tempAppointment);
Delete from Diagnosis where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from DocumentMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Document where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from EducationalMaterialRating where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from EducationalMaterialMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from EducationalMaterial where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Feedback where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from MessagesMH where SenderSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from MessagesMH where ReceiverSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Messages where SenderSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Messages where ReceiverSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from NotificationMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Notification where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from PatientActivityLog where Username in (select Username from tempUser);
Delete from PatientControl where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from PatientDeviceIdentifier where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from PatientDoctor where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from PatientLocationMH where AppointmentSerNum in (select AppointmentSerNum from tempAppointment);
Delete from PatientLocation where AppointmentSerNum in (select AppointmentSerNum from tempAppointment);
Delete from PatientsForPatientsMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from PatientsForPatients where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from PushNotification where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from QuestionnaireMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Questionnaire where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from ResourceAppointment where AppointmentSerNum in (select AppointmentSerNum from tempAppointment);
Delete from TaskMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Task where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from TestResultMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from TestResult where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from TxTeamMessageMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from TxTeamMessage where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from UsersMH where UserTypeSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Users where UserTypeSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from PatientMH where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Patient_Hospital_Identifier where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from Patient where PatientSerNum in (select PatientSerNum from tempPatientSerNum);
Delete from cronControlPatient where cronControlPatientSerNum in (select PatientSerNum from tempPatientSerNum);

drop table tempPatientSerNum;
drop table tempAppointment;
drop table tempUser;


SET FOREIGN_KEY_CHECKS=1;

END//
DELIMITER ;

-- Dumping structure for table OpalDB.Resource
CREATE TABLE IF NOT EXISTS `Resource` (
  `ResourceSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `ResourceAriaSer` int(11) NOT NULL,
  `ResourceCode` varchar(128) NOT NULL,
  `ResourceName` varchar(255) NOT NULL,
  `ResourceType` varchar(1000) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ResourceSerNum`),
  KEY `ResourceAriaSer` (`ResourceAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `ResourceSerNum` (`ResourceSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.ResourceAppointment
CREATE TABLE IF NOT EXISTS `ResourceAppointment` (
  `ResourceAppointmentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `ResourceSerNum` int(11) NOT NULL,
  `AppointmentSerNum` int(11) NOT NULL,
  `ExclusiveFlag` varchar(11) NOT NULL,
  `PrimaryFlag` varchar(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ResourceAppointmentSerNum`),
  UNIQUE KEY `ResourceAppointment` (`ResourceSerNum`,`AppointmentSerNum`),
  KEY `AppointmentSerNum` (`AppointmentSerNum`),
  KEY `ResourceSerNum` (`ResourceSerNum`),
  CONSTRAINT `ResourceAppointment_ibfk_1` FOREIGN KEY (`AppointmentSerNum`) REFERENCES `Appointment` (`AppointmentSerNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4695 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.resourcePending
CREATE TABLE IF NOT EXISTS `resourcePending` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `sourceName` varchar(128) NOT NULL,
  `appointmentId` bigint(20) NOT NULL,
  `resources` mediumtext NOT NULL,
  `level` tinyint(4) NOT NULL DEFAULT 1,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `sourceAppointment` (`sourceName`,`appointmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=946 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.resourcePendingError
CREATE TABLE IF NOT EXISTS `resourcePendingError` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `sourceName` varchar(128) NOT NULL,
  `appointmentId` bigint(20) NOT NULL,
  `resources` mediumtext NOT NULL,
  `level` tinyint(4) NOT NULL DEFAULT 1,
  `error` mediumtext NOT NULL,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.resourcePendingMH
CREATE TABLE IF NOT EXISTS `resourcePendingMH` (
  `resourcePendingId` bigint(20) NOT NULL,
  `revisionId` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` varchar(128) NOT NULL,
  `sourceName` varchar(128) NOT NULL,
  `appointmentId` bigint(20) NOT NULL,
  `resources` mediumtext NOT NULL,
  `level` tinyint(4) NOT NULL DEFAULT 1,
  `creationDate` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedBy` varchar(255) NOT NULL,
  PRIMARY KEY (`resourcePendingId`,`revisionId`) USING BTREE,
  KEY `updatedBy` (`updatedBy`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Role
CREATE TABLE IF NOT EXISTS `Role` (
  `RoleSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`RoleSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.SecurityAnswer
CREATE TABLE IF NOT EXISTS `SecurityAnswer` (
  `SecurityAnswerSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SecurityQuestionSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `AnswerText` varchar(2056) NOT NULL,
  `CreationDate` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`SecurityAnswerSerNum`),
  UNIQUE KEY `SecurityQuestionSerNum` (`SecurityQuestionSerNum`,`PatientSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `idx_SecurityQuestionSerNum` (`SecurityQuestionSerNum`),
  CONSTRAINT `SecurityAnswer_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SecurityAnswer_ibfk_2` FOREIGN KEY (`SecurityQuestionSerNum`) REFERENCES `SecurityQuestion` (`SecurityQuestionSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=582 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.SecurityQuestion
CREATE TABLE IF NOT EXISTS `SecurityQuestion` (
  `SecurityQuestionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionText_EN` varchar(2056) NOT NULL,
  `QuestionText_FR` varchar(2056) NOT NULL,
  `CreationDate` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Active` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 = Disable / 1 = Enable',
  PRIMARY KEY (`SecurityQuestionSerNum`),
  KEY `Index 2` (`Active`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.SMSSurvey
CREATE TABLE IF NOT EXISTS `SMSSurvey` (
  `SMSSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SentToNumber` bigint(11) NOT NULL,
  `Provider` text NOT NULL,
  `ReceivedInTime` text NOT NULL,
  `SubmissionTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`SMSSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.SourceDatabase
CREATE TABLE IF NOT EXISTS `SourceDatabase` (
  `SourceDatabaseSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseName` varchar(255) NOT NULL,
  `Enabled` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`SourceDatabaseSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Staff
CREATE TABLE IF NOT EXISTS `Staff` (
  `StaffSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `StaffId` varchar(11) NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`StaffSerNum`),
  KEY `StaffId` (`StaffId`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=779 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.StatusAlias
CREATE TABLE IF NOT EXISTS `StatusAlias` (
  `StatusAliasSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Expression` varchar(45) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`StatusAliasSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  CONSTRAINT `StatusAlias_ibfk_1` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.study
CREATE TABLE IF NOT EXISTS `study` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `consentQuestionnaireId` bigint(20) DEFAULT NULL COMMENT 'QuestionnaireDB questionnaire ID of the consent form for this study. Foreign key field. Mandatory.',
  `code` varchar(64) DEFAULT NULL COMMENT 'Study ID entered by the user. Mandatory.',
  `title_EN` varchar(256) DEFAULT NULL COMMENT 'English title of the study. Mandatory.',
  `title_FR` varchar(256) DEFAULT NULL COMMENT 'French title of the study. Mandatory.',
  `description_EN` text DEFAULT NULL COMMENT 'English description of the study. Mandatory.',
  `description_FR` text DEFAULT NULL COMMENT 'French description of the study. Mandatory.',
  `investigator` varchar(256) DEFAULT NULL COMMENT 'Principal investigator of the study. Mandatory.',
  `email` varchar(128) DEFAULT NULL COMMENT 'Principal investigator email address of the study. Mandatory.',
  `phone` varchar(25) DEFAULT NULL COMMENT 'Principal investigator phone number of the study. Mandatory.',
  `phoneExt` varchar(10) DEFAULT NULL COMMENT 'Principal investigator phone number extension. Optional.',
  `startDate` date DEFAULT NULL COMMENT 'Start date of the study. Optional.',
  `endDate` date DEFAULT NULL COMMENT 'End date of the study. Optional.',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Mark the record as deleted (1) or not (0)',
  `creationDate` datetime NOT NULL COMMENT 'Date and time of the creation of the record.',
  `createdBy` varchar(255) DEFAULT NULL COMMENT 'Username of the creator of the record.',
  `lastUpdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date and time of the last modification',
  `updatedBy` varchar(255) DEFAULT NULL COMMENT 'Username of the last user who modify the record',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_study_consentQuestionnaireId_questionnaire_ID` (`consentQuestionnaireId`),
  CONSTRAINT `fk_study_consentQuestionnaireId_questionnaire_ID` FOREIGN KEY (`consentQuestionnaireId`) REFERENCES `QuestionnaireDB`.`questionnaire` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TagPatientLog
CREATE TABLE IF NOT EXISTS `TagPatientLog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LastUpdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ImportTimestamp` datetime DEFAULT NULL,
  `ImportDate` date DEFAULT NULL,
  `ImportTime` time DEFAULT NULL,
  `InsertedRows` int(11) DEFAULT NULL COMMENT 'Number of Labs INSERTED in TestResultTemp',
  `Result` varchar(1000) DEFAULT NULL,
  `ImportParamsReceived` varchar(1000) DEFAULT NULL,
  `Mrn` varchar(45) DEFAULT NULL,
  `Site` varchar(45) DEFAULT NULL,
  `Source` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_LastUpdated` (`LastUpdated`),
  KEY `idx_ImportTimestamp` (`ImportTimestamp`),
  KEY `idx_ImportDate` (`ImportDate`),
  KEY `idx_ImportTime` (`ImportTime`),
  KEY `idx_Result` (`Result`(767)),
  KEY `idx_Mrn` (`Mrn`),
  KEY `idx_Site` (`Site`)
) ENGINE=InnoDB AUTO_INCREMENT=1324 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Task
CREATE TABLE IF NOT EXISTS `Task` (
  `TaskSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `AliasExpressionSerNum` int(11) NOT NULL,
  `PrioritySerNum` int(11) NOT NULL,
  `DiagnosisSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `TaskAriaSer` int(11) NOT NULL,
  `Status` varchar(100) NOT NULL,
  `State` varchar(25) NOT NULL,
  `DueDateTime` datetime NOT NULL,
  `CreationDate` datetime NOT NULL,
  `CompletionDate` datetime NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TaskSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `AliasExpressionSerNum` (`AliasExpressionSerNum`),
  KEY `TaskAriaSer` (`TaskAriaSer`),
  KEY `PrioritySerNum` (`PrioritySerNum`),
  KEY `DiagnosisSerNum` (`DiagnosisSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `Task_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Task_ibfk_2` FOREIGN KEY (`AliasExpressionSerNum`) REFERENCES `AliasExpression` (`AliasExpressionSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Task_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Task_ibfk_4` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TaskMH
CREATE TABLE IF NOT EXISTS `TaskMH` (
  `TaskSerNum` int(11) NOT NULL,
  `TaskRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `AliasExpressionSerNum` int(11) NOT NULL,
  `PrioritySerNum` int(11) NOT NULL,
  `DiagnosisSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `TaskAriaSer` int(11) NOT NULL,
  `Status` varchar(100) NOT NULL,
  `State` varchar(25) NOT NULL,
  `DueDateTime` datetime NOT NULL,
  `CreationDate` datetime NOT NULL,
  `CompletionDate` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TaskSerNum`,`TaskRevSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `AliasExpressionSerNum` (`AliasExpressionSerNum`),
  KEY `PrioritySerNum` (`PrioritySerNum`),
  KEY `DiagnosisSerNum` (`DiagnosisSerNum`),
  KEY `TaskAriaSer` (`TaskAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.termsandagreement
CREATE TABLE IF NOT EXISTS `termsandagreement` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `DocumentLink_EN` varchar(10000) NOT NULL,
  `DocumentLink_FR` varchar(10000) NOT NULL,
  `PDFLink_EN` mediumtext NOT NULL,
  `PDFLink_FR` mediumtext NOT NULL,
  `Version` varchar(10000) NOT NULL,
  `Active` tinyint(4) NOT NULL,
  `CreateDate` timestamp NULL DEFAULT NULL,
  `LastModifyDate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Table to store terms and agreement docuemnt link(In En & Fr) with version of the document and created and last modified dates.';

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestControl
CREATE TABLE IF NOT EXISTS `TestControl` (
  `TestControlSerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(200) NOT NULL,
  `Name_FR` varchar(200) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_FR` text NOT NULL,
  `Group_EN` varchar(200) NOT NULL,
  `Group_FR` varchar(200) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 1,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `PublishFlag` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `URL_EN` varchar(2000) NOT NULL,
  `URL_FR` varchar(2000) NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TestControlSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `TestControl_ibfk_1` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TestControl_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `TestControl_ibfk_3` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1218 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestExpression
CREATE TABLE IF NOT EXISTS `TestExpression` (
  `TestExpressionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `TestControlSerNum` bigint(20) DEFAULT NULL,
  `TestCode` varchar(30) NOT NULL DEFAULT '',
  `ExpressionName` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 4,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  `externalId` varchar(512) NOT NULL DEFAULT '-1',
  `deleted` int(1) NOT NULL DEFAULT 0,
  `deletedBy` varchar(255) NOT NULL,
  `createdBy` varchar(255) NOT NULL DEFAULT 'cronjob',
  `updatedBy` varchar(255) NOT NULL DEFAULT 'cronjob',
  PRIMARY KEY (`TestExpressionSerNum`),
  UNIQUE KEY `TestCode` (`TestCode`,`SourceDatabaseSerNum`),
  KEY `TestResultControlSerNum` (`TestControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `TestExpression_ibfk_1` (`SourceDatabaseSerNum`),
  CONSTRAINT `TestExpression_ibfk_1` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TestExpression_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15957607 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestGroupExpression
CREATE TABLE IF NOT EXISTS `TestGroupExpression` (
  `TestGroupExpressionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `TestControlSerNum` bigint(20) DEFAULT NULL,
  `TestCode` varchar(30) NOT NULL DEFAULT '',
  `ExpressionName` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 4,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TestGroupExpressionSerNum`),
  UNIQUE KEY `TestCode` (`TestCode`,`SourceDatabaseSerNum`),
  KEY `TestResultControlSerNum` (`TestControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `TestExpression_ibfk_1` (`SourceDatabaseSerNum`),
  CONSTRAINT `TestGroupExpression_ibfk_2` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TestGroupExpression_ibfk_3` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1032304 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResult
CREATE TABLE IF NOT EXISTS `TestResult` (
  `TestResultSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `TestResultGroupSerNum` int(11) NOT NULL,
  `TestResultControlSerNum` int(11) NOT NULL,
  `TestResultExpressionSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `TestResultAriaSer` varchar(100) NOT NULL,
  `ComponentName` varchar(30) NOT NULL,
  `FacComponentName` varchar(30) NOT NULL,
  `AbnormalFlag` varchar(5) NOT NULL,
  `TestDate` datetime NOT NULL,
  `MaxNorm` float NOT NULL,
  `MinNorm` float NOT NULL,
  `ApprovedFlag` varchar(5) NOT NULL,
  `TestValue` float NOT NULL,
  `TestValueString` varchar(400) NOT NULL,
  `UnitDescription` varchar(40) NOT NULL,
  `ValidEntry` varchar(5) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TestResultSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `TestResultAriaSer` (`TestResultAriaSer`),
  KEY `TestResultControlSerNum` (`TestResultControlSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `TestResultExpressionSerNum` (`TestResultExpressionSerNum`),
  KEY `TestResultGroupSerNum` (`TestResultGroupSerNum`),
  CONSTRAINT `TestResult_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TestResult_ibfk_2` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71531 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultAdditionalLinks
CREATE TABLE IF NOT EXISTS `TestResultAdditionalLinks` (
  `TestResultAdditionalLinksSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `TestResultControlSerNum` int(11) NOT NULL,
  `Name_EN` varchar(1028) NOT NULL,
  `Name_FR` varchar(1028) NOT NULL,
  `URL_EN` varchar(2056) NOT NULL,
  `URL_FR` varchar(2056) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TestResultAdditionalLinksSerNum`),
  KEY `TestResultControlSerNum` (`TestResultControlSerNum`),
  CONSTRAINT `FK_TestResultAdditionalLinks_TestResultControl` FOREIGN KEY (`TestResultControlSerNum`) REFERENCES `TestResultControl` (`TestResultControlSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultControl
CREATE TABLE IF NOT EXISTS `TestResultControl` (
  `TestResultControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(200) NOT NULL,
  `Name_FR` varchar(200) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_FR` text NOT NULL,
  `Group_EN` varchar(200) NOT NULL,
  `Group_FR` varchar(200) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 1,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `PublishFlag` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `URL_EN` varchar(2000) NOT NULL,
  `URL_FR` varchar(2000) NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TestResultControlSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `FK_TestResultControl_EducationalMaterialControl` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `TestResultControl_ibfk_1` FOREIGN KEY (`SourceDatabaseSerNum`) REFERENCES `SourceDatabase` (`SourceDatabaseSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TestResultControl_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultControlMH
CREATE TABLE IF NOT EXISTS `TestResultControlMH` (
  `TestResultControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(200) NOT NULL,
  `Name_FR` varchar(200) NOT NULL,
  `Description_EN` text NOT NULL,
  `Description_FR` text NOT NULL,
  `Group_EN` varchar(200) NOT NULL,
  `Group_FR` varchar(200) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL DEFAULT 1,
  `EducationalMaterialControlSerNum` int(11) DEFAULT NULL,
  `PublishFlag` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2002-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ModificationAction` varchar(25) NOT NULL,
  `URL_EN` varchar(2000) DEFAULT NULL,
  `URL_FR` varchar(2000) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TestResultControlSerNum`,`RevSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  KEY `EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultExpression
CREATE TABLE IF NOT EXISTS `TestResultExpression` (
  `TestResultExpressionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `TestResultControlSerNum` int(11) NOT NULL,
  `ExpressionName` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TestResultExpressionSerNum`),
  UNIQUE KEY `ExpressionName` (`ExpressionName`),
  KEY `TestResultControlSerNum` (`TestResultControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `FK_TestResultExpression_TestResultControl` FOREIGN KEY (`TestResultControlSerNum`) REFERENCES `TestResultControl` (`TestResultControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TestResultExpression_ibfk_2` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultExpressionMH
CREATE TABLE IF NOT EXISTS `TestResultExpressionMH` (
  `TestResultControlSerNum` int(11) NOT NULL,
  `ExpressionName` varchar(100) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastPublished` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ExpressionName`,`RevSerNum`),
  KEY `TestResultControlSerNum` (`TestResultControlSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultGroup
CREATE TABLE IF NOT EXISTS `TestResultGroup` (
  `TestResultGroupSerNum` int(11) DEFAULT NULL,
  `TestResultCodeGroup` varchar(30) DEFAULT NULL,
  `TestResultGroupDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultMH
CREATE TABLE IF NOT EXISTS `TestResultMH` (
  `TestResultSerNum` int(11) NOT NULL,
  `TestResultRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `TestResultGroupSerNum` int(11) NOT NULL,
  `TestResultExpressionSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `TestResultAriaSer` varchar(100) NOT NULL,
  `ComponentName` varchar(30) NOT NULL,
  `FacComponentName` varchar(30) NOT NULL,
  `AbnormalFlag` varchar(5) NOT NULL,
  `TestDate` datetime NOT NULL,
  `MaxNorm` float NOT NULL,
  `MinNorm` float NOT NULL,
  `ApprovedFlag` varchar(5) NOT NULL,
  `TestValue` float NOT NULL,
  `TestValueString` varchar(400) NOT NULL,
  `UnitDescription` varchar(40) NOT NULL,
  `ValidEntry` varchar(5) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  PRIMARY KEY (`TestResultSerNum`,`TestResultRevSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `TestResultAriaSer` (`TestResultAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `TestResultExpressionSerNum` (`TestResultExpressionSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultNotificationProcessingLog
CREATE TABLE IF NOT EXISTS `TestResultNotificationProcessingLog` (
  `TestResultNotificationResultLogId` int(11) NOT NULL AUTO_INCREMENT,
  `TestResultNotificationQueueId` int(11) NOT NULL,
  `Status` enum('COMPLETED','PENDING','MAX_ATTEMPTS_REACHED') NOT NULL,
  `InsertedRows` int(11) NOT NULL,
  `UpdatedRows` int(11) NOT NULL,
  `ProcessingDateTime` datetime DEFAULT NULL,
  `ProcessingAttemptNumber` int(11) DEFAULT NULL,
  `ProcessingError` text DEFAULT NULL,
  `ModificationAction` varchar(20) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TestResultNotificationResultLogId`),
  KEY `FK_Test_Result_Notification_Queue_Id` (`TestResultNotificationQueueId`),
  CONSTRAINT `FK_Test_Result_Notification_Queue_Id` FOREIGN KEY (`TestResultNotificationQueueId`) REFERENCES `TestResultNotificationQueue` (`TestResultNotificationQueueId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TestResultNotificationQueue
CREATE TABLE IF NOT EXISTS `TestResultNotificationQueue` (
  `TestResultNotificationQueueId` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) DEFAULT NULL,
  `Mrn` varchar(20) NOT NULL,
  `Site` varchar(20) NOT NULL,
  `Ramq` varchar(40) NOT NULL,
  `NotificationId` varchar(20) DEFAULT NULL,
  `SpecimenDateTime` datetime NOT NULL,
  `ResultDateTime` datetime NOT NULL,
  `Status` enum('COMPLETED','PENDING','MAX_ATTEMPTS_REACHED') NOT NULL,
  `ImportDateTime` datetime NOT NULL,
  `ProcessingAttemptNumber` int(11) NOT NULL DEFAULT 0,
  `LastProcessingDateTime` datetime DEFAULT NULL,
  `InsertedRows` int(11) NOT NULL DEFAULT 0,
  `UpdatedRows` int(11) NOT NULL DEFAULT 0,
  `LastProcessingError` text DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TestResultNotificationQueueId`),
  KEY `PatientSerNum` (`PatientSerNum`),
  CONSTRAINT `TestResultNotificationQueue_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=3204 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Translation
CREATE TABLE IF NOT EXISTS `Translation` (
  `TranslationSerNum` bigint(20) NOT NULL AUTO_INCREMENT,
  `TranslationTableName` varchar(150) NOT NULL DEFAULT '' COMMENT 'Name of the Table',
  `TranslationColumnName` varchar(150) NOT NULL DEFAULT '' COMMENT 'Name of the column',
  `TranslationCurrent` varchar(512) NOT NULL DEFAULT '' COMMENT 'Current text',
  `TranslationReplace` varchar(512) NOT NULL DEFAULT '' COMMENT 'Replace the current text',
  `Active` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 = Active / 0 = Not Active',
  `RefTableRecNo` bigint(20) DEFAULT NULL COMMENT 'Record Number of the reference table',
  PRIMARY KEY (`TranslationSerNum`),
  KEY `IX_Active` (`Active`),
  KEY `IX_TranslationTableName` (`TranslationTableName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TxTeamMessage
CREATE TABLE IF NOT EXISTS `TxTeamMessage` (
  `TxTeamMessageSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TxTeamMessageSerNum`),
  KEY `PostSerNum` (`PostControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `TxTeamMessageSerNum` (`TxTeamMessageSerNum`),
  CONSTRAINT `TxTeamMessage_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TxTeamMessage_ibfk_2` FOREIGN KEY (`PostControlSerNum`) REFERENCES `PostControl` (`PostControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `TxTeamMessage_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.TxTeamMessageMH
CREATE TABLE IF NOT EXISTS `TxTeamMessageMH` (
  `TxTeamMessageSerNum` int(11) NOT NULL,
  `TxTeamMessageRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`TxTeamMessageSerNum`,`TxTeamMessageRevSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PatientControlSerNum` (`PostControlSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.Users
CREATE TABLE IF NOT EXISTS `Users` (
  `UserSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `UserType` varchar(255) NOT NULL,
  `UserTypeSerNum` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL COMMENT 'This field is Firebase User UID',
  `Password` varchar(255) NOT NULL,
  `SessionId` text DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`UserSerNum`),
  KEY `UserType` (`UserType`),
  KEY `UserTypeSerNum` (`UserTypeSerNum`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.UsersAppointmentsTimestamps
CREATE TABLE IF NOT EXISTS `UsersAppointmentsTimestamps` (
  `PatientSerNum` int(11) NOT NULL,
  `AppointmentSerNum` int(11) NOT NULL,
  `FirstCheckinTime` datetime NOT NULL COMMENT 'First patients check-in in the hospital.',
  `ScheduledTime` datetime NOT NULL COMMENT 'Appointments scheduled time.',
  `ActualStartTime` datetime NOT NULL COMMENT 'The actual time the appointment really started.',
  `LastUpdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientSerNum`,`AppointmentSerNum`),
  KEY `AppointmentSerNum` (`AppointmentSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.UsersMH
CREATE TABLE IF NOT EXISTS `UsersMH` (
  `UserSerNum` int(11) NOT NULL,
  `UserRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SessionId` text NOT NULL,
  `UserType` varchar(255) NOT NULL,
  `UserTypeSerNum` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`UserSerNum`,`UserRevSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for procedure OpalDB.ValidatePatientSerNums
DELIMITER //
CREATE PROCEDURE `ValidatePatientSerNums`()
    COMMENT 'Checks PatientSerNum values in all tables to make sure they are all in the Patient table.'
BEGIN
/*
 * Name: ValidatePatientSerNums
 * Author: Stacey Beard
 * Date: 2020-05-27
 * Description: Iterates through all tables in the database to check whether they have PatientSerNums that are not in the Patients table,
 *              and prints the number of invalid PatientSerNums per table as output.
 *              This procedure can be used to check whether the database contains any extraneous patient data that shouldn't be there.
 *
 *              Warning: this procedure uses concatenation to generate prepared statements, and shouldn't be called externally
 *              or modified to use parameters in these statements.
 */

# Holder for whether the current table has a PatientSerNum column
DECLARE hasPatientSerNum TINYINT DEFAULT 0;
# Controls iterating through all the tables
DECLARE done TINYINT DEFAULT FALSE;
# Holder for the current table name while iterating through all the tables
DECLARE tableName VARCHAR(64);
# Cursor used to iterate through all the tables
DECLARE cur CURSOR FOR 
	SELECT T.table_name
	FROM information_schema.tables T
	WHERE T.table_schema = DATABASE()
;
# Part of cursor iteration
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

# Create a temporary table to store the results
DROP TEMPORARY TABLE IF EXISTS ValidatePatientSerNums_Temp_Results;
CREATE TEMPORARY TABLE ValidatePatientSerNums_Temp_Results(
   TableName VARCHAR(64),
   HasPatientSerNum TINYINT,
   NumberOfInvalidPatientSerNums INT
);

# Create a temporary table to store whether the current table has a PatientSerNum column
# Used like a variable, to access the result from a prepared statement
DROP TEMPORARY TABLE IF EXISTS ValidatePatientSerNums_Temp_Variable;
CREATE TEMPORARY TABLE ValidatePatientSerNums_Temp_Variable(
   HasPatientSerNum TINYINT
);

OPEN cur;

# Iterate through all the tables
read_loop: LOOP
	FETCH cur INTO tableName;
	IF done THEN
		LEAVE read_loop;
	END IF;
	
	# Empty the temp table used to hold a variable
	DELETE FROM ValidatePatientSerNums_Temp_Variable;
	
	# Check whether the current table has a PatientSerNum column and store the result in the temp table
	SET @s1 = CONCAT('
		INSERT INTO ValidatePatientSerNums_Temp_Variable(HasPatientSerNum) VALUES (
			(SELECT COUNT(*)
			FROM information_schema.columns 
			WHERE table_schema = DATABASE()
				AND table_name = "',tableName,'"
				AND column_name = "PatientSerNum")
		)
	;');
	
	PREPARE stmt1 FROM @s1; 
	EXECUTE stmt1; 
	DEALLOCATE PREPARE stmt1;
	
	# Re-extract the value indicating whether the current table has a PatientSerNum column from the temp table
	SELECT * FROM ValidatePatientSerNums_Temp_Variable
	INTO hasPatientSerNum
	;
	
	# Determine whether to check PatientSerNums against the Patient table and compute the results
	IF NOT hasPatientSerNum THEN
		SET @s2 = CONCAT('
			INSERT INTO ValidatePatientSerNums_Temp_Results(TableName, HasPatientSerNum, NumberOfInvalidPatientSerNums) VALUES (
				"',tableName,'",
				',hasPatientSerNum,',
				0
			)
		;');
	ELSE
		SET @s2 = CONCAT('
			INSERT INTO ValidatePatientSerNums_Temp_Results(TableName, HasPatientSerNum, NumberOfInvalidPatientSerNums) VALUES (
				"',tableName,'",
				',hasPatientSerNum,',
				(
					SELECT COUNT(DISTINCT PatientSerNum)
					FROM ',tableName,' 
					LEFT JOIN Patient P USING (PatientSerNum)
					WHERE P.PatientSerNum IS NULL
				)
			)
		;');
	END IF;
	
	PREPARE stmt2 FROM @s2; 
	EXECUTE stmt2; 
	DEALLOCATE PREPARE stmt2;
	
END LOOP;

# Print the results
SELECT * FROM ValidatePatientSerNums_Temp_Results
ORDER BY TableName
;

# Print the total number of invalid references
SELECT "TOTAL" AS Result, SUM(NumberOfInvalidPatientSerNums) AS "InvalidPatientSerNumReferences"
FROM ValidatePatientSerNums_Temp_Results
;

# Cleanup
CLOSE cur;
DROP TEMPORARY TABLE IF EXISTS ValidatePatientSerNums_Temp_Results;
DROP TEMPORARY TABLE IF EXISTS ValidatePatientSerNums_Temp_Variable;

END//
DELIMITER ;

-- Dumping structure for table OpalDB.Venue
CREATE TABLE IF NOT EXISTS `Venue` (
  `VenueSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `SourceUID` int(11) NOT NULL,
  `VenueId` varchar(100) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`VenueSerNum`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`),
  KEY `SourceUID` (`SourceUID`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for view OpalDB.v_login
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_login` (
	`id` INT(11) NOT NULL,
	`username` VARCHAR(1000) NOT NULL COLLATE 'latin1_swedish_ci',
	`password` VARCHAR(1000) NOT NULL COLLATE 'latin1_swedish_ci',
	`language` ENUM('EN','FR') NOT NULL COLLATE 'latin1_swedish_ci',
	`role` BIGINT(20) NOT NULL COMMENT 'Role of the user',
	`type` TINYINT(1) NULL COMMENT 'Type of user. 1 = \'human\' user. 2 = \'system\' user'
) ENGINE=MyISAM;

-- Dumping structure for view OpalDB.v_masterSourceTestResult
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_masterSourceTestResult` (
	`ID` INT(11) NOT NULL,
	`externalId` VARCHAR(512) NOT NULL COLLATE 'latin1_swedish_ci',
	`code` VARCHAR(30) NOT NULL COLLATE 'latin1_swedish_ci',
	`description` VARCHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`source` INT(11) NOT NULL,
	`deleted` INT(1) NOT NULL,
	`deletedBy` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`creationDate` DATETIME NOT NULL,
	`createdBy` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`lastUpdated` TIMESTAMP NOT NULL,
	`updatedBy` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci'
) ENGINE=MyISAM;

-- Dumping structure for table OpalDB.YM_APPT_Step1
CREATE TABLE IF NOT EXISTS `YM_APPT_Step1` (
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `AppointmentAriaSer` int(11) NOT NULL,
  `count(*)` bigint(21) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.YM_APPT_Step_2
CREATE TABLE IF NOT EXISTS `YM_APPT_Step_2` (
  `AppointmentSerNum` int(11) DEFAULT NULL,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `AppointmentAriaSer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table OpalDB.YM_APPT_Step_3
CREATE TABLE IF NOT EXISTS `YM_APPT_Step_3` (
  `AppointmentSerNum` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for trigger OpalDB.alert_after_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `alert_after_delete` AFTER DELETE ON `alert` FOR EACH ROW BEGIN
	INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (OLD.ID, OLD.contact, OLD.subject, OLD.body, OLD.trigger, NOW(), OLD.createdBy, OLD.lastUpdated, OLD.updatedBy, 'DELETE', OLD.active, OLD.deleted, OLD.deletedBy);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alert_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `alert_after_insert` AFTER INSERT ON `alert` FOR EACH ROW BEGIN
INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (NEW.ID, NEW.contact, NEW.subject, NEW.body, NEW.trigger, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy, 'INSERT', NEW.active, NEW.deleted, NEW.deletedBy);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alert_after_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `alert_after_update` AFTER UPDATE ON `alert` FOR EACH ROW BEGIN
	IF NEW.lastUpdated != OLD.lastUpdated THEN
		INSERT INTO `alertMH` (`alertId`, `contact`, `subject`, `body`, `trigger`, `creationDate`, `createdBy`, `lastUpdated`, `updatedBy`, `action`, `active`, `deleted`, `deletedBy`) VALUES (NEW.ID, NEW.contact, NEW.subject, NEW.body, NEW.trigger, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy, 'UPDATE', NEW.active, NEW.deleted, NEW.deletedBy);
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alias_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `alias_delete_trigger` AFTER DELETE ON `Alias` FOR EACH ROW BEGIN
   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.AliasSerNum, OLD.AliasType, OLD.AliasUpdate, OLD.AliasName_FR, OLD.AliasName_EN, OLD.AliasDescription_FR, OLD.AliasDescription_EN, OLD.EducationalMaterialControlSerNum, OLD.HospitalMapSerNum, OLD.SourceDatabaseSerNum, OLD.ColorTag, OLD.LastTransferred, NULL, NULL, 'DELETE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alias_expression_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `alias_expression_delete_trigger` AFTER DELETE ON `AliasExpression` FOR EACH ROW BEGIN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (OLD.AliasSerNum, OLD.masterSourceAliasId, OLD.ExpressionName, OLD.Description, OLD.LastTransferred, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alias_expression_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `alias_expression_insert_trigger` AFTER INSERT ON `AliasExpression` FOR EACH ROW BEGIN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, `Description`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.masterSourceAliasId, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alias_expression_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `alias_expression_update_trigger` AFTER UPDATE ON `AliasExpression` FOR EACH ROW BEGIN
if NEW.LastTransferred <=> OLD.LastTransferred THEN
   INSERT INTO `AliasExpressionMH`(`AliasSerNum`, `masterSourceAliasId`, `ExpressionName`, Description, `LastTransferred`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.AliasSerNum, NEW.masterSourceAliasId, NEW.ExpressionName, NEW.Description, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alias_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `alias_insert_trigger` AFTER INSERT ON `Alias` FOR EACH ROW BEGIN
   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.AliasSerNum, NEW.AliasType, NEW.AliasUpdate, NEW.AliasName_FR, NEW.AliasName_EN, NEW.AliasDescription_FR, NEW.AliasDescription_EN, NEW.EducationalMaterialControlSerNum, NEW.HospitalMapSerNum, NEW.SourceDatabaseSerNum, NEW.ColorTag, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.alias_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `alias_update_trigger` AFTER UPDATE ON `Alias` FOR EACH ROW BEGIN
if NEW.LastTransferred <=> OLD.LastTransferred THEN
   INSERT INTO `AliasMH`(`AliasSerNum`, `AliasType`, `AliasUpdate`, `AliasName_FR`, `AliasName_EN`, `AliasDescription_FR`, `AliasDescription_EN`, `EducationalMaterialControlSerNum`, `HospitalMapSerNum`, `SourceDatabaseSerNum`, `ColorTag`, `LastTransferred`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.AliasSerNum, NEW.AliasType, NEW.AliasUpdate, NEW.AliasName_FR, NEW.AliasName_EN, NEW.AliasDescription_FR, NEW.AliasDescription_EN, NEW.EducationalMaterialControlSerNum, NEW.HospitalMapSerNum, NEW.SourceDatabaseSerNum, NEW.ColorTag, NEW.LastTransferred, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.announcement_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `announcement_delete_trigger` AFTER DELETE ON `Announcement` FOR EACH ROW BEGIN
INSERT INTO `AnnouncementMH`(`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.AnnouncementSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.announcement_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `announcement_insert_trigger` AFTER INSERT ON `Announcement` FOR EACH ROW BEGIN
	INSERT INTO `AnnouncementMH`(`AnnouncementSerNum`,`CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)
		VALUES (NEW.AnnouncementSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');

	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
		SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.AnnouncementSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR
		FROM NotificationControl ntc
		WHERE ntc.NotificationType = 'Announcement';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.announcement_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `announcement_update_trigger` AFTER UPDATE ON `Announcement` FOR EACH ROW BEGIN
INSERT INTO `AnnouncementMH`(`AnnouncementSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.AnnouncementSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.appointment_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `appointment_delete_trigger` AFTER DELETE ON `Appointment` FOR EACH ROW BEGIN
 INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (OLD.AppointmentSerNum,NULL,OLD.SessionId,OLD.AliasExpressionSerNum, OLD.CronLogSerNum, OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.AppointmentAriaSer,OLD.PrioritySerNum, OLD.DiagnosisSerNum, OLD.Status, OLD.State, OLD.ScheduledStartTime,OLD.ScheduledEndTime, OLD.ActualStartDate, OLD.ActualEndDate, OLD.Location, OLD.RoomLocation_EN, OLD.RoomLocation_FR, OLD.Checkin, OLD.DateAdded,OLD.ReadStatus,NOW(), 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.appointment_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `appointment_insert_trigger` AFTER INSERT ON `Appointment` FOR EACH ROW BEGIN
INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`,`RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`, `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NULL,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum, NEW.AppointmentAriaSer, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.appointment_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `appointment_update_trigger` AFTER UPDATE ON `Appointment` FOR EACH ROW BEGIN
 INSERT INTO `AppointmentMH`(`AppointmentSerNum`, `AppointmentRevSerNum`,`SessionId`, `AliasExpressionSerNum`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `AppointmentAriaSer`, `PrioritySerNum`, `DiagnosisSerNum`, `Status`, `State`, `ScheduledStartTime`, `ScheduledEndTime`, `ActualStartDate`, `ActualEndDate`, `Location`, `RoomLocation_EN`, `RoomLocation_FR`, `Checkin`, `DateAdded`, `ReadStatus`, `LastUpdated`,  `ModificationAction`) VALUES (NEW.AppointmentSerNum,NULL,NEW.SessionId,NEW.AliasExpressionSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.AppointmentAriaSer,NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.Status, NEW.State, NEW.ScheduledStartTime,NEW.ScheduledEndTime, NEW.ActualStartDate, NEW.ActualEndDate, NEW.Location, NEW.RoomLocation_EN, NEW.RoomLocation_FR, NEW.Checkin, NEW.DateAdded,NEW.ReadStatus,NOW(), 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.delete_message_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `delete_message_trigger` AFTER DELETE ON `Messages` FOR EACH ROW BEGIN
INSERT INTO `MessagesMH`(`MessageSerNum`, `MessageRevSerNum`, `SessionId`, `SenderRole`, `ReceiverRole`, `SenderSerNum`, `ReceiverSerNum`, `MessageContent`, `ReadStatus`, `Attachment`, `MessageDate`, `LastUpdated`, `ModificationAction`) VALUES (OLD.MessageSerNum, NULL, OLD.SessionId, OLD.SenderRole, OLD.ReceiverRole, OLD.SenderSerNum, OLD.ReceiverSerNum, OLD.MessageContent, OLD.ReadStatus, OLD.Attachment, OLD.MessageDate, NOW(), 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.delete_task_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `delete_task_trigger` AFTER DELETE ON `Task` FOR EACH ROW BEGIN
INSERT INTO `TaskMH`(`TaskSerNum`, `CronLogSerNum`, `PatientSerNum`, `AliasExpressionSerNum`, `SourceDatabaseSerNum`, `TaskAriaSer`, `Status`, `State`, `PrioritySerNum`, `DiagnosisSerNum`, `DueDateTime`, `CreationDate`, `CompletionDate`, `DateAdded`, `LastUpdated`, `ModificationAction`) VALUES (OLD.TaskSerNum, OLD.CronLogSerNum, OLD.PatientSerNum,OLD.AliasExpressionSerNum,OLD.SourceDatabaseSerNum,OLD.TaskAriaSer, OLD.Status, OLD.State, OLD.PrioritySerNum, OLD.DiagnosisSerNum, OLD.DueDateTime, OLD.CreationDate, OLD.CompletionDate, OLD.DateAdded,NULL, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_code_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_code_delete_trigger` AFTER DELETE ON `DiagnosisCode` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.DiagnosisTranslationSerNum, OLD.SourceUID, OLD.DiagnosisCode, OLD.Description, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_code_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_code_insert_trigger` AFTER INSERT ON `DiagnosisCode` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.SourceUID, NEW.DiagnosisCode, NEW.Description, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_code_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_code_update_trigger` AFTER UPDATE ON `DiagnosisCode` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisCodeMH`(`DiagnosisTranslationSerNum`,`SourceUID`, `DiagnosisCode`, `Description`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.SourceUID, NEW.DiagnosisCode, NEW.Description, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_delete_trigger` AFTER DELETE ON `Diagnosis` FOR EACH ROW BEGIN
	INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,
	`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,
	`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)
	VALUES (OLD.DiagnosisSerNum, OLD.PatientSerNum, OLD.SourceDatabaseSerNum,
	OLD.DiagnosisAriaSer, OLD.DiagnosisCode, OLD.Description_EN, OLD.Description_FR,
	OLD.Stage, OLD.StageCriteria, 'DELETE', NOW(), OLD.createdBy, OLD.lastUpdated,
	OLD.updatedBy);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_insert_trigger` AFTER INSERT ON `Diagnosis` FOR EACH ROW BEGIN
INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,
	`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,
	`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)
	VALUES (NEW.DiagnosisSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum,
	NEW.DiagnosisAriaSer, NEW.DiagnosisCode, NEW.Description_EN, NEW.Description_FR,
	NEW.Stage, NEW.StageCriteria, 'INSERT', NOW(), NEW.createdBy, NEW.lastUpdated,
	NEW.updatedBy);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_translation_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_translation_delete_trigger` AFTER DELETE ON `DiagnosisTranslation` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.DiagnosisTranslationSerNum, OLD.EducationalMaterialControlSerNum, OLD.Name_EN, OLD.Name_FR, OLD.Description_EN, OLD.Description_FR, NULL, NULL, 'DELETE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_translation_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_translation_insert_trigger` AFTER INSERT ON `DiagnosisTranslation` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.EducationalMaterialControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_translation_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_translation_update_trigger` AFTER UPDATE ON `DiagnosisTranslation` FOR EACH ROW BEGIN
   INSERT INTO `DiagnosisTranslationMH`( `DiagnosisTranslationSerNum`, `EducationalMaterialControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.DiagnosisTranslationSerNum, NEW.EducationalMaterialControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.diagnosis_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `diagnosis_update_trigger` AFTER UPDATE ON `Diagnosis` FOR EACH ROW BEGIN
	IF NEW.lastUpdated != OLD.lastUpdated THEN
		INSERT INTO `DiagnosisMH` (`DiagnosisSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`,
		`DiagnosisAriaSer`, `DiagnosisCode`, `Description_EN`, `Description_FR`, `Stage`,
		`StageCriteria`, `action`, `CreationDate`, `createdBy`, `LastUpdated`, `updatedBy`)
		VALUES (NEW.DiagnosisSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum,
		NEW.DiagnosisAriaSer, NEW.DiagnosisCode, NEW.Description_EN, NEW.Description_FR,
		NEW.Stage, NEW.StageCriteria, 'UPDATE', NOW(), NEW.createdBy, NEW.lastUpdated,
		NEW.updatedBy);
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.doctor_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `doctor_delete_trigger` AFTER DELETE ON `Doctor` FOR EACH ROW BEGIN
 INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSer, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (OLD.DoctorSerNum, NULL, OLD.ResourceSerNum, OLD.SourceDatabaseSerNum, OLD.DoctorAriaSer, OLD.FirstName, OLD.LastName, OLD.Role, OLD.Workplace, OLD.Email, OLD.Phone, OLD.Address,OLD.ProfileImage,NOW(), 'DELETE', OLD.BIO_EN, OLD.BIO_FR);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.doctor_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `doctor_insert_trigger` AFTER INSERT ON `Doctor` FOR EACH ROW BEGIN
 INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSerNum, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (NEW.DoctorSerNum, NULL, NEW.ResourceSerNum, NEW.SourceDatabaseSerNum, NEW.DoctorAriaSer, NEW.FirstName, NEW.LastName, NEW.Role, NEW.Workplace, NEW.Email, NEW.Phone, NEW.Address,NEW.ProfileImage,NOW(), 'INSERT', NEW.BIO_EN, NEW.BIO_FR);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.doctor_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `doctor_update_trigger` AFTER UPDATE ON `Doctor` FOR EACH ROW BEGIN
 INSERT INTO DoctorMH (DoctorSerNum, DoctorRevSerNum, ResourceSerNum, SourceDatabaseSerNum, DoctorAriaSer, FirstName, LastName, Role, Workplace, Email, Phone, Address, ProfileImage, LastUpdated, ModificationAction, BIO_EN, BIO_FR) VALUES (NEW.DoctorSerNum, NULL, NEW.ResourceSerNum, NEW.SourceDatabaseSerNum, NEW.DoctorAriaSer, NEW.FirstName, NEW.LastName, NEW.Role, NEW.Workplace, NEW.Email, NEW.Phone, NEW.Address,NEW.ProfileImage,NOW(), 'UPDATE', NEW.BIO_EN, NEW.BIO_FR);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.document_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `document_delete_trigger` AFTER DELETE ON `Document` FOR EACH ROW BEGIN
INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`,`CronLogSerNum`,`PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)
 VALUES (OLD.DocumentSerNum,NULL,OLD.SessionId,OLD.CronLogSerNum,OLD.PatientSerNum,OLD.SourceDatabaseSerNum,OLD.DocumentId,OLD.AliasExpressionSerNum,OLD.ApprovedBySerNum,OLD.ApprovedTimeStamp, OLD.AuthoredBySerNum, OLD.DateOfService, OLD.Revised, OLD.ValidEntry,OLD.ErrorReasonText,OLD.OriginalFileName,OLD.FinalFileName, OLD.CreatedBySerNum, OLD.CreatedTimeStamp, OLD.TransferStatus,OLD.TransferLog, OLD.ReadStatus, OLD.DateAdded, NOW(), 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.document_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `document_insert_trigger` AFTER INSERT ON `Document` FOR EACH ROW BEGIN
	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `CronLogSerNum`, `SessionId`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, `ApprovedBySerNum`, 
					`ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, `CreatedBySerNum`, `CreatedTimeStamp`, 
					`TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`) 
	VALUES (NEW.DocumentSerNum,NULL,NEW.CronLogSerNum, NULL,NEW.PatientSerNum,NEW.SourceDatabaseSerNum,NEW.DocumentId,NEW.AliasExpressionSerNum,NEW.ApprovedBySerNum,NEW.ApprovedTimeStamp, 
				NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry,NEW.ErrorReasonText,NEW.OriginalFileName,NEW.FinalFileName, NEW.CreatedBySerNum, NEW.CreatedTimeStamp, 
				NEW.TransferStatus,NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'INSERT');
				
	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0, 
				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR
	FROM NotificationControl ntc, Patient pt 
	WHERE ntc.NotificationType = 'Document' 
		AND pt.PatientSerNum = NEW.PatientSerNum 
		AND pt.AccessLevel = 3;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.document_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `document_update_trigger` AFTER UPDATE ON `Document` FOR EACH ROW BEGIN
	INSERT INTO `DocumentMH`(`DocumentSerNum`, `DocumentRevSerNum`, `SessionId`, `CronLogSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `DocumentId`, `AliasExpressionSerNum`, 
									`ApprovedBySerNum`, `ApprovedTimeStamp`, `AuthoredBySerNum`, `DateOfService`, `Revised`, `ValidEntry`, `ErrorReasonText`, `OriginalFileName`, `FinalFileName`, 
									`CreatedBySerNum`, `CreatedTimeStamp`, `TransferStatus`, `TransferLog`, `ReadStatus`, `DateAdded`, `LastUpdated`, `ModificationAction`)
	VALUES (NEW.DocumentSerNum, NULL,NEW.SessionId, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.DocumentId, NEW.AliasExpressionSerNum, NEW.ApprovedBySerNum,
				NEW.ApprovedTimeStamp, NEW.AuthoredBySerNum, NEW.DateOfService, NEW.Revised, NEW.ValidEntry, NEW.ErrorReasonText, NEW.OriginalFileName, NEW.FinalFileName, NEW.CreatedBySerNum, 
				NEW.CreatedTimeStamp, NEW.TransferStatus, NEW.TransferLog, NEW.ReadStatus, NEW.DateAdded, NOW(), 'UPDATE');
				
				
	INSERT INTO `Notification` (`PatientSerNum`, `NotificationControlSerNum`,`RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT  NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.DocumentSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'EN') EN, getRefTableRowTitle(NEW.DocumentSerNum, 'DOCUMENT', 'FR') FR
	FROM NotificationControl ntc, Patient pt 
	WHERE ntc.NotificationType = 'UpdDocument' 
		AND NEW.ReadStatus = 0
		AND pt.PatientSerNum = NEW.PatientSerNum
		AND pt.AccessLevel = 3;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.educationalmaterial_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `educationalmaterial_delete_trigger` AFTER DELETE ON `EducationalMaterial` FOR EACH ROW BEGIN
INSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.EducationalMaterialSerNum, OLD.CronLogSerNum, OLD.EducationalMaterialControlSerNum, OLD.PatientSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.educationalmaterial_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `educationalmaterial_insert_trigger` AFTER INSERT ON `EducationalMaterial` FOR EACH ROW BEGIN
	INSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) 
	VALUES (NEW.EducationalMaterialSerNum, NEW.CronLogSerNum, NEW.EducationalMaterialControlSerNum, NEW.PatientSerNum, NOW(), NEW.ReadStatus, 'INSERT');
	
	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT  NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.EducationalMaterialSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.EducationalMaterialSerNum, 'EDUCATIONAL', 'EN') EN, getRefTableRowTitle(NEW.EducationalMaterialSerNum, 'EDUCATIONAL', 'FR') FR
	FROM NotificationControl ntc 
	WHERE ntc.NotificationType = 'EducationalMaterial';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.educationalmaterial_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `educationalmaterial_update_trigger` AFTER UPDATE ON `EducationalMaterial` FOR EACH ROW BEGIN
INSERT INTO `EducationalMaterialMH`(`EducationalMaterialSerNum`, `CronLogSerNum`, `EducationalMaterialControlSerNum`, `PatientSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.EducationalMaterialSerNum, NEW.CronLogSerNum, NEW.EducationalMaterialControlSerNum, NEW.PatientSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.email_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `email_delete_trigger` AFTER DELETE ON `EmailLog` FOR EACH ROW BEGIN
INSERT INTO `EmailLogMH`(`EmailLogSerNum`, `CronLogSerNum`, `PatientSerNum`, `EmailControlSerNum`, `Status`, `DateAdded`, `ModificationAction`) VALUES (OLD.EmailLogSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.EmailControlSerNum, OLD.Status, NOW(), 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.email_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `email_insert_trigger` AFTER INSERT ON `EmailLog` FOR EACH ROW BEGIN
INSERT INTO `EmailLogMH`(`EmailLogSerNum`, `CronLogSerNum`, `PatientSerNum`, `EmailControlSerNum`, `Status`, `DateAdded`, `ModificationAction`) VALUES (NEW.EmailLogSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.EmailControlSerNum, NEW.Status, NOW(), 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.email_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `email_update_trigger` AFTER UPDATE ON `EmailLog` FOR EACH ROW BEGIN
INSERT INTO `EmailLogMH`(`EmailLogSerNum`, `CronLogSerNum`, `PatientSerNum`, `EmailControlSerNum`, `Status`, `DateAdded`, `ModificationAction`) VALUES (NEW.EmailLogSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.EmailControlSerNum, NEW.Status, NOW(), 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.filter_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `filter_delete_trigger` AFTER DELETE ON `Filters` FOR EACH ROW BEGIN
   INSERT INTO `FiltersMH`(`FilterSerNum`,`ControlTable`, `ControlTableSerNum`, `FilterType`, `FilterId`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (OLD.FilterSerNum, OLD.ControlTable, OLD.ControlTableSerNum, OLD.FilterType, OLD.FilterId, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.filter_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `filter_insert_trigger` AFTER INSERT ON `Filters` FOR EACH ROW BEGIN
   INSERT INTO `FiltersMH`(`FilterSerNum`,`ControlTable`, `ControlTableSerNum`, `FilterType`, `FilterId`, `LastUpdatedBy`, `SessionId`, `ModificationAction`, `DateAdded`) VALUES (NEW.FilterSerNum, NEW.ControlTable, NEW.ControlTableSerNum, NEW.FilterType, NEW.FilterId, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.hospitalmap_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `hospitalmap_delete_trigger` AFTER DELETE ON `HospitalMap` FOR EACH ROW BEGIN
   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.HospitalMapSerNum, OLD.MapUrl, OLD.MapURL_EN, OLD.MapURL_FR, OLD.QRMapAlias, OLD.QRImageFileName, OLD.MapName_EN, OLD.MapDescription_EN, OLD.MapName_FR, OLD.MapDescription_FR, NOW(), OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.hospitalmap_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `hospitalmap_insert_trigger` AFTER INSERT ON `HospitalMap` FOR EACH ROW BEGIN
   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR, NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.hospitalmap_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `hospitalmap_update_trigger` AFTER UPDATE ON `HospitalMap` FOR EACH ROW BEGIN
   INSERT INTO `HospitalMapMH`(`HospitalMapSerNum`, `MapUrl`, `MapURL_EN`, `MapURL_FR`, `QRMapAlias`, `QRImageFileName`, `MapName_EN`, `MapDescription_EN`, `MapName_FR`, `MapDescription_FR`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.HospitalMapSerNum, NEW.MapUrl, NEW.MapURL_EN, NEW.MapURL_FR,  NEW.QRMapAlias, NEW.QRImageFileName, NEW.MapName_EN, NEW.MapDescription_EN, NEW.MapName_FR, NEW.MapDescription_FR, NOW(), NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.insert_message_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `insert_message_trigger` AFTER INSERT ON `Messages` FOR EACH ROW BEGIN
INSERT INTO `MessagesMH`(`MessageSerNum`, `MessageRevSerNum`, `SessionId`, `SenderRole`, `ReceiverRole`, `SenderSerNum`, `ReceiverSerNum`, `MessageContent`, `ReadStatus`, `Attachment`, `MessageDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.MessageSerNum, NULL, New.SessionId, NEW.SenderRole, NEW.ReceiverRole, NEW.SenderSerNum, NEW.ReceiverSerNum, NEW.MessageContent, NEW.ReadStatus, NEW.Attachment, NEW.MessageDate, NOW(), 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.insert_task_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `insert_task_trigger` AFTER INSERT ON `Task` FOR EACH ROW BEGIN
INSERT INTO `TaskMH`(`TaskSerNum`,`CronLogSerNum`, `PatientSerNum`, `AliasExpressionSerNum`, `PrioritySerNum`, `DiagnosisSerNum`, `SourceDatabaseSerNum`, `TaskAriaSer`, `Status` , `State`, `DueDateTime`, `DateAdded`, `CreationDate`, `CompletionDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.TaskSerNum,NEW.CronLogSerNum, NEW.PatientSerNum,NEW.AliasExpressionSerNum, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.SourceDatabaseSerNum, NEW.TaskAriaSer, NEW.Status, NEW.State, NEW.DueDateTime, NEW.CreationDate, NEW.CompletionDate, NEW.DateAdded,NULL, 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.insert_test_result_notification_queue_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `insert_test_result_notification_queue_trigger` AFTER INSERT ON `TestResultNotificationQueue` FOR EACH ROW BEGIN
    INSERT INTO `TestResultNotificationProcessingLog`
        (`TestResultNotificationQueueId`, `Status`, `InsertedRows`, `UpdatedRows`, `ProcessingDateTime`,`ProcessingAttemptNumber`,`ProcessingError`,  `ModificationAction`) VALUES (NEW.TestResultNotificationQueueId, NEW.Status, NEW.InsertedRows, NEW.UpdatedRows, NEW.LastProcessingDateTime, NEW.ProcessingAttemptNumber,NEW.LastProcessingError,'INSERT');
    END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.legacy_questionnaire_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `legacy_questionnaire_delete_trigger` AFTER DELETE ON `Questionnaire` FOR EACH ROW BEGIN
INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `DateAdded`, ModificationAction) VALUES (OLD.QuestionnaireSerNum, OLD.CronLogSerNum, OLD.QuestionnaireControlSerNum, OLD.PatientSerNum, OLD.PatientQuestionnaireDBSerNum, OLD.CompletedFlag, OLD.CompletionDate, NOW(), 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.legacy_questionnaire_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `legacy_questionnaire_insert_trigger` AFTER INSERT ON `Questionnaire` FOR EACH ROW BEGIN

	-- prepared the variables
	DECLARE wsRespondent varchar(50);
	DECLARE wsQuestionnaireControlSerNum INT;
	
	INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, 
			`DateAdded`, ModificationAction) 
	VALUES (NEW.QuestionnaireSerNum, NEW.CronLogSerNum, NEW.QuestionnaireControlSerNum, NEW.PatientSerNum, NEW.PatientQuestionnaireDBSerNum, NEW.CompletedFlag, NEW.CompletionDate, 
			NOW(), 'INSERT');

	-- capture the questionnaire control serial number
	SET wsQuestionnaireControlSerNum = NEW.QuestionnaireControlSerNum;
	
	-- get the type of respondent
	SET wsRespondent = 
		(SELECT d.content
      FROM OpalDB.QuestionnaireControl QC, 
      	QuestionnaireDB.questionnaire q, 
      	QuestionnaireDB.dictionary d, 
			QuestionnaireDB.respondent r
      where QC.QuestionnaireDBSerNum = q.ID
      	and QC.QuestionnaireControlSerNum = wsQuestionnaireControlSerNum
         and q.respondentId = r.ID
         and r.title = d.contentId
         and d.languageId = 2
	);

	-- if the respondent is for Patient then insert a record into
	-- the notification table so that it shows up in the Opal app
	IF (wsRespondent = 'Patient') then 
		BEGIN
			INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
			SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.QuestionnaireSerNum, NOW(), 0,
						getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'EN') EN, getRefTableRowTitle(NEW.QuestionnaireControlSerNum, 'QUESTIONNAIRE', 'FR') FR
			FROM NotificationControl ntc
			WHERE ntc.NotificationType = 'LegacyQuestionnaire';	
		END;
	END IF;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.legacy_questionnaire_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `legacy_questionnaire_update_trigger` AFTER UPDATE ON `Questionnaire` FOR EACH ROW BEGIN
INSERT INTO QuestionnaireMH (`QuestionnaireSerNum`, `CronLogSerNum`, `QuestionnaireControlSerNum`, `PatientSerNum`, `PatientQuestionnaireDBSerNum`, `CompletedFlag`, `CompletionDate`, `DateAdded`, ModificationAction) VALUES (NEW.QuestionnaireSerNum, NEW.CronLogSerNum, NEW.QuestionnaireControlSerNum, NEW.PatientSerNum, NEW.PatientQuestionnaireDBSerNum, NEW.CompletedFlag, NEW.CompletionDate, NOW(), 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.notification_control_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `notification_control_delete_trigger` AFTER DELETE ON `NotificationControl` FOR EACH ROW BEGIN
   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.NotificationControlSerNum, OLD.Name_EN, OLD.Name_FR, OLD.Description_EN, OLD.Description_FR, OLD.NotificationTypeSerNum, OLD.DateAdded, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.notification_control_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `notification_control_insert_trigger` AFTER INSERT ON `NotificationControl` FOR EACH ROW BEGIN
   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.NotificationControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.NotificationTypeSerNum, NEW.DateAdded, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.notification_control_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `notification_control_update_trigger` AFTER UPDATE ON `NotificationControl` FOR EACH ROW BEGIN
   INSERT INTO `NotificationControlMH`(`NotificationControlSerNum`, `Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.NotificationControlSerNum, NEW.Name_EN, NEW.Name_FR, NEW.Description_EN, NEW.Description_FR, NEW.NotificationTypeSerNum, NEW.DateAdded, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.notification_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `notification_delete_trigger` AFTER DELETE ON `Notification` FOR EACH ROW BEGIN
	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
	VALUES (OLD.NotificationSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.NotificationControlSerNum, OLD.RefTableRowSerNum, OLD.ReadStatus, NOW(), 'DELETE', OLD.RefTableRowTitle_EN, OLD.RefTableRowTitle_FR);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.notification_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `notification_insert_trigger` AFTER INSERT ON `Notification` FOR EACH ROW BEGIN
	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
	VALUES (NEW.NotificationSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.NotificationControlSerNum, NEW.RefTableRowSerNum, NEW.ReadStatus, NOW(), 'INSERT', NEW.RefTableRowTitle_EN, NEW.RefTableRowTitle_FR);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.notification_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `notification_update_trigger` AFTER UPDATE ON `Notification` FOR EACH ROW BEGIN
	INSERT INTO `NotificationMH`(`NotificationSerNum`, `CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `ReadStatus`, `DateAdded`, `ModificationAction`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`)
	VALUES (NEW.NotificationSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.NotificationControlSerNum, NEW.RefTableRowSerNum, NEW.ReadStatus, NOW(), 'UPDATE', NEW.RefTableRowTitle_EN, NEW.RefTableRowTitle_FR);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.PatientLocation_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `PatientLocation_after_insert` AFTER INSERT ON `PatientLocation` FOR EACH ROW BEGIN


	if (new.CheckedInFlag = 1) then
		update Appointment set Checkin = 1 where AppointmentSerNum = new.AppointmentSerNum;
	end if;
	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patients_for_patients_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patients_for_patients_delete_trigger` AFTER DELETE ON `PatientsForPatients` FOR EACH ROW BEGIN
INSERT INTO `PatientsForPatientsMH`(`PatientsForPatientsSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (OLD.PatientsForPatientsSerNum, OLD.CronLogSerNum, OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patients_for_patients_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patients_for_patients_insert_trigger` AFTER INSERT ON `PatientsForPatients` FOR EACH ROW BEGIN
	INSERT INTO `PatientsForPatientsMH`(`PatientsForPatientsSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) 
	VALUES (NEW.PatientsForPatientsSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');
	
	
	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.PatientsForPatientsSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR
	FROM NotificationControl ntc 
	WHERE ntc.NotificationType = 'PatientsForPatients';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patients_for_patients_personnel_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patients_for_patients_personnel_delete_trigger` AFTER DELETE ON `PatientsForPatientsPersonnel` FOR EACH ROW BEGIN
INSERT INTO `PatientsForPatientsPersonnelMH` (`PatientsForPatientsPersonnelSerNum`, `FirstName`, `LastName`, `Email`, `Bio_EN`, `Bio_FR`,`Website`, `ProfileImage`, `ModificationAction`) VALUES (OLD.PatientsForPatientsPersonnelSerNum,OLD.FirstName, OLD.LastName, OLD.Email,OLD.Bio_EN,OLD.Bio_FR,OLD.Website,OLD.ProfileImage, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patients_for_patients_personnel_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patients_for_patients_personnel_insert_trigger` AFTER INSERT ON `PatientsForPatientsPersonnel` FOR EACH ROW BEGIN
INSERT INTO `PatientsForPatientsPersonnelMH` (`PatientsForPatientsPersonnelSerNum`, `PatientsForPatientsPersonnelRevSerNum`, `FirstName`, `LastName`, `Email`, `Bio_EN`, `Bio_FR`, `Website`, `ProfileImage`, `ModificationAction`) VALUES (NEW.PatientsForPatientsPersonnelSerNum,NULL, NEW.FirstName, NEW.LastName, NEW.Email,NEW.Bio_EN,NEW.Bio_FR, NEW.Website, NEW.ProfileImage, 'INSERT ');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patients_for_patients_personnel_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patients_for_patients_personnel_update_trigger` AFTER UPDATE ON `PatientsForPatientsPersonnel` FOR EACH ROW BEGIN
INSERT INTO `PatientsForPatientsPersonnelMH` (`PatientsForPatientsPersonnelSerNum`, `FirstName`, `LastName`, `Email`, `Bio_EN`, `Bio_FR`,`Website`, `ProfileImage`, `ModificationAction`) VALUES (NEW.PatientsForPatientsPersonnelSerNum,NEW.FirstName, NEW.LastName, NEW.Email,NEW.Bio_EN,NEW.Bio_FR, NEW.Website, NEW.ProfileImage, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patients_for_patients_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patients_for_patients_update_trigger` AFTER UPDATE ON `PatientsForPatients` FOR EACH ROW BEGIN
INSERT INTO `PatientsForPatientsMH`(`PatientsForPatientsSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.PatientsForPatientsSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patient_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patient_delete_trigger` AFTER DELETE ON `Patient` FOR EACH ROW BEGIN
INSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (OLD.PatientSerNum,NULL,OLD.SessionId,OLD.PatientAriaSer,OLD.PatientId, OLD.PatientId2, OLD.FirstName,OLD.LastName,OLD.Alias, OLD.Sex, OLD.DateOfBirth, OLD.Age, OLD.TelNum,OLD.EnableSMS,OLD.Email,OLD.Language,OLD.SSN, OLD.AccessLevel,OLD.RegistrationDate, OLD.ConsentFormExpirationDate, OLD.BlockedStatus, OLD.StatusReasonTxt, OLD.DeathDate, NOW(), 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patient_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patient_insert_trigger` AFTER INSERT ON `Patient` FOR EACH ROW BEGIN
INSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`,`RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.PatientSerNum,NULL,NULL,NEW.PatientAriaSer,NEW.PatientId, NEW.PatientId2, NEW.FirstName,NEW.LastName,NEW.Alias, NEW.Sex, NEW.DateOfBirth, NEW.Age, NEW.TelNum,NEW.EnableSMS,NEW.Email,NEW.Language,NEW.SSN, NEW.AccessLevel,NEW.RegistrationDate, NEW.ConsentFormExpirationDate, NEW.BlockedStatus, NEW.StatusReasonTxt, NEW.DeathDate, NOW(), 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.patient_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `patient_update_trigger` AFTER UPDATE ON `Patient` FOR EACH ROW BEGIN
INSERT INTO `PatientMH`(`PatientSerNum`, `PatientRevSerNum`, `SessionId`,`PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`,`RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.PatientSerNum,NULL,NEW.SessionId,NEW.PatientAriaSer,NEW.PatientId, NEW.PatientId2, NEW.FirstName,NEW.LastName,NEW.Alias, NEW.Sex, NEW.DateOfBirth, NEW.Age, NEW.TelNum,NEW.EnableSMS,NEW.Email,NEW.Language,NEW.SSN, NEW.AccessLevel, NEW.RegistrationDate, NEW.ConsentFormExpirationDate, NEW.BlockedStatus, NEW.StatusReasonTxt, NEW.DeathDate, NOW(), 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.post_control_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `post_control_delete_trigger` AFTER DELETE ON `PostControl` FOR EACH ROW BEGIN
   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (OLD.PostControlSerNum, OLD.PostType, OLD.PublishFlag, OLD.PostName_FR, OLD.PostName_EN, OLD.Body_FR, OLD.Body_EN, OLD.PublishDate, OLD.Disabled, NOW(), OLD.LastPublished, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.post_control_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `post_control_insert_trigger` AFTER INSERT ON `PostControl` FOR EACH ROW BEGIN
   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.PostControlSerNum, NEW.PostType, NEW.PublishFlag, NEW.PostName_FR, NEW.PostName_EN, NEW.Body_FR, NEW.Body_EN, NEW.PublishDate, NEW.Disabled, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.post_control_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `post_control_update_trigger` AFTER UPDATE ON `PostControl` FOR EACH ROW BEGIN
if NEW.LastPublished <=> OLD.LastPublished THEN
   INSERT INTO `PostControlMH`(`PostControlSerNum`, `PostType`, `PublishFlag`, `PostName_FR`, `PostName_EN`, `Body_FR`, `Body_EN`, `PublishDate`, `Disabled`, `DateAdded`, `LastPublished`, `LastUpdatedBy`, `SessionId`, `ModificationAction`) VALUES (NEW.PostControlSerNum, NEW.PostType, NEW.PublishFlag, NEW.PostName_FR, NEW.PostName_EN, NEW.Body_FR, NEW.Body_EN, NEW.PublishDate, NEW.Disabled, NOW(), NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE');
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.questionnaire_control_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `questionnaire_control_delete_trigger` AFTER DELETE ON `QuestionnaireControl` FOR EACH ROW BEGIN
   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (OLD.QuestionnaireControlSerNum, OLD.QuestionnaireDBSerNum, OLD.QuestionnaireName_EN, OLD.QuestionnaireName_FR, OLD.Intro_EN, OLD.Intro_FR, OLD.PublishFlag,NOW(), OLD.LastUpdatedBy, OLD.LastPublished, OLD.SessionId, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.questionnaire_control_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `questionnaire_control_insert_trigger` AFTER INSERT ON `QuestionnaireControl` FOR EACH ROW BEGIN
   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (NEW.QuestionnaireControlSerNum, NEW.QuestionnaireDBSerNum, NEW.QuestionnaireName_EN, NEW.QuestionnaireName_FR, NEW.Intro_EN, NEW.Intro_FR, NEW.PublishFlag,NOW(), NEW.LastUpdatedBy, NEW.LastPublished, NEW.SessionId, 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.questionnaire_control_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `questionnaire_control_update_trigger` AFTER UPDATE ON `QuestionnaireControl` FOR EACH ROW BEGIN
if NEW.LastPublished <=> OLD.LastPublished THEN
   INSERT INTO `QuestionnaireControlMH`(`QuestionnaireControlSerNum`, `QuestionnaireDBSerNum`, `QuestionnaireName_EN`, `QuestionnaireName_FR`, `Intro_EN`, `Intro_FR`, `PublishFlag`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `SessionId`, `ModificationAction` ) VALUES (NEW.QuestionnaireControlSerNum, NEW.QuestionnaireDBSerNum, NEW.QuestionnaireName_EN, NEW.QuestionnaireName_FR, NEW.Intro_EN, NEW.Intro_FR, NEW.PublishFlag,NOW(), NEW.LastUpdatedBy, NEW.LastPublished, NEW.SessionId, 'UPDATE');
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.resourcePending_after_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `resourcePending_after_delete` AFTER DELETE ON `resourcePending` FOR EACH ROW BEGIN
	INSERT INTO resourcePendingMH (resourcePendingId, action, sourceName, appointmentId, resources, `level`, creationDate, createdBy, lastUpdated, updatedBy)
	VALUES
	(OLD.ID, 'DELETE', OLD.sourceName, OLD.appointmentId, OLD.resources, OLD.`level`, NOW(), OLD.createdBy, OLD.lastUpdated, OLD.updatedBy);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.resourcePending_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `resourcePending_after_insert` AFTER INSERT ON `resourcePending` FOR EACH ROW BEGIN
	INSERT INTO resourcePendingMH (resourcePendingId, action, sourceName, appointmentId, resources, `level`, creationDate, createdBy, lastUpdated, updatedBy)
	VALUES
	(NEW.ID, 'INSERT', NEW.sourceName, NEW.appointmentId, NEW.resources, NEW.`level`, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.resourcePending_after_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `resourcePending_after_update` AFTER UPDATE ON `resourcePending` FOR EACH ROW BEGIN
	IF NEW.lastUpdated != OLD.lastUpdated THEN
		INSERT INTO resourcePendingMH (resourcePendingId, action, sourceName, appointmentId, resources, `level`, creationDate, createdBy, lastUpdated, updatedBy)
		VALUES
		(NEW.ID, 'UPDATE', NEW.sourceName, NEW.appointmentId, NEW.resources, NEW.`level`, NOW(), NEW.createdBy, NEW.lastUpdated, NEW.updatedBy);
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.test_result_expression_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `test_result_expression_delete_trigger` AFTER DELETE ON `TestResultExpression` FOR EACH ROW BEGIN
   INSERT INTO `TestResultExpressionMH`(`TestResultControlSerNum`,`ExpressionName`,`LastPublished`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (OLD.TestResultControlSerNum, OLD.ExpressionName, OLD.LastPublished, OLD.LastUpdatedBy, OLD.SessionId, 'DELETE', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.test_result_expression_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `test_result_expression_insert_trigger` AFTER INSERT ON `TestResultExpression` FOR EACH ROW BEGIN
   INSERT INTO `TestResultExpressionMH`(`TestResultControlSerNum`,`ExpressionName`,`LastPublished`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.TestResultControlSerNum, NEW.ExpressionName, NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'INSERT', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.test_result_expression_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `test_result_expression_update_trigger` AFTER UPDATE ON `TestResultExpression` FOR EACH ROW BEGIN
if NEW.LastPublished <=> OLD.LastPublished THEN
   INSERT INTO `TestResultExpressionMH`(`TestResultControlSerNum`,`ExpressionName`,`LastPublished`, `LastUpdatedBy`, `SessionId`, ModificationAction, DateAdded) VALUES (NEW.TestResultControlSerNum, NEW.ExpressionName, NEW.LastPublished, NEW.LastUpdatedBy, NEW.SessionId, 'UPDATE', NOW());
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.txteammessage_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `txteammessage_delete_trigger` AFTER DELETE ON `TxTeamMessage` FOR EACH ROW BEGIN
INSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  VALUES (OLD.TxTeamMessageSerNum,OLD.PatientSerNum, OLD.PostControlSerNum, NOW(), OLD.ReadStatus, 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.txteammessage_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `txteammessage_insert_trigger` AFTER INSERT ON `TxTeamMessage` FOR EACH ROW BEGIN
	INSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `CronLogSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  
	VALUES (NEW.TxTeamMessageSerNum, NEW.CronLogSerNum, NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'INSERT');

	INSERT INTO `Notification` (`CronLogSerNum`, `PatientSerNum`, `NotificationControlSerNum`, `RefTableRowSerNum`, `DateAdded`, `ReadStatus`, `RefTableRowTitle_EN`, `RefTableRowTitle_FR`) 
	SELECT NEW.CronLogSerNum, NEW.PatientSerNum, ntc.NotificationControlSerNum, NEW.TxTeamMessageSerNum, NOW(), 0,
				getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'EN') EN, getRefTableRowTitle(NEW.PostControlSerNum, 'POST', 'FR') FR
	FROM NotificationControl ntc 
	WHERE ntc.NotificationType = 'TxTeamMessage';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.txteammessage_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `txteammessage_update_trigger` AFTER UPDATE ON `TxTeamMessage` FOR EACH ROW BEGIN
INSERT INTO `TxTeamMessageMH`(`TxTeamMessageSerNum`, `PatientSerNum`, `PostControlSerNum`, `DateAdded`, `ReadStatus`, `ModificationAction`)  VALUES (NEW.TxTeamMessageSerNum,NEW.PatientSerNum, NEW.PostControlSerNum, NOW(), NEW.ReadStatus, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.update_message_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `update_message_trigger` AFTER UPDATE ON `Messages` FOR EACH ROW BEGIN
INSERT INTO `MessagesMH`(`MessageSerNum`, `MessageRevSerNum`, `SessionId`, `SenderRole`, `ReceiverRole`, `SenderSerNum`, `ReceiverSerNum`, `MessageContent`, `ReadStatus`, `Attachment`, `MessageDate`, `LastUpdated`, `ModificationAction`) VALUES (NEW.MessageSerNum, NULL, New.SessionId, NEW.SenderRole, NEW.ReceiverRole, NEW.SenderSerNum, NEW.ReceiverSerNum, NEW.MessageContent, NEW.ReadStatus, NEW.Attachment, NEW.MessageDate, NOW(), 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.update_task_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `update_task_trigger` AFTER UPDATE ON `Task` FOR EACH ROW BEGIN
INSERT INTO `TaskMH`(`TaskSerNum`, `CronLogSerNum`, `PatientSerNum`, `AliasExpressionSerNum`, `SourceDatabaseSerNum`, `TaskAriaSer`, `Status`, `State`, `PrioritySerNum`, `DiagnosisSerNum`, `DueDateTime`, `CreationDate`, `CompletionDate`, `DateAdded`, `LastUpdated`, `ModificationAction`) VALUES (NEW.TaskSerNum, NEW.CronLogSerNum, NEW.PatientSerNum,NEW.AliasExpressionSerNum,NEW.SourceDatabaseSerNum,NEW.TaskAriaSer, NEW.Status, NEW.State, NEW.PrioritySerNum, NEW.DiagnosisSerNum, NEW.DueDateTime, NEW.CreationDate, NEW.CompletionDate, NEW.DateAdded,NULL, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.update_test_result_notification_queue_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `update_test_result_notification_queue_trigger` AFTER UPDATE ON `TestResultNotificationQueue` FOR EACH ROW BEGIN
    INSERT INTO `TestResultNotificationProcessingLog`
        (`TestResultNotificationQueueId`, `Status`, `InsertedRows`, `UpdatedRows`, `ProcessingDateTime`,`ProcessingAttemptNumber`,`ProcessingError`,  `ModificationAction`) VALUES (NEW.TestResultNotificationQueueId, NEW.Status, NEW.InsertedRows, NEW.UpdatedRows, NEW.LastProcessingDateTime, NEW.ProcessingAttemptNumber,NEW.LastProcessingError,'UPDATE');
    END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.update_test_result_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `update_test_result_trigger` AFTER UPDATE ON `TestResult` FOR EACH ROW BEGIN
INSERT INTO `TestResultMH`(`TestResultSerNum`, `CronLogSerNum`, `TestResultGroupSerNum`, `TestResultExpressionSerNum`, `PatientSerNum`, `SourceDatabaseSerNum`, `TestResultAriaSer`, `ComponentName`, `FacComponentName`, `AbnormalFlag`, `TestDate`, `MaxNorm`, `MinNorm`, `ApprovedFlag`, `TestValue`, `TestValueString`, `UnitDescription`, `ValidEntry`, `DateAdded`, `ReadStatus`, `ModificationAction`) VALUES (NEW.TestResultSerNum, NEW.CronLogSerNum, NEW.TestResultGroupSerNum, NEW.TestResultExpressionSerNum, NEW.PatientSerNum, NEW.SourceDatabaseSerNum, NEW.TestResultAriaSer, NEW.ComponentName, NEW.FacComponentName, NEW.AbnormalFlag, NEW.TestDate, NEW.MaxNorm, NEW.MinNorm, NEW.ApprovedFlag, NEW.TestValue, NEW.TestValueString, NEW.UnitDescription, NEW.ValidEntry,NOW(), NEW.ReadStatus, 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.users_delete_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `users_delete_trigger` AFTER DELETE ON `Users` FOR EACH ROW BEGIN
INSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`) 
VALUES (OLD.UserSerNum, NULL,OLD.SessionId,OLD.UserType, OLD.UserTypeSerNum, OLD.Username,OLD.Password, NOW(), 'DELETE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.users_insert_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `users_insert_trigger` AFTER INSERT ON `Users` FOR EACH ROW BEGIN
INSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`) 
VALUES (NEW.UserSerNum, NULL,NEW.SessionId,NEW.UserType,  NEW.UserTypeSerNum, NEW.Username,NEW.Password, NOW(), 'INSERT');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger OpalDB.users_update_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `users_update_trigger` AFTER UPDATE ON `Users` FOR EACH ROW BEGIN
INSERT INTO `UsersMH` (`UserSerNum`, `UserRevSerNum`,`SessionId`, `UserType`, `UserTypeSerNum`, `Username`, `Password`,`LastUpdated`, `ModificationAction`) 
VALUES (NEW.UserSerNum, NULL,NEW.SessionId,NEW.UserType, NEW.UserTypeSerNum, NEW.Username,NEW.Password, NOW(), 'UPDATE');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for view OpalDB.v_login
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_login`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_login` AS select `OAUser`.`OAUserSerNum` AS `id`,`OAUser`.`Username` AS `username`,`OAUser`.`Password` AS `password`,`OAUser`.`Language` AS `language`,`OAUser`.`oaRoleId` AS `role`,`OAUser`.`type` AS `type` from `OAUser` where `OAUser`.`deleted` = 0;

-- Dumping structure for view OpalDB.v_masterSourceTestResult
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_masterSourceTestResult`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_masterSourceTestResult` AS select `TestExpression`.`TestExpressionSerNum` AS `ID`,`TestExpression`.`externalId` AS `externalId`,`TestExpression`.`TestCode` AS `code`,`TestExpression`.`ExpressionName` AS `description`,`TestExpression`.`SourceDatabaseSerNum` AS `source`,`TestExpression`.`deleted` AS `deleted`,`TestExpression`.`deletedBy` AS `deletedBy`,`TestExpression`.`DateAdded` AS `creationDate`,`TestExpression`.`createdBy` AS `createdBy`,`TestExpression`.`LastUpdated` AS `lastUpdated`,`TestExpression`.`updatedBy` AS `updatedBy` from `TestExpression`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
