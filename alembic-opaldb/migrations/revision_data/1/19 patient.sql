CREATE TABLE IF NOT EXISTS `Hospital_Identifier_Type` (
  `Hospital_Identifier_Type_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(20) NOT NULL,
  `ADT_Web_Service_Code` varchar(20) NOT NULL,
  `Description_EN` varchar(250) NOT NULL,
  `Description_FR` varchar(250) NOT NULL,
  PRIMARY KEY (`Hospital_Identifier_Type_Id`),
  UNIQUE KEY `HIT_code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE FUNCTION `insertPatient`(`i_PatientId` VARCHAR(50),
	`i_FirstName` VARCHAR(50),
	`i_LastName` VARCHAR(50),
	`i_Sex` VARCHAR(25),
	`i_DateOfBirth` DATETIME,
	`i_TelNum` BIGINT,
	`i_SSN` VARCHAR(16)
) RETURNS bigint(20)
    DETERMINISTIC
    COMMENT 'Inserting Patient Record'
BEGIN

declare wsmrn, wsfirstName, wslastName, wssex, wsramqNumber, wsDOB varchar(100);
declare wshomePhoneNumber bigint;
declare wsPatientSerNum bigint;

set wsmrn = ifnull(i_PatientId, -1);
set wsfirstName = i_FirstName;
set wslastName = i_LastName;
set wssex = i_Sex;
set wsramqNumber = ifnull(i_SSN, '');
set wsDOB = LEFT(i_DateOfBirth,10);
set wshomePhoneNumber = i_TelNum;
set wsPatientSerNum = -1;

if ((wsmrn > -1) and (wsramqNumber <> '')) then

	set wsPatientSerNum = (select ifnull((select PatientSerNum from Patient where ((PatientId = wsmrn) or (SSN = wsramqNumber)) limit 1), -1) as PatientSerNum);

	if (wsPatientSerNum < 0) then
		INSERT INTO Patient
			(PatientId,FirstName,LastName,Sex,DateOfBirth,Age,TelNum,EnableSMS,SSN)
		VALUES (wsmrn, wsfirstName, wslastName, wssex, wsDOB, TIMESTAMPDIFF(year, wsDOB, now()), wshomePhoneNumber, 0, wsramqNumber);
		
		set wsPatientSerNum = (select ifnull((select PatientSerNum from Patient where ((PatientId = wsmrn) or (SSN = wsramqNumber)) limit 1), -1) as PatientSerNum);
	else
		update Patient set PatientId = wsmrn, FirstName = wsfirstName, LastName = wslastName, Sex=wssex , DateOfBirth=wsDOB, Age = TIMESTAMPDIFF(year, wsDOB, now()), TelNum=wshomePhoneNumber, SSN=wsramqNumber
		where PatientSerNum = wsPatientSerNum;
		
		set wsPatientSerNum = (select ifnull((select PatientSerNum from Patient where ((PatientId = wsmrn) or (SSN = wsramqNumber)) limit 1), -1) as PatientSerNum);
	end if;
	
end if;

Return wsPatientSerNum;

END;

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
  KEY `PatientAriaSer` (`PatientAriaSer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Log of the actions a user takes in the app (clicking, scrolling to bottom, etc.)';

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `PatientControl` (
  `PatientSerNum` int(11) NOT NULL,
  `PatientUpdate` int(11) NOT NULL DEFAULT 1,
  `LastTransferred` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `TransferFlag` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`PatientSerNum`),
  KEY `TransferFlag_IDX` (`TransferFlag`),
  CONSTRAINT `PatientControl_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `PatientDeviceIdentifier` (
  `PatientDeviceIdentifierSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` int(11) NOT NULL,
  `DeviceId` varchar(255) NOT NULL,
  `appVersion` varchar(16) NOT NULL COMMENT 'Version of Opal App installed on patient device. Eg 1.10.9. Optional.',
  `RegistrationId` varchar(256) NOT NULL,
  `DeviceType` tinyint(4) NOT NULL COMMENT '0 = iOS, 1 = Android, 3 = browser',
  `SessionId` text NOT NULL,
  `SecurityAnswerSerNum` int(11) DEFAULT NULL,
  `Attempt` int(11) NOT NULL DEFAULT 0,
  `Trusted` tinyint(1) NOT NULL DEFAULT 0,
  `TimeoutTimestamp` timestamp NULL DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PatientDeviceIdentifierSerNum`),
  UNIQUE KEY `patient_device` (`PatientSerNum`,`DeviceId`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `SecurityAnswerSerNum` (`SecurityAnswerSerNum`),
  CONSTRAINT `PatientDeviceIdentifier_ibfk_2` FOREIGN KEY (`SecurityAnswerSerNum`) REFERENCES `SecurityAnswer` (`SecurityAnswerSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientDeviceIdentifier_ibfk_3` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  CONSTRAINT `PatientDoctor_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `PatientDoctor_ibfk_2` FOREIGN KEY (`DoctorSerNum`) REFERENCES `Doctor` (`DoctorSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `PatientDoctorHistory` (
  `PatientDoctorSerNum` int(11) NOT NULL DEFAULT 0,
  `PatientSerNum` int(11) NOT NULL,
  `DoctorSerNum` int(11) NOT NULL,
  `OncologistFlag` int(11) NOT NULL,
  `PrimaryFlag` int(11) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  PRIMARY KEY (`PatientSerNum`,`PatientRevSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `patientStudy` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key. Auto-increment.',
  `patientId` int(11) NOT NULL COMMENT 'Foreign key with PatientSerNum in Patient table',
  `studyId` bigint(20) NOT NULL COMMENT 'Foreign key with Id in study table.',
  PRIMARY KEY (`ID`),
  KEY `fk_patientStudy_patientId_Patient_PatientSerNum_idx` (`patientId`),
  KEY `fk_patientStudy_patientId_study_ID_idx` (`studyId`),
  CONSTRAINT `fk_patientStudy_patientId_Patient_PatientSerNum` FOREIGN KEY (`patientId`) REFERENCES `Patient` (`PatientSerNum`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patientStudy_patientId_study_ID` FOREIGN KEY (`studyId`) REFERENCES `study` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  CONSTRAINT `FK_HPI_HospIdType` FOREIGN KEY (`Hospital_Identifier_Type_Code`) REFERENCES `Hospital_Identifier_Type` (`Code`),
  CONSTRAINT `FK_HPI_Patient` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

END;

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
  CONSTRAINT `SecurityAnswer_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SecurityAnswer_ibfk_2` FOREIGN KEY (`SecurityQuestionSerNum`) REFERENCES `SecurityQuestion` (`SecurityQuestionSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `SecurityQuestion` (
  `SecurityQuestionSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionText_EN` varchar(2056) NOT NULL,
  `QuestionText_FR` varchar(2056) NOT NULL,
  `CreationDate` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Active` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 = Disable / 1 = Enable',
  PRIMARY KEY (`SecurityQuestionSerNum`),
  KEY `Index 2` (`Active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Users` (
  `UserSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `UserType` varchar(255) NOT NULL,
  `UserTypeSerNum` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL COMMENT 'This field is Firebase User UID',
  `Password` varchar(255) NOT NULL,
  `SessionId` text DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`UserSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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