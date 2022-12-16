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
