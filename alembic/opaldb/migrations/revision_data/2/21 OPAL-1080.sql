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
