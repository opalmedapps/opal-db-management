-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Dumping data for table OrmsDatabase.ProfileColumnDefinition: ~18 rows (approximately)
REPLACE INTO `ProfileColumnDefinition` (`ProfileColumnDefinitionSer`, `ColumnName`, `DisplayName`, `Glyphicon`, `Description`, `LastUpdated`) VALUES
(1, 'PatientName', 'Patient', 'glyphicon-user', 'The patient name', '2018-08-15 20:18:50'),
(2, 'ScheduledStartTime', 'Scheduled', 'glyphicon-time', 'The scheduled start time of the appointment', '2018-08-15 20:18:50'),
(3, 'CurrentLocation', 'Current Location', 'glyphicon-globe', 'The patient\'s current location (where they are checked in in the PatientLocation table)', '2018-08-15 21:03:37'),
(4, 'ArrivalTime', 'Arrival At Location', 'glyphicon-hourglass', 'The time the patient checked in his current location', '2018-08-15 20:18:50'),
(5, 'AppointmentCode', 'Appointment', 'glyphicon-text-background', 'The appointment code of the appointment', '2018-08-15 20:18:50'),
(6, 'ClinicName', 'Clinic', 'glyphicon-book', 'The name of the clinic assigned to the appointment', '2018-08-15 20:50:47'),
(8, 'WaitingTime', 'Wait (min)', 'glyphicon-eye-open', 'The time the patient has been waiting for his appointment', '2018-08-15 20:54:49'),
(9, 'RemainingTime', 'Remaining (min)', 'glyphicon-resize-small', 'The time remaining until the scheduled start for the patient\'s appointment', '2018-08-15 21:06:07'),
(12, 'CallPatient', 'Call Patient', 'glyphicon-bullhorn', 'Enables a patient to be called to a specific venue room. Used by PABs to call patients.', '2018-08-15 20:18:50'),
(13, 'UndoCall', 'Undo Call', 'glyphicon-share-alt', 'Enables a patient\'s current location to be set in a waiting room', '2018-08-15 21:10:33'),
(17, 'AssignRoom', 'Assign Exam Room', 'glyphicon-road', 'Enables a patient to be assigned to an exam room. Used by PABs to check patients in exam rooms for MDs.', '2018-08-15 20:51:34'),
(18, 'CompleteAppointment', 'Complete Appointment', 'glyphicon-check', 'Completes a patient\'s appointment and puts them in the VENUE COMPLETE room', '2018-08-15 20:18:50'),
(22, 'Questionnaires', 'Questionnaires', 'glyphicon-pencil', 'Enables the questionnaires a patient has answered to be viewed.', '2020-05-15 19:58:27'),
(23, 'CellPhoneNumber', 'Cell Phone Number', 'glyphicon-phone', 'Displays the patient\'s mobile number, if they have one', '2020-05-15 19:58:47'),
(24, 'WeighPatient', 'Weigh Patient', 'glyphicon-hand-down', 'Enables a patient\'s height, weight and BSA to be measured', '2020-08-18 05:27:31'),
(25, 'SendForWeight', 'Send For Weight', 'glyphicon-hand-down', 'Similar to the WeightPatient column, except is allows any patient to be sent for weight', '2020-08-18 05:27:32'),
(26, 'Diagnosis', 'Diagnosis', 'glyphicon-tint', 'Patient Diagnosis', '2022-01-22 00:42:03'),
(27, 'Labs', 'Labs', 'glyphicon-stats', 'Patient lab result data', '2023-11-14 17:30:00'),
(28, 'WearablesData', 'Wearables Data', 'glyphicon-stats', 'Patient wearables data', '2024-05-04 08:30:00');
