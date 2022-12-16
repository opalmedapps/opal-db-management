/*
	Moved this from step 14 to step 18 because of the lab changes. It was truncating the Patient_Hospital_Identifier
*/

INSERT INTO Patient_Hospital_Identifier (PatientSerNum, Hospital_Identifier_Type_Code, MRN, Is_Active)
SELECT P.PatientSerNum, 'RVH', P.PatientId, 1
FROM PatientControl PC, Patient P
WHERE P.PatientSerNum = PC.PatientSerNum
	AND PC.PatientUpdate = 1
	AND P.PatientSerNum not in (select PatientSerNum from Patient_Hospital_Identifier)
	AND P.PatientSerNum = 51;
