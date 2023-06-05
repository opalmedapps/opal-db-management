INSERT INTO `AppointmentCode` (`AppointmentCodeId`, `AppointmentCode`, `SpecialityGroupId`, `DisplayName`, `SourceSystem`, `Active`, `LastModified`) VALUES
(1,	'ATST',	1,	NULL,	'BBB',	1,	'2022-05-11 01:19:23');

INSERT INTO `ClinicHub` (`ClinicHubId`, `SpecialityGroupId`, `ClinicHubName`, `LastUpdated`) VALUES
(1,	1,	'Test Hub',	'2022-05-11 01:18:52');

INSERT INTO `ClinicResources` (`ClinicResourcesSerNum`, `ResourceCode`, `ResourceName`, `SpecialityGroupId`, `SourceSystem`, `LastModified`, `Active`) VALUES
(1,	'RTST',	'Test Code',	1,	'BBB',	'2022-05-11 05:21:08',	1);

INSERT INTO `ExamRoom` (`AriaVenueId`, `ClinicHubId`, `ScreenDisplayName`, `VenueEN`, `VenueFR`, `ExamRoomSerNum`, `IntermediateVenueSerNum`, `PositionOrder`) VALUES
('Exam Room',	1,	'Exam Room',	'Exam Room',	'Exam Room',	1,	NULL,	NULL);

INSERT INTO `Hospital` (`HospitalId`, `HospitalCode`, `HospitalName`, `Format`) VALUES
(1,	'RVH',	'Hospital',	'^[0-9]{7}$');

INSERT INTO `Insurance` (`InsuranceId`, `InsuranceCode`, `InsuranceName`, `Format`) VALUES
(1,	'RAMA',	'Régie de l\'assurance maladie de l\'Alberta',	'^[0-9]{9}$'),
(2,	'RAMC',	'Régie de l\'assurance maladie de la Colombie-Britannique',	'^[0-9]{10}$'),
(3,	'RAMM',	'Régie de l\'assurance maladie du Manitoba',	'^[0-9]{9}$'),
(4,	'RAMB',	'Régie de l\'assurance maladie du Nouveau-Brunswick',	'^[0-9]{9}$'),
(5,	'RAMN',	'Régie de l\'assurance maladie de Terre-Neuve',	'^[0-9]{12}$'),
(6,	'RAMT',	'Régie de l\'assurance maladie des Territoires NO',	'^[0-9]{7}$'),
(7,	'RAME',	'Régie de l\'assurance maladie de la Nouvelle-Ecosse',	'^[0-9]{10}$'),
(8,	'RAMU',	'Régie de l\'assurance maladie du Nunavut',	'^[0-9]{9}$'),
(9,	'RAMO',	'Régie de l\'assurance maladie de l\'Ontario',	'^([0-9]{10}[A-Z]{2}|[0-9]{10})$'),
(10, 'RAMI', 'Régie de l\'assurance maladie de l\'IPE',	'^[0-9]{8}$'),
(11, 'RAMQ', 'Régie de l\'assurance maladie du Québec',	'^[a-zA-Z]{4}[0-9]{8}$'),
(12, 'RAMS', 'Régie de l\'assurance maladie de la Saskatchewan',	'^[0-9]{9}$'),
(13, 'RAMY', 'Régie de l\'assurance maladie du Yukon',	'^[0-9]{9}$');

INSERT INTO `IntermediateVenue` (`IntermediateVenueSerNum`, `AriaVenueId`, `ClinicHubId`, `ScreenDisplayName`, `VenueEN`, `VenueFR`) VALUES
(1,	'Venue Room',	1,	'Venue Room',	'Venue Room',	'Venue Room');

INSERT INTO `Profile` (`ProfileSer`, `ProfileId`, `Category`, `SpecialityGroupId`, `LastUpdated`) VALUES
(1,	'Default Profile',	'Physician',	1,	'2022-05-11 15:07:17');

INSERT INTO `ProfileColumnDefinition` (`ProfileColumnDefinitionSer`, `ColumnName`, `DisplayName`, `Glyphicon`, `Description`, `LastUpdated`) VALUES
(1,	'PatientName',	'Patient',	'glyphicon-user',	'The patient name',	'2018-08-15 20:18:50'),
(2,	'ScheduledStartTime',	'Scheduled',	'glyphicon-time',	'The scheduled start time of the appointment',	'2018-08-15 20:18:50'),
(3,	'CurrentLocation',	'Current Location',	'glyphicon-globe',	'The patient\'s current location (where they are checked in in the PatientLocation table)',	'2018-08-15 21:03:37'),
(4,	'ArrivalTime',	'Arrival At Location',	'glyphicon-hourglass',	'The time the patient checked in his current location',	'2018-08-15 20:18:50'),
(5,	'AppointmentCode',	'Appointment',	'glyphicon-text-background',	'The appointment code of the appointment',	'2018-08-15 20:18:50'),
(6,	'ClinicName',	'Clinic',	'glyphicon-book',	'The name of the clinic assigned to the appointment',	'2018-08-15 20:50:47'),
(7,	'WaitingTime',	'Wait (min)',	'glyphicon-eye-open',	'The time the patient has been waiting for his appointment',	'2022-05-11 05:49:10'),
(8,	'RemainingTime',	'Remaining (min)',	'glyphicon-resize-small',	'The time remaining until the scheduled start for the patient\'s appointment',	'2022-05-11 05:49:11'),
(9,	'CallPatient',	'Call Patient',	'glyphicon-bullhorn',	'Enables a patient to be called to a specific venue room. Used by PABs to call patients.',	'2022-05-11 05:49:12'),
(10,	'UndoCall',	'Undo Call',	'glyphicon-share-alt',	'Enables a patient\'s current location to be set in a waiting room',	'2022-05-11 05:49:14'),
(11,	'AssignRoom',	'Assign Exam Room',	'glyphicon-road',	'Enables a patient to be assigned to an exam room. Used by PABs to check patients in exam rooms for MDs.',	'2022-05-11 05:49:16'),
(12,	'CompleteAppointment',	'Complete Appointment',	'glyphicon-check',	'Completes a patient\'s appointment and puts them in the VENUE COMPLETE room',	'2022-05-11 05:49:17'),
(13,	'Questionnaires',	'Questionnaires',	'glyphicon-pencil',	'Enables the questionnaires a patient has answered to be viewed.',	'2022-05-11 05:49:19'),
(14,	'CellPhoneNumber',	'Cell Phone Number',	'glyphicon-phone',	'Displays the patient\'s mobile number, if they have one',	'2022-05-11 05:49:20'),
(15,	'WeighPatient',	'Weigh Patient',	'glyphicon-hand-down',	'Enables a patient\'s height, weight and BSA to be measured',	'2022-05-11 05:49:22'),
(16,	'SendForWeight',	'Send For Weight',	'glyphicon-hand-down',	'Similar to the WeightPatient column, except is allows any patient to be sent for weight',	'2022-05-11 05:49:23'),
(17,	'Diagnosis',	'Diagnosis',	'glyphicon-tint',	'Patient Diagnosis',	'2022-05-11 05:49:25'),
(18,	'WearablesData',	'Wearables Data',	'glyphicon-stats',	'Patient wearables data',	'2023-05-04 12:30:00');

INSERT INTO `ProfileColumns` (`ProfileColumnSer`, `ProfileSer`, `ProfileColumnDefinitionSer`, `Position`, `Active`, `LastUpdated`) VALUES
(1,	1,	5,	11,	1,	'2023-05-04 12:30:00'),
(2,	1,	4,	9,	1,	'2023-05-04 12:30:00'),
(3,	1,	11,	-1,	0,	'2022-05-11 15:07:17'),
(4,	1,	9,	12,	1,	'2023-05-04 12:30:00'),
(5,	1,	14,	2,	1,	'2022-05-11 15:07:17'),
(6,	1,	6,	10,	1,	'2023-05-04 12:30:00'),
(7,	1,	12,	14,	1,	'2023-05-04 12:30:00'),
(8,	1,	3,	8,	1,	'2023-05-04 12:30:00'),
(9,	1,	17,	3,	1,	'2022-05-11 15:07:17'),
(10,	1,	1,	1,	1,	'2022-05-11 15:07:17'),
(11,	1,	13,	4,	1,	'2022-05-11 15:07:17'),
(12,	1,	8,	-1,	0,	'2022-05-11 15:07:17'),
(13,	1,	2,	7,	1,	'2023-05-04 12:30:00'),
(14,	1,	16,	6,	1,	'2023-05-04 12:30:00'),
(15,	1,	10,	13,	1,	'2023-05-04 12:30:00'),
(16,	1,	7,	-1,	0,	'2022-05-11 15:07:17'),
(17,	1,	15,	-1,	0,	'2022-05-11 15:07:17'),
(18,	1,	18,	5,	1,	'2023-05-04 12:30:00');


INSERT INTO `SmsAppointment` (`SmsAppointmentId`, `ClinicResourcesSerNum`, `AppointmentCodeId`, `SpecialityGroupId`, `SourceSystem`, `Type`, `Active`, `LastUpdated`) VALUES
(1,	1,	1,	1,	'BBB',	'GENERAL',	1,	'2022-05-11 11:10:05');

INSERT INTO `SmsMessage` (`SmsMessageId`, `SpecialityGroupId`, `Type`, `Event`, `Language`, `Message`, `LastUpdated`) VALUES
(1,	NULL,	'GENERAL',	'FAILED_CHECK_IN',	'English',	'Failed check in',	'2022-05-11 05:54:08'),
(2,	NULL,	'GENERAL',	'FAILED_CHECK_IN',	'French',	'Erreur d\'enregistrement',	'2022-05-11 05:54:40'),
(3,	NULL,	'GENERAL',	'UNKNOWN_COMMAND',	'English',	'You have not been checked-in. To check-in for an appointment, please reply with the word \"arrive\". No other messages are accepted.',	'2022-05-11 05:55:30'),
(4,	NULL,	'GENERAL',	'UNKNOWN_COMMAND',	'French',	'Vous n\'avez pas été enregistré(e). Pour vous enregister pour votre rendez-vous, svp repondez \"arrive\". Aucun autre message ne sera accepté.',	'2022-05-11 05:55:35'),
(5,	1,	'GENERAL',	'REGISTRATION',	'English',	'Registration for SMS messages is confirmed.',	'2022-05-11 06:02:53'),
(6,	1,	'GENERAL',	'REGISTRATION',	'French',	'L\'inscription pour les notifications par SMS est confirmée.',	'2022-05-11 06:03:10'),
(7,	1,	'GENERAL',	'CHECK_IN',	'English',	'You have checked in for your appointment(s): <app>You do not need to check-in at the kiosk.',	'2022-05-11 06:03:22'),
(8,	1,	'GENERAL',	'CHECK_IN',	'French',	'Vous êtes enregistré pour vos rendez-vous:<app>Vous ne devez pas vous enregistrer à la borne.',	'2022-05-11 06:03:34'),
(9,	1,	'GENERAL',	'REMINDER',	'English',	'Reminder for your appointment(s):\r\n<app>\r\nTo check-in for an appointment, please respond to this message with \"arrive\" when you arrive at the hospital tomorrow.',	'2022-05-11 06:04:33'),
(10,	1,	'GENERAL',	'REMINDER',	'French',	'Rappel pour vos rendez-vous:\r\n<app>\r\nPour vous enregistrer pour un rendez-vous, répondez à ce numéro avec \"arrive\" lorsque vous arrivez à l\'hôpital demain.',	'2022-05-11 06:04:44');

INSERT INTO `SpecialityGroup` (`SpecialityGroupId`, `HospitalId`, `SpecialityGroupCode`, `SpecialityGroupName`, `LastUpdated`) VALUES
(1,	1,	'AAA',	'Test Group',	'2022-05-11 01:18:31');


-- 2023-06-02 15:38:29
