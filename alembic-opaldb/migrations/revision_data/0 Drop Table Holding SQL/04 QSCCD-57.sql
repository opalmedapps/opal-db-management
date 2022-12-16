-- Remove Doctor tables and related tables
DELETE FROM modulePublicationSetting WHERE publicationSettingId = '7';
DELETE FROM publicationSetting WHERE internalName = 'Doctor';
DROP TABLE IF EXISTS PatientDoctor;
DROP TABLE IF EXISTS PatientDoctorHistory;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS DoctorMH;