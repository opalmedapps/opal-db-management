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


-- Dumping database structure for registerdb
CREATE DATABASE IF NOT EXISTS `registerdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `registerdb`;

-- Dumping structure for table registerdb.accesslevelconsent
CREATE TABLE IF NOT EXISTS `accesslevelconsent` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` bigint(20) NOT NULL,
  `AccessLevelId` bigint(20) NOT NULL,
  `AccessLevelSign` tinyint(4) NOT NULL DEFAULT 0,
  `AccessLevelSignDateTime` datetime NOT NULL,
  `CreationDate` timestamp NULL DEFAULT NULL,
  `LastModifyDate` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table to store patient access level agreement. It stores which access level patient choose along with consent checked(1)/unchecked(0) with timestamp.';

-- Data exporting was unselected.

-- Dumping structure for event registerdb.CheckIP
DELIMITER //
CREATE EVENT `CheckIP` ON SCHEDULE EVERY 2 MINUTE STARTS '2019-08-07 15:42:03' ON COMPLETION PRESERVE ENABLE DO BEGIN
/*
Purpose:
	Check for abusive IP and block them
*/

Insert Into ipblock (IP)
(Select IP from iplog
where DateAdded >= Date_Format(Date_Add(now(), INTERVAL - 1 day), '%Y-%m-%d %T')
and IP not in (select IP from ipexclude where Active = 'Yes')
and IP not in (Select IP from ipblock)
group by IP
having count(*) > 5)
;

-- Remove Old IP blocked
Delete from ipblock where DateAdded < Date_Format(Date_Add(now(), INTERVAL - 1 day), '%Y-%m-%d %T');

END//
DELIMITER ;

-- Dumping structure for function registerdb.CheckRegCodeAndBranch
DELIMITER //
CREATE FUNCTION `CheckRegCodeAndBranch`(`i_RegistrationCode` VARCHAR(50),
	`i_FirebaseBranchName` VARCHAR(515)
) RETURNS int(11)
    DETERMINISTIC
    COMMENT 'Check if the Registration Code or Firebase Branch exist'
BEGIN
/*
	Purpose: This fucntion will check if the registration code or
		firebase branch name exist only if the status is NEW. If none 
		exist, then return valid otherwise then reject it.
		
		This function is used in Opal Admin only when generating a registration code
		
		Any other status is no longer a valid records for registation
*/

	declare wsRegistrationCode varchar(50);
	declare wsFirebaseBranchName varchar(515);
	
	declare wsCount int;
	declare wsReturn int;
	
	set wsFirebaseBranchName = i_FirebaseBranchName;
	set wsRegistrationCode = i_RegistrationCode;

	-- Check if the Firebase Branch Name or Registration Code already exist with a status of NEW
	Set wsCount = (select count(*) from registrationcode where `Status` = 'New' and ((`RegistrationCode` = trim(wsRegistrationCode)) or (FirebaseBranch = trim(wsFirebaseBranchName))));
	
	-- Either a duplicate Registration Code or Firebase Branch Name 
	-- so reject the Registration Code or Firebase Branch Name
	if (wsCount > 0) then
	
		set wsReturn = -1;
		
	else
		 
		-- No duplicate Registration Code or Firebase Branch Name	
		set wsReturn = 1;
	
	end if;
	
	
	return wsReturn;
	
END//
DELIMITER ;

-- Dumping structure for function registerdb.insertIPLog
DELIMITER //
CREATE FUNCTION `insertIPLog`(`i_IP` VARCHAR(50)
) RETURNS varchar(50) CHARSET utf8 COLLATE utf8_bin
    DETERMINISTIC
    COMMENT 'Capture the user IP'
BEGIN

/*
	PURPOSE: Capture the user IP each time they attempt to register
		This log will be used to block abusive 
*/

	Insert into iplog (DateAdded, IP)
	values (now(), i_IP);

	-- Just return a SUCCESS as default
	return "SUCCESS";

END//
DELIMITER ;

-- Dumping structure for function registerdb.InsertRegistrationCode
DELIMITER //
CREATE FUNCTION `InsertRegistrationCode`(`i_PatientSerNum` BIGINT,
	`i_FirebaseBranchName` VARCHAR(515),
	`i_RegistrationCode` VARCHAR(25)
) RETURNS int(11)
    DETERMINISTIC
    COMMENT 'This will insert PatientSerNum, FirebaseBranchName, RegistrationCode'
BEGIN

	declare wsPatientSerNum bigint;
	declare wsFirebaseBranchName varchar(515);
	declare wsRegistrationCode varchar(25);
	
	declare wsCount int;
	declare wsReturn int;
	
	set wsPatientSerNum = i_PatientSerNum;
	set wsFirebaseBranchName = i_FirebaseBranchName;
	set wsRegistrationCode = i_RegistrationCode;
	
	set wsCount = -1;
	SET wsReturn = -1;
	set wsCount = (select count(*) from OpalDB.Patient p where p.PatientSerNum = wsPatientSerNum);
	
	if (wsCount > 0) then
			insert into registrationcode(PatientSerNum, `RegistrationCode`, FirebaseBranch)
			values (wsPatientSerNum, wsRegistrationCode, wsFirebaseBranchName);
		
			set wsReturn = (SELECT COUNT(*) FROM registrationcode where `RegistrationCode` = wsRegistrationCode and FirebaseBranch = wsFirebaseBranchName);
	else
		set wsReturn = -1;
	end if;
	
	return wsReturn;
END//
DELIMITER ;

-- Dumping structure for table registerdb.ipblock
CREATE TABLE IF NOT EXISTS `ipblock` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IP` varchar(50) COLLATE utf8_bin NOT NULL,
  `DateAdded` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `IP` (`IP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='This is a list of IPs to be block for X amount of time';

-- Data exporting was unselected.

-- Dumping structure for table registerdb.ipexclude
CREATE TABLE IF NOT EXISTS `ipexclude` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `IP` varchar(50) COLLATE utf8_bin NOT NULL,
  `DateAdded` timestamp NOT NULL DEFAULT current_timestamp(),
  `Active` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT 'Yes' COMMENT 'Yes = Record is active, No = Record is not active',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IP` (`IP`),
  KEY `Active` (`Active`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='List of IP to exclude from the IP Blocking';

-- Data exporting was unselected.

-- Dumping structure for table registerdb.iplog
CREATE TABLE IF NOT EXISTS `iplog` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DateAdded` timestamp NOT NULL DEFAULT current_timestamp(),
  `IP` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `DateAdded` (`DateAdded`),
  KEY `IP` (`IP`)
) ENGINE=InnoDB AUTO_INCREMENT=846 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='This table is to log each connection from the website opalmedapps.com';

-- Data exporting was unselected.

-- Dumping structure for table registerdb.registrationcode
CREATE TABLE IF NOT EXISTS `registrationcode` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` bigint(20) NOT NULL,
  `RegistrationCode` varchar(25) COLLATE utf8_bin NOT NULL,
  `FirebaseBranch` varchar(515) COLLATE utf8_bin NOT NULL,
  `DateAdded` timestamp NOT NULL DEFAULT current_timestamp(),
  `NumberOfAttempt` smallint(6) NOT NULL DEFAULT 0,
  `Status` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT 'New' COMMENT 'New = Register, Lock = Expired or exceeded attempt, Completed = Finish registration, Deleted = registration code have been replace with new registration code',
  `DeleteBranch` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `RegistrationCode` (`RegistrationCode`),
  UNIQUE KEY `FirebaseBranch` (`FirebaseBranch`(255)),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `Status` (`Status`)
) ENGINE=InnoDB AUTO_INCREMENT=598 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Data exporting was unselected.

-- Dumping structure for procedure registerdb.reg_getFirebaseBranchName
DELIMITER //
CREATE PROCEDURE `reg_getFirebaseBranchName`()
    COMMENT 'Update the firebase branch flag as 1 and fetch the firebase branch name only if the status is expired and delete branch flag is 1.'
BEGIN

Declare wsValid int;

	Update registrationcode Set DeleteBranch = 1 Where `Status` = 'Expired' AND DeleteBranch = 0;

	set wsValid = (SELECT count(*) from registrationcode where DeleteBranch = 1);

	if (wsValid > 0) then
		Select FirebaseBranch from registrationcode where DeleteBranch = 1;
	else 
		Select 0 AS FirebaseBranch;
end if;
END//
DELIMITER ;

-- Dumping structure for function registerdb.reg_updateFirebaseBranchFlag
DELIMITER //
CREATE FUNCTION `reg_updateFirebaseBranchFlag`() RETURNS int(11)
    DETERMINISTIC
    COMMENT 'After deletion of firebase branch names set status of the Delete Branch field as 2'
BEGIN
	Declare wsValid int;
	Declare wsReturn int;

	set wsValid = (SELECT count(*) from registrationcode where DeleteBranch = 1);
		if (wsValid > 0) then
			Update registrationcode set DeleteBranch = 2 where DeleteBranch = 1;
			set wsReturn = 1;
		else
			set wsReturn = 0;
		end if;
	
	return wsReturn;
END//
DELIMITER ;

-- Dumping structure for event registerdb.RemoveOldRegistrationCode
DELIMITER //
CREATE EVENT `RemoveOldRegistrationCode` ON SCHEDULE EVERY 1 DAY STARTS '2019-08-01 00:01:00' ON COMPLETION PRESERVE ENABLE COMMENT 'Remove any old registration code that is passed certain amount o' DO BEGIN

/*
Possible type of status for the table registrationcode

	New - New Registration Code and is valid
	Completed - Registration have been completed
	Expired - Registration Code is pass expired date
	Blocked - Attempted too many times so now the code is no longer valid
*/

Update registrationcode
Set Status = 'Expired'
where Status = 'New' and DateAdded <=  Date_Format(Date_Add(now(), INTERVAL - 4 day), '%Y-%m-%d');


END//
DELIMITER ;

-- Dumping structure for table registerdb.termsandagreementsign
CREATE TABLE IF NOT EXISTS `termsandagreementsign` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `PatientSerNum` bigint(20) NOT NULL,
  `TermsAndAgreementID` bigint(20) NOT NULL,
  `TermsAndAgreementSign` tinyint(4) NOT NULL,
  `TermsAndAgreementSignDateTime` datetime NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table to store wheter patient checked(1)/unchecked(0) with patientsernum and date and time of agreement sign.';

-- Data exporting was unselected.

-- Dumping structure for procedure registerdb.updateRegistrationCodeAttempt
DELIMITER //
CREATE PROCEDURE `updateRegistrationCodeAttempt`(
	IN `i_FirebaseBranch` VARCHAR(50)
)
BEGIN
/*
	Purpose : This is to update the number of attempt per firebase branch
*/

	declare wsFirebaseBranch nvarchar(200);
	declare wsCount int;
	
	set wsFirebaseBranch = i_FirebaseBranch;
	set wsCount = 0;

	Update registrationcode
	set NumberOfAttempt = NumberOfAttempt + 1
	Where FirebaseBranch = wsFirebaseBranch
		and `Status` = 'New';

END//
DELIMITER ;

-- Dumping structure for function registerdb.validateInputs
DELIMITER //
CREATE FUNCTION `validateInputs`(`i_FirebaseBranchName` VARCHAR(255),
	`i_RegistationCode` VARCHAR(25),
	`i_RAMQ` VARCHAR(16)

) RETURNS varchar(100) CHARSET utf8 COLLATE utf8_bin
    DETERMINISTIC
    COMMENT 'This will validate user FirebaseBranch, Registration Code, RAMQ, DOB'
BEGIN

	Declare wsFirebaseBranchName varchar(255);
	declare wsRegistrationCode varchar(25);
	declare wsRAMQ varchar(16);
	
	declare wsCount int;
	declare wsPatientSerNum bigint;
	declare wsReturn varchar(50);
	declare wsName varchar(500);
	
	Set wsFirebaseBranchName = i_FirebaseBranchName;
	set wsRegistrationCode = i_RegistationCode;
	set wsRAMQ = i_RAMQ;
	
	
	set wsCount = 0;
	set wsCount = (select count(*) total from registrationcode RC where RC.FirebaseBranch = wsFirebaseBranchName and RC.RegistrationCode = i_RegistationCode and RC.`Status` = 'New' );

	if (wsCount > 0) then
		set wsPatientSerNum = (select PatientSerNum from registrationcode RC where RC.FirebaseBranch = wsFirebaseBranchName and RC.RegistrationCode = i_RegistationCode);
		
		set wsCount = 0;
		
--		set wsCount = (
			select count(*) total, Concat('SUCCESS:', ltrim(FirstName), ' ', ltrim(LastName)) as Name
			into wsCount, wsName
			from OpalDB.Patient p where p.PatientSerNum = wsPatientSerNum
				and p.SSN = wsRAMQ
--			)
			;
		
		if (wsCount > 0) then
			set wsReturn = wsName;
		else
			set wsReturn = 'Unknown Registration Code';
		end if;
		
	else
	
		set wsReturn = 'Unknown Registration Code';
	end if;
	
	
	return wsReturn;

END//
DELIMITER ;

-- Dumping structure for function registerdb.ValidateIP
DELIMITER //
CREATE FUNCTION `ValidateIP`(`i_IP` VARCHAR(50)

) RETURNS varchar(50) CHARSET utf8 COLLATE utf8_bin
    DETERMINISTIC
BEGIN

	declare wsCount int;
	declare wsReturn varchar(50);
	declare wsIP varchar(50);
	
	set wsIP = i_IP;
	set wsCount = 0;
	set wsCount = (select count(*) from ipblock where IP = wsIP);

	if (wsCount > 0) then
		
		-- set wsReturn = 'REJECT';
		set wsReturn = 'SUCCESS';

	else
	
		set wsReturn = 'SUCCESS';
	
	end if;
	
	return wsReturn;

END//
DELIMITER ;

-- Dumping structure for function registerdb.validatePatient
DELIMITER //
CREATE FUNCTION `validatePatient`(`i_PatientSerNum` INT
) RETURNS varchar(255) CHARSET utf8
    DETERMINISTIC
    COMMENT 'This is to check if patient already registered or not'
BEGIN

	declare wsPatientSerNum int;
	declare wsCount int;	
	declare wsReturn varchar(255);
	declare wsResponse varchar(255);
	
	set wsPatientSerNum = i_PatientSerNum;
	set wsCount = -1;
	
	set wsCount = (select count(*) from registrationcode where PatientSerNum = i_PatientSerNum and `Status` = 'Completed');
	
	if (wsCount > 0) then
		
		set wsReturn = -1;
			
	else
		set wsCount = -1;
		set wsCount = (select count(*) from registrationcode where PatientSerNum = wsPatientSerNum and `Status` = 'New');
		
		if (wsCount > 0) then
		    Select Concat('SUCCESS:', ltrim(FirebaseBranch)) as BranchName into wsResponse from registrationcode where PatientSerNum = i_PatientSerNum and `Status` = 'New';
			 
		    Update registrationcode set `Status` = 'Deleted', DeleteBranch = 2 where PatientSerNum = i_PatientSerNum and `Status` = 'New';
		    
			set wsReturn = wsResponse;
		else
			set wsReturn = 1;
		 end if;
	
	end if;
			
	Return wsReturn;

END//
DELIMITER ;

-- Dumping structure for trigger registerdb.registrationcode_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `registrationcode_before_update` BEFORE UPDATE ON `registrationcode` FOR EACH ROW BEGIN

	if NEW.NumberOfAttempt > 5 then
	
		Set NEW.`Status` = 'Blocked';
	
	end if;


END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
