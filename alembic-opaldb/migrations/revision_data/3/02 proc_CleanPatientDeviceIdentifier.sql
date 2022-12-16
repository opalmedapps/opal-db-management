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