-- proc_CleanPatientDeviceIdentifier
-- Date range missing
Drop Procedure if exists `proc_CleanPatientDeviceIdentifier`;

Create Procedure `proc_CleanPatientDeviceIdentifier`()
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

-- questionnaireStudy
-- Missing
CREATE TABLE IF NOT EXISTS `questionnaireStudy` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `studyId` bigint(20) NOT NULL,
  `questionnaireId` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_questionnaireStudy_study_id_study_ID` (`studyId`),
  CONSTRAINT `fk_questionnaireStudy_study_id_study_ID` FOREIGN KEY (`studyId`) REFERENCES `study` (`ID`)
);

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

END;

-- Updating the Hospital Identifier Type Description
Update Hospital_Identifier_Type
Set Description_EN = 'Royal Victoria Hospital', Description_FR = 'Hôpital Royal Victoria'
where Hospital_Identifier_Type_Id = 1;

Update Hospital_Identifier_Type
Set Description_EN = 'Montreal General Hospital', Description_FR = 'Hôpital Général de Montréal'
where Hospital_Identifier_Type_Id = 2;

Update Hospital_Identifier_Type
Set Description_EN = 'Montreal Children\'s Hospital', Description_FR = 'Hôpital de Montréal pour enfants'
where Hospital_Identifier_Type_Id = 3;

Update Hospital_Identifier_Type
Set Description_EN = 'Lachine Hospital', Description_FR = 'Hôpital de Lachine'
where Hospital_Identifier_Type_Id = 4;

-- Update the connection to ORMS to get the level
DROP FUNCTION getLevel;

CREATE FUNCTION `getLevel`(
	`in_DateTime` DATETIME,
	`in_Description` VARCHAR(255),
	`in_HospitalMap` INT
)
RETURNS int(11)
LANGUAGE SQL
DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
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

ALTER TABLE `Alias`
	ADD INDEX `idx_A_AliasSerNum` (`AliasSerNum`),
	ADD INDEX `idx_A_AliasType` (`AliasType`),
	ADD INDEX `idx_A_AliasUpdate` (`AliasUpdate`);

ALTER TABLE `AliasExpression`
	ADD INDEX `idx_AE_AliasExpressionSerNum` (`AliasExpressionSerNum`);

ALTER TABLE `Announcement`
	ADD INDEX `idx_An_AnnouncementSerNum` (`AnnouncementSerNum`);

ALTER TABLE `Appointment`
	ADD INDEX `idx_Apt_AppointmentSerNum` (`AppointmentSerNum`),
	ADD INDEX `idx_Apt_Status` (`Status`),
	ADD INDEX `idx_Apt_State` (`State`),
	ADD INDEX `idx_Apt_ScheduledStartTime` (`ScheduledStartTime`);

ALTER TABLE `AppointmentCheckin`
	ADD INDEX `idx_AC_AliasSerNum` (`AliasSerNum`);

ALTER TABLE `cronControlPost`
	ADD INDEX `cronType` (`cronType`),
	ADD INDEX `publishFlag` (`publishFlag`);

ALTER TABLE `cronControlAlias`
	ADD INDEX `idx_CCA_cronType` (`cronType`),
	ADD INDEX `idx_CCA_aliasUpdate` (`aliasUpdate`);

ALTER TABLE `cronControlEducationalMaterial`
	ADD INDEX `idx_CCEM_publishFlag` (`publishFlag`);

ALTER TABLE `cronControlPatient`
	ADD INDEX `idx_CCP_cronType` (`cronType`);

ALTER TABLE `Diagnosis`
	ADD INDEX `idx_Di_DiagnosisSerNum` (`DiagnosisSerNum`),
	ADD INDEX `idx_Di_DiagnosisCode` (`DiagnosisCode`);

ALTER TABLE `Doctor`
	ADD INDEX `idx_Dr_DoctorSerNum` (`DoctorSerNum`),
	ADD INDEX `idx_Dr_ResourceSerNum` (`ResourceSerNum`);

ALTER TABLE `EducationalMaterialControl`
	ADD INDEX `idx_EMC_EducationalMaterialControlSerNum` (`EducationalMaterialControlSerNum`),
	ADD INDEX `idx_EMC_PublishFlag` (`PublishFlag`);

ALTER TABLE `Filters`
	ADD INDEX `idx_F_ControlTable` (`ControlTable`),
	ADD INDEX `idx_F_FilterType` (`FilterType`);

ALTER TABLE `HospitalMap`
	ADD INDEX `idx_HM_HospitalMapSerNum` (`HospitalMapSerNum`);

ALTER TABLE `PatientControl`
	ADD INDEX `idx_PC_PatientSerNum` (`PatientSerNum`),
	ADD INDEX `idx_PC_PatientUpdate` (`PatientUpdate`);

ALTER TABLE `Patient_Hospital_Identifier`
	ADD INDEX `idx_PHI_PatientSerNum` (`PatientSerNum`),
	ADD INDEX `idx_PHI_MRN` (`MRN`);

ALTER TABLE `PostControl`
	ADD INDEX `idx_PostC_PostControlSerNum` (`PostControlSerNum`),
	ADD INDEX `idx_PostC_PostType` (`PostType`),
	ADD INDEX `idx_PostC_PublishFlag` (`PublishFlag`);

ALTER TABLE `Patient`
	ADD INDEX `idx_P_PatientSerNum` (`PatientSerNum`);

ALTER TABLE `PatientDoctor`
	ADD INDEX `idx_PD_OncologistFlag` (`OncologistFlag`),
	ADD INDEX `idx_PD_PrimaryFlag` (`PrimaryFlag`);

ALTER TABLE `Questionnaire`
	ADD INDEX `idx_Q_PatientQuestionnaireDBSerNum` (`PatientQuestionnaireDBSerNum`);

ALTER TABLE `QuestionnaireControl`
	ADD INDEX `idx_QC_QuestionnaireControlSerNum` (`QuestionnaireControlSerNum`),
	ADD INDEX `idx_QC_PublishFlag` (`PublishFlag`);

ALTER TABLE `questionnaireStudy`
	ADD INDEX `idx_QS_questionnaireId` (`questionnaireId`);

ALTER TABLE `Resource`
	ADD INDEX `idx_R_ResourceSerNum` (`ResourceSerNum`);

ALTER TABLE `ResourceAppointment`
	ADD INDEX `idx_RA_ResourceSerNum` (`ResourceSerNum`);

ALTER TABLE `SecurityAnswer`
	ADD INDEX `idx_SA_SecurityQuestionSerNum` (`SecurityQuestionSerNum`);

ALTER TABLE `TxTeamMessage`
	ADD INDEX `idx_TXTM_TxTeamMessageSerNum` (`TxTeamMessageSerNum`);

ALTER TABLE `Users`
	ADD INDEX `idx_U_UserType` (`UserType`),
	ADD INDEX `idx_U_UserTypeSerNum` (`UserTypeSerNum`);
