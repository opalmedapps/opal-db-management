-- SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

SET foreign_key_checks = 0;
-- Truncate
TRUNCATE TABLE `BuildType`;
TRUNCATE TABLE `DiagnosisChapter`;
TRUNCATE TABLE `ExamRoom`;
TRUNCATE TABLE `Profile`;
TRUNCATE TABLE `Patient`;
TRUNCATE TABLE `SmsAppointment`;
TRUNCATE TABLE `ClinicHub`;
TRUNCATE TABLE `Insurance`;
TRUNCATE TABLE `PatientMeasurement`;
TRUNCATE TABLE `TEMP_PatientQuestionnaireReview`;
TRUNCATE TABLE `PatientDiagnosis`;
TRUNCATE TABLE `IntermediateVenue`;
TRUNCATE TABLE `ProfileColumns`;
TRUNCATE TABLE `SpecialityGroup`;
TRUNCATE TABLE `DiagnosisCode`;
TRUNCATE TABLE `PatientHospitalIdentifier`;
TRUNCATE TABLE `DiagnosisSubcode`;
TRUNCATE TABLE `ClinicResources`;
TRUNCATE TABLE `Cron`;
TRUNCATE TABLE `ProfileColumnDefinition`;
TRUNCATE TABLE `PatientLocationMH`;
TRUNCATE TABLE `SmsMessage`;
TRUNCATE TABLE `MediVisitAppointmentList`;
TRUNCATE TABLE `ProfileOptions`;
TRUNCATE TABLE `PatientLocation`;
TRUNCATE TABLE `AppointmentCode`;
TRUNCATE TABLE `PatientInsuranceIdentifier`;
TRUNCATE TABLE `Hospital`;

SET foreign_key_checks = 1;
