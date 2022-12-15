/* dbv_opaldb/data/revisions/1/ */

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
		set wsReturnLevel = 
			(SELECT Level 
				FROM WaitRoomManagementFED.DoctorSchedule USE INDEX (ID_ResourceNameDayAMPM)
				WHERE ResourceName = wsDescription
					AND DAY = wsDayOfWeek
					AND AMPM = wsAMFM
				limit 1);

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
END;

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
	SET wsCount = (SELECT COUNT(*) FROM Patient_Hospital_Identifier where MRN = wsMrn and Hospital_Identifier_Type_Code = wsSite);
	
	if (wsCount > 0) then
		SET wsReturn = -1;
	else
		insert into Patient_Hospital_Identifier(PatientSerNum, MRN, Hospital_Identifier_Type_Code) values (wsPatientSerNum, wsMrn, wsSite);
		SET wsReturn = 1; --  (SELECT COUNT(*) FROM Patient_Hospital_Identifier where PatientSerNum = wsPatientSerNum);
	END if;

 return wsReturn;
END;

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
		
		update Patient set Email = wsEmail, `Language` = wsLanguage, `AccessLevel` = wsAccessLevelID, SessionId='Opalmedapps' , RegistrationDate = NOW(), ConsentFormExpirationDate = Date_add(Now(), interval 1 year), `TermsAndAgreementSign`=wsTermsAndAgreementID, TermsAndAgreementSignDateTime = NOW()
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
END;

CREATE FUNCTION `getResource`(`in_Type` VARCHAR(25),
	`in_AppointmentSerNum` BIGINT
) RETURNS varchar(200) CHARSET latin1
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

/* dbv_opaldb/data/revisions/2/ */

DROP FUNCTION IF EXISTS `insertPatient`;
-- Dumping structure for function OpalDB.insertPatient

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

DROP FUNCTION IF EXISTS `reg_UpdatePatientInfo`;

-- Dumping structure for function OpalDB20210621.reg_UpdatePatientInfo
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

END;


/* dbv_opaldb/data/revisions/3/ */

/* dbv_opaldb/data/revisions/4/ */

/* dbv_opaldb/data/revisions/5/ */

/* dbv_opaldb/data/revisions/6/ */

/* dbv_opaldb/data/revisions/7/ */

/* dbv_opaldb/data/revisions/8/ */

/* dbv_opaldb/data/revisions/9/ */

/* dbv_opaldb/data/revisions/10/ */

/* dbv_opaldb/data/revisions/11/ */