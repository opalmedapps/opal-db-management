-- Remove tables that are not in use
DROP TABLE IF EXISTS Admin, AppointmentDelay, AppointmentTemp, CronDelayLog, DiagnosisCodeMH_legacy, list_patient,
	masterSourceTestResult, MessagesMH, PatientDoctorHistory, PatientHospitalIdentifier, PatientVerifyOpalVsOacis,
	QuestionnaireControlNewMH, TagPatientLog, termsandagreement, TestResultNotificationProcessingLog, TestResultNotificationQueue,
	UsersAppointmentsTimestamps
	;
