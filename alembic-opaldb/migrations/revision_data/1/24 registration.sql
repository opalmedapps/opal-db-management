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

END;

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

