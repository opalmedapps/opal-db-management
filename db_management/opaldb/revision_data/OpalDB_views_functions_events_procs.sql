-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Adminer 4.8.1 MySQL 5.5.5-10.6.11-MariaDB-1:10.6.11+maria~ubu2004 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

DROP FUNCTION IF EXISTS `getDiagnosisDescription`;
CREATE FUNCTION `getDiagnosisDescription`(`in_DiagnosisCode` VARCHAR(100),
	`in_Language` VARCHAR(2)

) RETURNS varchar(2056) CHARSET latin1 COLLATE latin1_swedish_ci
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
END;

DROP FUNCTION IF EXISTS `getLevel`;
CREATE FUNCTION `getLevel`(`in_DateTime` DATETIME,
	`in_Description` VARCHAR(255),
	`in_HospitalMap` INT
) RETURNS int(11)
    DETERMINISTIC
    COMMENT 'Get the RC or S1 level for the patient appointments'
BEGIN
/*
By: Yick Mo
Date: 2018-06-04

Purpose: This will override the original location of the appointment by figuring out the time of the appointment and where the level where the patient should go depends on what floor the doctor is located during the day.
	The morning shift is AM until 13:00 which is considered PM.

	NOTE: This is temporary for now due to the fact of the hard coding of the database and hospital maps. Need to design this to be more dynamic.
Parameters:
	in_DateTime = date and time of the appointment

	in_Description = description of the appointment
		NOTE:
			OpalDB is AliasExpression table (Description is the fieldname)
			Wait Room Management is Clinic Resources table (ResourceName is the fieldname)

	in_HospitalMap = original location where the patient is suppose to go for their appointment

Update: 2021-09-21 YM
	Removed the connection to ORMS database because we are now using APIs
*/

	-- Declare variables
	Declare wsDateTime DateTime;
	Declare wsDescription, wsCurrentHospitalMap, wsRCLevel, wsDSLevel VarChar(255);
	Declare wsDayOfWeek, wsBloodTest, wsDS_Area VarChar(3);
	Declare wsAMFM, wsReturnLevel VarChar(3);
	Declare wsReturnHospitalMap Int;
	-- Store the parameters
	set wsDateTime = in_DateTime;
	set wsDescription = in_Description;
	set wsCurrentHospitalMap = concat('|', IfNull(in_HospitalMap, ''), '|');

	-- Setup the default map location for RC and DS
	set wsRCLevel = '|20|21|22|23|24|25|'; -- RC Level
	set wsDSLevel = '|10|19|26|'; -- DS Level

	-- Get the three characters of the day
	set wsDayOfWeek = left(DAYNAME(ADDDATE(wsDateTime, INTERVAL 0 DAY)), 3);

	-- Get the AM or PM
	set wsAMFM = if(hour(ADDTIME(wsDateTime, '0 0:00:00')) >= 13, 'PM', 'AM');

	-- Set the variables to default
	set wsBloodTest = 'No';
	set wsDS_Area = 'No';

	-- Step 1) Is the appointment a blood test
	set wsBloodTest = if(ltrim(rtrim(wsDescription)) = 'NS - prise de sang/blood tests pre/post tx', 'Yes', 'No');

	-- Step 2) If not a blood test, then is the appointment description for DS location only
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

	-- Step 3) If it is not a blood test and DS location only, then get the current location of the doctor
	if ((wsBloodTest = 'No') and (wsDS_Area = 'No')) then

		-- Return only the RC or DS location of the doctor
		-- Doctors may be assigned to two different rooms
		/*
		set wsReturnLevel =
			(SELECT Level
				FROM WaitRoomManagementFED.DoctorSchedule USE INDEX (ID_ResourceNameDayAMPM)
				WHERE ResourceName = wsDescription
					AND DAY = wsDayOfWeek
					AND AMPM = wsAMFM
				limit 1);
		*/
		-- If no location found, return N/A
		set wsReturnLevel = (IfNull(wsReturnLevel, 'N/A'));
	end if;


	-- Step 4) Return the location
	set wsReturnHospitalMap = -1;

	if ((wsBloodTest = 'Yes') and (wsDS_Area = 'No')) then
		set wsReturnHospitalMap = 23; -- Return RC level for blood test
	else
		if ((wsBloodTest = 'No') and (wsDS_Area = 'Yes')) then
			set wsReturnHospitalMap = 19; -- Return DS Level for only DS location based on the appointment description
		else

			if ( 	((wsReturnLevel = 'S1') and (instr(wsDSLevel, wsCurrentHospitalMap) > 0))  or
					((wsReturnLevel = 'RC')  and (instr(wsRCLevel, wsCurrentHospitalMap) > 0)) or
					((wsReturnLevel = 'N/A') and (wsCurrentHospitalMap <> '||')) ) then
				set wsReturnHospitalMap = in_HospitalMap; -- If doctor's and appointment location match or if the doctor's location is N/A, then return original location.
			else
				-- If doctor's and appointment location does not match
				if (wsReturnLevel = 'S1') then
					set wsReturnHospitalMap = 19; -- Return DS level
				else
					if (wsReturnLevel = 'RC') then
						set wsReturnHospitalMap = 20; --  Return RC level
					end if;
				end if;
			end if;

		end if;
	end if;

	if (wsReturnHospitalMap = -1) then
		set wsReturnHospitalMap = 20; -- Force default for all appointment when unable to locate one
	end if;

 	Return wsReturnHospitalMap;

END;

DROP FUNCTION IF EXISTS `getRefTableRowTitle`;
CREATE FUNCTION `getRefTableRowTitle`(`in_RefTableRowSerNum` INT,
	`in_NotificationRequestType` VARCHAR(50),
	`in_Language` VARCHAR(2)

) RETURNS varchar(2056) CHARSET latin1 COLLATE latin1_swedish_ci
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

DROP FUNCTION IF EXISTS `getResource`;
CREATE FUNCTION `getResource`(`in_Type` VARCHAR(25),
	`in_AppointmentSerNum` BIGINT
) RETURNS varchar(200) CHARSET latin1 COLLATE latin1_swedish_ci
    DETERMINISTIC
BEGIN
	Declare wsReturn, wsType, wsDescription VarChar(255);
	Declare wsAppointmentSerNum BigInt;
	Declare wsLoopCount, wsCount int;
	set wsType = in_Type;
	set wsAppointmentSerNum = in_AppointmentSerNum;

	select count(*) from ResourceAppointment where AppointmentSerNum = wsAppointmentSerNum into wsCount;

	set wsLoopCount = 0;
	set wsReturn = '';

	while wsLoopCount < wsCount do

		-- ResourceName
		-- ResourceType
		if (trim(wsType) = 'ResourceName') then
			Select trim(ResourceName) from ResourceAppointment RA, Resource R
			where RA.AppointmentSerNum = wsAppointmentSerNum and RA.ResourceSerNum = R.ResourceSerNum
			limit wsLoopCount,1 into wsDescription;

			set wsReturn = wsDescription;
			-- set wsReturn = concat(wsReturn, wsDescription);

		end if;

		if (wsType = 'ResourceType') then
			Select trim(ResourceType) from ResourceAppointment RA, Resource R
			where RA.AppointmentSerNum = wsAppointmentSerNum and RA.ResourceSerNum = R.ResourceSerNum
			limit wsLoopCount,1 into wsDescription;

			set wsReturn = wsDescription;
		end if;

		-- set wsReturn = concat(wsReturn, wsDescription);

		Set wsLoopCount = wsLoopCount + 1;

		if (wsLoopCount < wsCount) then
			set wsReturn = concat(wsReturn, ' -- ');
		end if;

	end while;

	Return wsReturn;

END;

DROP FUNCTION IF EXISTS `getTranslation`;
CREATE FUNCTION `getTranslation`(`in_TableName` VARCHAR(150),
	`in_ColumnName` VARCHAR(150),
	`in_Text` VARCHAR(250)
,
	`in_RecNo` BIGINT
) RETURNS varchar(250) CHARSET latin1 COLLATE latin1_swedish_ci
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

DROP FUNCTION IF EXISTS `insertPatient`;
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

END;

DROP FUNCTION IF EXISTS `reg_insertPatientHospitalIdentifier`;
CREATE FUNCTION `reg_insertPatientHospitalIdentifier`(`i_PatientSerNum` BIGINT,
	`i_Mrn` VARCHAR(50),
	`i_Site` VARCHAR(50)
) RETURNS varchar(50) CHARSET latin1 COLLATE latin1_swedish_ci
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
	SET wsCount = (SELECT COUNT(*) FROM Patient_Hospital_Identifier where MRN = wsMrn and Hospital_Identifier_Type_Code = wsSite);

	if (wsCount > 0) then
		SET wsReturn = -1;
	else
		insert into Patient_Hospital_Identifier(PatientSerNum, MRN, Hospital_Identifier_Type_Code) values (wsPatientSerNum, wsMrn, wsSite);
		SET wsReturn = 1; --  (SELECT COUNT(*) FROM Patient_Hospital_Identifier where PatientSerNum = wsPatientSerNum);
	END if;

 return wsReturn;
END;

DROP FUNCTION IF EXISTS `reg_UpdatePatientInfo`;
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
) RETURNS varchar(100) CHARSET latin1 COLLATE latin1_swedish_ci
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

		set wsStatus = 'Successfully Update';
 	else
		set wsStatus = 'Failed to Update';
	end if;

	return wsStatus;

END;

DROP PROCEDURE IF EXISTS `getQuestionnaireResults`;
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

DROP PROCEDURE IF EXISTS `my_memory`;
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

# Summarizing:
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

END;

DROP PROCEDURE IF EXISTS `proc_CleanPatientDeviceIdentifier`;
CREATE PROCEDURE `proc_CleanPatientDeviceIdentifier`()
BEGIN
/****************************************************************************************************
Purpose: This stored procedure is to remove records from the table PatientDeviceIdentifier with
the following condition.
1. Any registration ID that is empty
2. Any test accounts that are over a specified date

Reason:
1. Remove useless records that is not in use. Especially caused by testing.
2. People change cell phones
3. Updating the app changles the device ID
4. Some tester are actually real patient
****************************************************************************************************/

/****************************************************************************************************
Remove old push notification that were sent to test accounts
****************************************************************************************************/
delete from PushNotification
where PatientDeviceIdentifierSerNum in
	(Select PatientDeviceIdentifierSerNum from PatientDeviceIdentifier
	where LastUpdated <= DATE_SUB(curdate(), INTERVAL 14 DAY)
		and PatientSerNum in
		(
		select Distinct PatientSerNum From Patient_Hospital_Identifier PHI
		where (MRN in ('9999991', '9999992', '9999993', '9999995', '9999996', '9999997',
					'Opal1', 'Opal2', 'Opal3', 'Opal4', 'Opal5', 'Opal6',
					'3333', 'AAAA1', '1092300', '5324122', 'QA_0630', 'QA_ DAW_APP_HEAD',
					'Opal4temp', 'OpalDemo1'
					)
				and PHI.Hospital_Identifier_Type_Code = 'RVH')
				or
				(MRN in ('9999992', '9999998'
					)
				and PHI.Hospital_Identifier_Type_Code = 'MGH')
				or
				(MRN in ('1430016'
					)
				and PHI.Hospital_Identifier_Type_Code = 'MCH')
		)
	)
;

/****************************************************************************************************
Remove any records that are older than specified date
****************************************************************************************************/
delete from PatientDeviceIdentifier
where LastUpdated <= DATE_SUB(curdate(), INTERVAL 14 DAY)
	and PatientSerNum in
		(
		select Distinct PatientSerNum From Patient_Hospital_Identifier PHI
		where (MRN in ('9999991', '9999992', '9999993', '9999995', '9999996', '9999997',
					'Opal1', 'Opal2', 'Opal3', 'Opal4', 'Opal5', 'Opal6',
					'3333', 'AAAA1', '1092300', '5324122', 'QA_0630', 'QA_ DAW_APP_HEAD',
					'Opal4temp', 'OpalDemo1'
					)
				and PHI.Hospital_Identifier_Type_Code = 'RVH')
				or
				(MRN in ('9999992', '9999998'
					)
				and PHI.Hospital_Identifier_Type_Code = 'MGH')
				or
				(MRN in ('1430016'
					)
				and PHI.Hospital_Identifier_Type_Code = 'MCH')
		)
;

END;

DROP PROCEDURE IF EXISTS `reg_getAccessLevelList`;
CREATE PROCEDURE `reg_getAccessLevelList`(
	IN `i_RAMQ` VARCHAR(20)
)
    COMMENT 'Procedure to get accesslevel data.'
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;

-- Store the parameters
set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select Id, AccessLevelName_EN, AccessLevelName_FR from accesslevel order by Id;
else
Select 0 AS Error;
end if;
END;

DROP PROCEDURE IF EXISTS `reg_getLanguageList`;
CREATE PROCEDURE `reg_getLanguageList`(
	IN `i_RAMQ` VARCHAR(20)
)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;

-- Store the parameters
set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select Id,Prefix, LanguageName_EN, LanguageName_FR from language order by Id;
else
Select 0 AS Error;
end if;
END;

DROP PROCEDURE IF EXISTS `reg_getSecurityQuestions`;
CREATE PROCEDURE `reg_getSecurityQuestions`(
	IN `i_RAMQ` VARCHAR(20)
)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;

-- Store the parameters
set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select SecurityQuestionSerNum, QuestionText_EN, QuestionText_FR from SecurityQuestion where Active = 1 order by SecurityQuestionSerNum;
else
Select 0 AS Error;
end if;
END;

DROP PROCEDURE IF EXISTS `reg_getTermsandAggrementDocuments`;
CREATE PROCEDURE `reg_getTermsandAggrementDocuments`(
	IN `i_RAMQ` VARCHAR(20)
)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;

-- Store the parameters
set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select Id,DocumentLink_EN, DocumentLink_FR, PDFLink_EN, PDFLink_FR from termsandagreement where Active = 1 order by Id;
else
Select 0 AS Error;
end if;
END;

DROP PROCEDURE IF EXISTS `reg_getUserName`;
CREATE PROCEDURE `reg_getUserName`(
	IN `i_RAMQ` VARCHAR(20)
)
BEGIN
Declare wsRAMQ VarChar(50);
Declare wsValid int;

-- Store the parameters
set wsRAMQ  = IfNull(i_RAMQ, 'Error');

set wsValid = (SELECT count(*) from Patient where SSN = wsRAMQ);

if (wsValid > 0) then
Select FirstName,LastName from Patient as result where SSN = wsRAMQ;
else
Select 0 AS Error;
end if;
END;

DROP EVENT IF EXISTS `evt_DatabaseMaintenance`;
CREATE EVENT `evt_DatabaseMaintenance` ON SCHEDULE EVERY 1 DAY STARTS '2021-01-01 23:50:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

-- Clean up the Patient Device Identifier table
call proc_CleanPatientDeviceIdentifier;

END;

DROP VIEW IF EXISTS `v_login`;
CREATE TABLE `v_login` (`id` int(11), `username` varchar(1000), `password` varchar(1000), `language` enum('EN','FR'), `role` bigint(20), `type` tinyint(1));


DROP VIEW IF EXISTS `v_masterSourceTestResult`;
CREATE TABLE `v_masterSourceTestResult` (`ID` int(11), `externalId` varchar(512), `code` varchar(30), `description` varchar(100), `source` int(11), `deleted` int(1), `deletedBy` varchar(255), `creationDate` datetime, `createdBy` varchar(255), `lastUpdated` timestamp, `updatedBy` varchar(255));


DROP TABLE IF EXISTS `v_login`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_login` AS select `OAUser`.`OAUserSerNum` AS `id`,`OAUser`.`Username` AS `username`,`OAUser`.`Password` AS `password`,`OAUser`.`Language` AS `language`,`OAUser`.`oaRoleId` AS `role`,`OAUser`.`type` AS `type` from `OAUser` where `OAUser`.`deleted` = 0;

DROP TABLE IF EXISTS `v_masterSourceTestResult`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_masterSourceTestResult` AS select `TestExpression`.`TestExpressionSerNum` AS `ID`,`TestExpression`.`externalId` AS `externalId`,`TestExpression`.`TestCode` AS `code`,`TestExpression`.`ExpressionName` AS `description`,`TestExpression`.`SourceDatabaseSerNum` AS `source`,`TestExpression`.`deleted` AS `deleted`,`TestExpression`.`deletedBy` AS `deletedBy`,`TestExpression`.`DateAdded` AS `creationDate`,`TestExpression`.`createdBy` AS `createdBy`,`TestExpression`.`LastUpdated` AS `lastUpdated`,`TestExpression`.`updatedBy` AS `updatedBy` from `TestExpression`;

-- 2023-01-13 15:59:28

-- 2023-10-25 QSCCD-1610 Optimize cronjob performance by creating new event to clean appointment tables periodically

CREATE PROCEDURE `proc_AppointmentPendingCleanup`()
    COMMENT 'This is a temporary cleanup of pending appointment until a new Alias system is created'
BEGIN
/****************************************************************************************************
Purpose: This stored procedure is to remove old appointents in the AppointmentPending and
resourcePending tables that are older than 30 days. It will also remove any appointment status
that are "Deleted" and also clean up the resourcePending table that does not have any appointments in
the AppointmentPending table.

Reason: Only keep today and future appointments
****************************************************************************************************/

DELETE FROM resourcePending
WHERE appointmentId IN (SELECT B.SourceSystemID FROM AppointmentPending B
WHERE DATE(B.ScheduledStartTime) < DATE(ADDDATE(NOW(), INTERVAL -30 DAY))
);

DELETE FROM resourcePending
WHERE appointmentId IN
(SELECT B.SourceSystemID FROM AppointmentPending B
WHERE B.`Status` = 'Deleted'
);

DELETE FROM AppointmentPending
WHERE DATE(ScheduledStartTime) < DATE(ADDDATE(NOW(), INTERVAL -30 DAY));

DELETE FROM AppointmentPending
WHERE `Status` = 'Deleted';

DELETE FROM resourcePending
WHERE appointmentId NOT IN (SELECT B.SourceSystemID FROM AppointmentPending B);

END;

CREATE EVENT `evt_Cleanup` ON SCHEDULE EVERY 1 DAY STARTS '2023-10-25 01:00:00' ON COMPLETION PRESERVE ENABLE COMMENT 'This is temporary for now' DO BEGIN
	-- remove old and deleted appointmens
	call proc_AppointmentPendingCleanup;
END;


USE OpalDB;
DROP PROCEDURE IF EXISTS `fetch_patient_data`;
CREATE PROCEDURE `fetch_patient_data` (IN `i_OpalDB_PatientSerNum` INT)
BEGIN
    DECLARE ser_num_valid INT;
    DECLARE function_status VARCHAR(100);

    SET @patient_ser_num = i_OpalDB_PatientSerNum;
    SET ser_num_valid = (SELECT COUNT(*) FROM `OpalDB`.Patient WHERE PatientSerNum = @patient_ser_num);

    IF ser_num_valid = 1 THEN
      -- identifiers
		SELECT * FROM `OpalDB`.Patient p WHERE PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.PatientControl pc WHERE pc.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.Patient_Hospital_Identifier phi WHERE phi.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.Users u WHERE u.UserTypeSerNum=@patient_ser_num;

		-- diagnosis
		SELECT * FROM `OpalDB`.Diagnosis d WHERE d.PatientSerNum=@patient_ser_num;

		-- announcements
		SELECT * FROM `OpalDB`.Announcement a WHERE a.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.PostControl pc WHERE pc.PostControlSerNum IN (SELECT a.PostControlSerNum FROM `OpalDB`.Announcement a WHERE a.PatientSerNum=@patient_ser_num);

		-- documents (To add in db-docker/backend: Pathology)
		SELECT * FROM `OpalDB`.Document d WHERE d.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.AliasExpression ae WHERE ae.AliasExpressionSerNum IN (SELECT d.AliasExpressionSerNum FROM `OpalDB`.Document d WHERE d.PatientSerNum=@patient_ser_num);
		SELECT * FROM `OpalDB`.Alias a WHERE a.AliasSerNum IN (SELECT ae.AliasSerNum FROM `OpalDB`.AliasExpression ae WHERE ae.AliasExpressionSerNum IN (SELECT d.AliasExpressionSerNum FROM `OpalDB`.Document d WHERE d.PatientSerNum=@patient_ser_num));


		-- patient actions and activity logs
		SELECT * FROM `OpalDB`.PatientActionLog pal WHERE pal.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.PatientActivityLog pal WHERE pal.Username IN (SELECT u.Username FROM `OpalDB`.Users u WHERE u.UserTypeSerNum=@patient_ser_num);

		-- appointment data
		SELECT * FROM `OpalDB`.Appointment a WHERE a.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.AliasExpression ae WHERE ae.AliasExpressionSerNum IN (SELECT a.AliasExpressionSerNum FROM `OpalDB`.Appointment a WHERE a.PatientSerNum=@patient_ser_num);
		SELECT * FROM `OpalDB`.Alias a WHERE a.AliasSerNum IN (SELECT ae.AliasSerNum FROM `OpalDB`.AliasExpression ae WHERE ae.AliasExpressionSerNum IN (SELECT a.AliasExpressionSerNum FROM `OpalDB`.Appointment a WHERE a.PatientSerNum=@patient_ser_num));

		-- labs
		SELECT * FROM `OpalDB`.PatientTestResult ptr WHERE ptr.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.TestGroupExpression tge WHERE tge.TestGroupExpressionSerNum IN (SELECT ptr.TestGroupExpressionSerNum FROM `OpalDB`.PatientTestResult ptr WHERE ptr.PatientSerNum=@patient_ser_num);
		SELECT * FROM `OpalDB`.TestExpression te WHERE te.TestExpressionSerNum IN (SELECT ptr.TestExpressionSerNum FROM `OpalDB`.PatientTestResult ptr WHERE ptr.PatientSerNum=@patient_ser_num);

		-- tx team messages
		SELECT * FROM `OpalDB`.TxTeamMessage tx WHERE tx.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.PostControl pc WHERE pc.PostControlSerNum IN (SELECT tx.PostControlSerNum FROM `OpalDB`.TxTeamMessage tx WHERE tx.PatientSerNum=@patient_ser_num);

		-- educational materials
		SELECT * FROM `OpalDB`.EducationalMaterial em WHERE em.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.EducationalMaterialControl emc WHERE emc.EducationalMaterialControlSerNum IN (SELECT em.EducationalMaterialControlSerNum FROM `OpalDB`.EducationalMaterial em WHERE em.PatientSerNum=@patient_ser_num);
		SELECT * FROM `OpalDB`.EducationalMaterialPackageContent empc WHERE empc.EducationalMaterialControlSerNum IN (SELECT em.EducationalMaterialControlSerNum FROM `OpalDB`.EducationalMaterial em WHERE em.PatientSerNum=@patient_ser_num);
		SELECT *
		   FROM `OpalDB`.EducationalMaterialControl emc WHERE emc.EducationalMaterialControlSerNum IN (
				SELECT empc.ParentSerNum FROM `OpalDB`.EducationalMaterialPackageContent empc
				WHERE empc.EducationalMaterialControlSerNum IN (
					SELECT em.EducationalMaterialControlSerNum
					FROM `OpalDB`.EducationalMaterial em
					WHERE em.PatientSerNum=@patient_ser_num
				)
		);

		-- Notifications ?
		-- These should get auto-inserted by the Notification triggers, so can be ignored
		-- SELECT * FROM Notification n WHERE n.PatientSerNum=@patient_ser_num;

		-- questionnaires
		SELECT * FROM `OpalDB`.Questionnaire q WHERE q.PatientSerNum=@patient_ser_num;
		SELECT * FROM `OpalDB`.QuestionnaireControl qc WHERE qc.QuestionnaireControlSerNum IN (SELECT q.QuestionnaireControlSerNum FROM `OpalDB`.Questionnaire q WHERE q.PatientSerNum=@patient_ser_num);


		-- ------------------------------------------- QUESTIONNAIREDB DATA

		-- Get patient identifier for QstnDB
		SELECT * FROM `QuestionnaireDB`.patient p WHERE p.externalId=@patient_ser_num;
		SET @patient_qstndb_id = (SELECT p.ID FROM `QuestionnaireDB`.patient p WHERE p.externalId=@patient_ser_num);

		-- Start from answerQuestionnaire records to get questionnaire records
		SELECT * FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0;

		-- ------------------------------------------- All data for the definition of the questionnaires themselves

		SELECT * FROM `QuestionnaireDB`.questionnaire q WHERE q.ID IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0);
		-- all dictionary contents for the questionnaire itself
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT q.title FROM `QuestionnaireDB`.questionnaire q WHERE q.ID IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		   UNION
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT q.nickname FROM `QuestionnaireDB`.questionnaire q WHERE q.ID IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		   UNION
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT q.`description` FROM `QuestionnaireDB`.questionnaire q WHERE q.ID IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		   UNION
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT q.instruction FROM `QuestionnaireDB`.questionnaire q WHERE q.ID IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		;

		SELECT * FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0);
		-- dictionary contents for section
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT sec.title FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		UNION
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT sec.instruction FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		;

		SELECT * FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0));
		SELECT * FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		);
		-- dictionary contents for question
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT q.display FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		))
		   UNION
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT q.`definition` FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		))
		   UNION
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT q.`question` FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		));

		-- checkbox options and translations for the relevant questions
		SELECT * FROM `QuestionnaireDB`.checkbox che WHERE che.questionId IN (SELECT q.ID FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		));
		SELECT * FROM `QuestionnaireDB`.checkboxOption copt WHERE copt.parentTableId IN (SELECT che.ID FROM `QuestionnaireDB`.checkbox che WHERE che.questionId IN (SELECT q.ID FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		)));
		-- dictionary content for the checkbox options
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT copt.`description` FROM `QuestionnaireDB`.checkboxOption copt WHERE copt.parentTableId IN (SELECT che.ID FROM `QuestionnaireDB`.checkbox che WHERE che.questionId IN (SELECT q.ID FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		))));

		-- radio buttons and translations for the relevant questions
		SELECT * FROM `QuestionnaireDB`.radioButton rb WHERE rb.questionId IN (SELECT q.ID FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		));
		SELECT * FROM `QuestionnaireDB`.radioButtonOption rbopt WHERE rbopt.parentTableId IN (SELECT rb.ID FROM `QuestionnaireDB`.radioButton rb WHERE rb.questionId IN (SELECT q.ID FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		)));
		-- dictionary content for radio button options
		SELECT * FROM `QuestionnaireDB`.dictionary d WHERE d.contentId IN (SELECT rbopt.`description` FROM `QuestionnaireDB`.radioButtonOption rbopt WHERE rbopt.parentTableId IN (SELECT rb.ID FROM `QuestionnaireDB`.radioButton rb WHERE rb.questionId IN (SELECT q.ID FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		))));

		-- sliders
		SELECT * FROM `QuestionnaireDB`.slider sl WHERE sl.questionId IN (SELECT q.ID FROM `QuestionnaireDB`.question q WHERE q.ID IN (
			SELECT qsec.questionId FROM `QuestionnaireDB`.questionSection qsec WHERE qsec.sectionId IN (SELECT sec.ID FROM `QuestionnaireDB`.section sec WHERE sec.questionnaireId IN (SELECT aq.questionnaireId FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0))
		));

		-- ------------------------------------------- All data for the answers to the questionnaires

		SELECT * FROM `QuestionnaireDB`.answerSection asec WHERE asec.answerQuestionnaireId IN (SELECT aq.ID FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0);
		SELECT * FROM `QuestionnaireDB`.answer a WHERE a.answerSectionId IN (SELECT asec.ID FROM `QuestionnaireDB`.answerSection asec WHERE asec.answerQuestionnaireId IN (SELECT aq.ID FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0));

		SELECT * FROM `QuestionnaireDB`.answerCheckbox ache WHERE ache.answerId IN (
			SELECT a.ID FROM `QuestionnaireDB`.answer a WHERE a.answerSectionId IN (
				SELECT asec.ID FROM `QuestionnaireDB`.answerSection asec WHERE asec.answerQuestionnaireId IN (
					SELECT aq.ID FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0
				)
			)
		);
		SELECT * FROM `QuestionnaireDB`.answerRadioButton arb WHERE arb.answerId IN (
			SELECT a.ID FROM `QuestionnaireDB`.answer a WHERE a.answerSectionId IN (
				SELECT asec.ID FROM `QuestionnaireDB`.answerSection asec WHERE asec.answerQuestionnaireId IN (
					SELECT aq.ID FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0
				)
			)
		);
		SELECT * FROM `QuestionnaireDB`.answerSlider asli WHERE asli.answerId IN (
			SELECT a.ID FROM `QuestionnaireDB`.answer a WHERE a.answerSectionId IN (
				SELECT asec.ID FROM `QuestionnaireDB`.answerSection asec WHERE asec.answerQuestionnaireId IN (
					SELECT aq.ID FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0
				)
			)
		);
		SELECT * FROM `QuestionnaireDB`.answerTextBox  atb WHERE atb.answerId IN (
			SELECT a.ID FROM `QuestionnaireDB`.answer a WHERE a.answerSectionId IN (
				SELECT asec.ID FROM `QuestionnaireDB`.answerSection asec WHERE asec.answerQuestionnaireId IN (
					SELECT aq.ID FROM `QuestionnaireDB`.answerQuestionnaire aq WHERE aq.patientId = @patient_qstndb_id AND aq.deleted=0
				)
			)
		);


        SET function_status = 'Success';
    ELSE
        SET function_status = 'Invalid PatientSerNum';
    END IF;

    SELECT function_status;
END;
