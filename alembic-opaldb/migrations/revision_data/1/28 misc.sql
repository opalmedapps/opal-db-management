CREATE PROCEDURE `getQuestionnaireResults`(
	IN `in_QuestionnaireSerNum` INT
)
Generate_Report : BEGIN
	
	-- Declare variables
	Declare wsQuestionnaireSerNum Int;

	set wsQuestionnaireSerNum = ifnull(in_QuestionnaireSerNum, 0);

	if (wsQuestionnaireSerNum = 0) then
		select "Missing parameter: Please enter the QuestionnaireSerNum";
		leave Generate_Report;
	end if;

	select PQ.PatientQuestionnaireSerNum,
		PQ.DateTimeAnswered,
		QT.QuestionType,
		A.Answer,
		Q2.QuestionQuestion, 
		Q2.QuestionQuestion_FR	
	from 	QuestionnaireDB.PatientQuestionnaire PQ, QuestionnaireDB.Answer A, QuestionnaireDB.Questionnaire Q1, QuestionnaireDB.QuestionnaireQuestion QQ, 
			QuestionnaireDB.Question Q2, QuestionnaireDB.Source S, QuestionnaireDB.QuestionType QT, QuestionnaireDB.Patient P
	where PQ.PatientQuestionnaireSerNum = A.PatientQuestionnaireSerNum
		and A.QuestionnaireQuestionSerNum = QQ.QuestionnaireQuestionSerNum
		and Q1.QuestionnaireSerNum = QQ.QuestionnaireSerNum
		and QQ.QuestionSerNum = Q2.QuestionSerNum
		and Q2.SourceSerNum = S.SourceSerNum
		and Q2.QuestionTypeSerNum = QT.QuestionTypeSerNum
		and PQ.PatientSerNum = P.PatientSerNum
		and PQ.PatientQuestionnaireSerNum in 
				(select Q.PatientQuestionnaireDBSerNum from OpalDB.Questionnaire Q 
					where DateAdded > '2018-11-23' and CompletedFlag = 1 
						and PatientSerNum Not In (51, 92, 197, 198, 204, 200, 199, 124, 229)
						)
		and Q1.QuestionnaireSerNum = wsQuestionnaireSerNum
		and DATE_FORMAT(PQ.DateTimeAnswered, "%Y-%m-%d") >= '2018-11-23'
	order by PQ.PatientQuestionnaireSerNum, PQ.PatientSerNum, QQ.OrderNum asc;

	Select if(CompletedFlag = 0, 'No', 'Yes') Completed_Flag, count(*) 
	from OpalDB.Questionnaire 
		where QuestionnaireControlSerNum = wsQuestionnaireSerNum
	group by CompletedFlag;
	
	Select if(ReadStatus = 0, 'No', 'Yes') Read_Status, count(*) from Notification 
	where RefTableRowSerNum in 
		(select QuestionnaireSerNum 
			from Questionnaire 
			where QuestionnaireControlSerNum = wsQuestionnaireSerNum)
		and NotificationControlSerNum = 13
	group by ReadStatus;

END;

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

/*
* Notification that uses ALIAS
*/
	if (ucase(wsNotificationRequestType) = 'ALIAS') then
		Select A.AliasName_EN, A.AliasName_FR
			into wsLanguage_EN, wsLanguage_FR
		from Alias A, AliasExpression AE 
		where A.AliasSerNum = AE.AliasSerNum
			and AE.AliasExpressionSerNum = wsRefTableRowSerNum;
	end if;
	
/*
* Notification that uses DOCUMENTS
*/
	if (ucase(wsNotificationRequestType) = 'DOCUMENT') then
		Select A.AliasName_EN, A.AliasName_FR
			into wsLanguage_EN, wsLanguage_FR
		from Document D, Alias A, AliasExpression AE 
		where A.AliasSerNum = AE.AliasSerNum
			and AE.AliasExpressionSerNum = D.AliasExpressionSerNum
			and D.DocumentSerNum = wsRefTableRowSerNum;
	end if;

/*
* Notification that uses APPOINTMENTS
*/
	if (ucase(wsNotificationRequestType) = 'APPOINTMENT') then
		Select A.AliasName_EN, A.AliasName_FR
			into wsLanguage_EN, wsLanguage_FR
		from Appointment Apt, Alias A, AliasExpression AE 
		where A.AliasSerNum = AE.AliasSerNum
			and AE.AliasExpressionSerNum = Apt.AliasExpressionSerNum
			and Apt.AppointmentSerNum = wsRefTableRowSerNum;
	end if;

/*
* Notification that uses POST
*/
	if (ucase(wsNotificationRequestType) = 'POST') then
		select PC.PostName_EN, PC.PostName_FR
			into wsLanguage_EN, wsLanguage_FR
		from PostControl PC
		where PC.PostControlSerNum = wsRefTableRowSerNum;
	end if;	

/*
* Notification that uses EDUCATIONAL MATERIAL
*/
	if (ucase(wsNotificationRequestType) = 'EDUCATIONAL') then
		select EC.Name_EN, EC.Name_FR
			into wsLanguage_EN, wsLanguage_FR
		from 	EducationalMaterial E, EducationalMaterialControl EC
		where E.EducationalMaterialControlSerNum = EC.EducationalMaterialControlSerNum
			and E.EducationalMaterialSerNum = wsRefTableRowSerNum;
		
	end if;

/*
* Notification that uses QUESTIONNAIRE
*/
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
END;

CREATE FUNCTION `getTranslation`(`in_TableName` VARCHAR(150),
	`in_ColumnName` VARCHAR(150),
	`in_Text` VARCHAR(250)
,
	`in_RecNo` BIGINT
) RETURNS varchar(250) CHARSET latin1
    DETERMINISTIC
BEGIN

	-- Declare variables
	Declare wsTableName, wsColumnName, wsText, wsReturnText, wsReturn VarChar(255);
	Declare wsActive, wsCount int;
	Declare wsRecNo bigint;

	-- Store the parameters
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

END;

CREATE TABLE IF NOT EXISTS `language` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Prefix` varchar(100) NOT NULL,
  `LanguageName_EN` varchar(200) NOT NULL,
  `LanguageName_FR` varchar(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to store language list.';

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE IF NOT EXISTS `PhaseInTreatment` (
  `PhaseInTreatmentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `Name_EN` varchar(200) NOT NULL,
  `Name_FR` varchar(200) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`PhaseInTreatmentSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `SourceDatabase` (
  `SourceDatabaseSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseName` varchar(255) NOT NULL,
  `Enabled` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`SourceDatabaseSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `study` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `code` varchar(64) DEFAULT NULL COMMENT 'Study ID entered by the user. Mandatory.',
  `title` varchar(256) DEFAULT NULL COMMENT 'Title of the study. Mandatory.',
  `investigator` varchar(256) DEFAULT NULL COMMENT 'Principal investigator of the study. Mandatory.',
  `startDate` date DEFAULT NULL COMMENT 'Start date of the study. Optional.',
  `endDate` date DEFAULT NULL COMMENT 'End date of the study. Optional.',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Mark the record as deleted (1) or not (0)',
  `creationDate` datetime NOT NULL COMMENT 'Date and time of the creation of the record.',
  `createdBy` varchar(255) DEFAULT NULL COMMENT 'Username of the creator of the record.',
  `lastUpdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date and time of the last modification',
  `updatedBy` varchar(255) DEFAULT NULL COMMENT 'Username of the last user who modify the record',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to store terms and agreement docuemnt link(In En & Fr) with version of the document and created and last modified dates.';

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_login` AS select `OAUser`.`OAUserSerNum` AS `id`,`OAUser`.`Username` AS `username`,`OAUser`.`Password` AS `password`,`OAUser`.`Language` AS `language`,`OAUser`.`oaRoleId` AS `role`,`OAUser`.`type` AS `type` from `OAUser` ;

CREATE EVENT `evt_DatabaseMaintenance`
	ON SCHEDULE
		EVERY 1 DAY STARTS '2021-01-01 23:50:00'
	ON COMPLETION NOT PRESERVE
	ENABLE
	COMMENT ''
	DO BEGIN

-- Clean up the Patient Device Identifier table
call proc_CleanPatientDeviceIdentifier;

END;