-- SPDX-FileCopyrightText: Copyright (C) 2024 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- OPAL MEDICAL INSTITUTION

INSERT INTO `Hospital_Identifier_Type` (`Hospital_Identifier_Type_Id`, `Code`, `ADT_Web_Service_Code`, `Description_EN`, `Description_FR`) VALUES
(1, 'ODH', 'MR_PCS', 'Opal Demo Hospital (ODH)', "Hôpital démo d\'Opal (HDO)");

INSERT INTO `Patient` (`PatientSerNum`, `PatientAriaSer`, `PatientId`, `PatientId2`, `FirstName`, `LastName`, `Alias`, `ProfileImage`, `Sex`, `DateOfBirth`, `Age`, `TelNum`, `EnableSMS`, `Email`, `Language`, `SSN`, `AccessLevel`, `RegistrationDate`, `ConsentFormExpirationDate`, `BlockedStatus`, `StatusReasonTxt`, `DeathDate`, `SessionId`, `LastUpdated`, `TestUser`, `TermsAndAgreementSign`, `TermsAndAgreementSignDateTime`) VALUES
(59, 0, '', '', 'Rory', 'O\'Brien', '', NULL, 'Other', '1972-06-11 00:00:00', 53, NULL, 0, 'rory@opalmedapps.ca', 'EN', 'OBRR72061199', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(92, 0, '', '', 'Laurie', 'Opal', '', NULL, 'Female', '1958-12-13 00:00:00', 66, NULL, 0, 'laurie@opalmedapps.ca', 'EN', 'OPAL58621325', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(93, 0, '', '', 'John', 'Smith', '', NULL, 'Male', '1985-01-01 00:00:00', 40, NULL, 0, 'john@opalmedapps.ca', 'EN', 'ABCD99988877', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(94, 0, '', '', 'Richard', 'Smith', '', NULL, 'Male', '1946-05-05 00:00:00', 79, NULL, 0, 'richard@opalmedapps.ca', 'EN', 'SMIR05054616', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(96, 0, '', '', 'Cara', 'O\'Brien', '', NULL, 'Female', '1974-11-25 00:00:00', 50, NULL, 0, 'cara@opalmedapps.ca', 'EN', 'OBRC11257499', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(99, 0, '', '', 'Valerie', 'Solanas', '', NULL, 'Male', '1979-06-21 00:00:00', 45, NULL, 0, 'valerie@opalmedapps.ca', 'EN', 'SOLV06217999', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(100, 0, '', '', 'Pete', 'Boyd', '', NULL, 'Male', '1971-06-11 00:00:00', 54, NULL, 0, 'pete@opalmedapps.ca', 'EN', 'BOYP06117199', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(101, 0, '', '', 'Martin', 'Curley', '', NULL, 'Male', '1965-04-23 00:00:00', 60, NULL, 0, 'martin@opalmedapps.ca', 'EN', 'CURM04236599', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(102, 0, '', '', 'Kathy', 'Brown', '', NULL, 'Female', '1974-11-25 00:00:00', 50, NULL, 0, 'kathy@opalmedapps.ca', 'EN', 'BROK11257499', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-19 21:54:53', 0, NULL, NULL),
(103, 0, '', '', 'Mike', 'Brown', '', NULL, 'Male', '1972-06-11 00:00:00', 53, NULL, 0, 'mike@opalmedapps.ca', 'EN', 'BROM72061199', '3', '2025-06-19 21:54:53', NULL, 0, '', NULL, '', '2025-06-27 09:24:42', 0, NULL, NULL);

INSERT INTO `Users` (`UserSerNum`, `UserType`, `UserTypeSerNum`, `Username`, `Password`, `SessionId`, `LastUpdated`) VALUES
(1, 'Patient', 92, 'a51fba18-3810-4808-9238-4d0e487785c8', '', '', '2025-06-19 21:54:53'),
(2, 'Patient', 59, 'mouj1pqpXrYCl994oSm5wtJT3In2', '', '', '2025-06-19 21:54:53'),
(3, 'Patient', 96, 'dR2Cb1Yf0vQb4ywvMoAXw1SxbY93', '', '', '2025-06-19 21:54:53'),
(4, 'Patient', 93, 'hIMnEXkedPMxYnXeqNXzphklu4V2', '', '', '2025-06-19 21:54:53'),
(5, 'Patient', 94, '2WhxeTpYF8aHlfSQX8oGeq4LFhw2', '', '', '2025-06-19 21:54:53'),
(6, 'Patient', 103, 'hSJdAae7xWNwnemd2YypQSVfoOb2', '', '', '2025-06-19 21:54:53'),
(7, 'Patient', 102, 'OPWj4Cj5iRfgva4b3HGtVGjvuk13', '', '', '2025-06-19 21:54:53'),
(8, 'Patient', 99, 'dcBSK5qdoiOM2L9cEdShkqOadkG3', '', '', '2025-06-19 21:54:53'),
(9, 'Patient', 100, '9kmS7qYQX8arnFFs4ZYJk1tqLFw1', '', '', '2025-06-19 21:54:53'),
(10, 'Patient', 101, '2grqcCoyPlVucfAPD4NM1SuCk3i1', '', '', '2025-06-19 21:54:53');

INSERT INTO `PatientControl` (`PatientSerNum`, `PatientUpdate`, `LastTransferred`, `LastUpdated`, `TransferFlag`) VALUES
(59, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(92, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(93, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(94, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(96, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(99, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(100, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(101, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(102, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0),
(103, 1, '2025-07-07 11:58:00', '2025-07-07 11:58:00', 0);

INSERT INTO `Patient_Hospital_Identifier` (`Patient_Hospital_Identifier_Id`, `PatientSerNum`, `Hospital_Identifier_Type_Code`, `MRN`, `Is_Active`) VALUES
(1, 92, 'ODH', '1092300', 1),
(2, 59, 'ODH', '9999989', 1),
(3, 96, 'ODH', '8888885', 1),
(4, 93, 'ODH', '9999994', 1),
(5, 94, 'ODH', '8888882', 1),
(6, 103, 'ODH', '8888881', 1),
(7, 102, 'ODH', '8888880', 1),
(8, 99, 'ODH', '5555553', 1),
(9, 100, 'ODH', '5555554', 1),
(10, 101, 'ODH', '5555559', 1);
