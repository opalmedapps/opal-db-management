-- SPDX-FileCopyrightText: Copyright (C) 2025 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
--
-- SPDX-License-Identifier: AGPL-3.0-or-later

-- Update all read statuses to mimic a live environment and assume that everyone read their data
-- This should be done at the end of inserting all data

-- Rorys data read by rory
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE PatientSerNum = 59
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 59
;

-- Caras data read by rory and cara
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE PatientSerNum = 96
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE PatientSerNum = 96
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE PatientSerNum = 96
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE PatientSerNum = 96
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE PatientSerNum = 96
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE PatientSerNum = 96
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE PatientSerNum = 96
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["mouj1pqpXrYCl994oSm5wtJT3In2", "dR2Cb1Yf0vQb4ywvMoAXw1SxbY93"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 96
;

-- Johns data read by John
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE PatientSerNum = 93
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE PatientSerNum = 93
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE PatientSerNum = 93
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE PatientSerNum = 93
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE PatientSerNum = 93
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE PatientSerNum = 93
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE PatientSerNum = 93
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 93
;

-- Richards data read by John and Richard
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE PatientSerNum = 94
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE PatientSerNum = 94
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE PatientSerNum = 94
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE PatientSerNum = 94
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE PatientSerNum = 94
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE PatientSerNum = 94
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE PatientSerNum = 94
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["hIMnEXkedPMxYnXeqNXzphklu4V2", "2WhxeTpYF8aHlfSQX8oGeq4LFhw2"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 94
;

-- Valeries data read by Valerie
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE PatientSerNum = 99
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE PatientSerNum = 99
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE PatientSerNum = 99
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE PatientSerNum = 99
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE PatientSerNum = 99
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE PatientSerNum = 99
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE PatientSerNum = 99
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["dcBSK5qdoiOM2L9cEdShkqOadkG3"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 99
;

-- Petes data read by Pete
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE PatientSerNum = 100
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE PatientSerNum = 100
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE PatientSerNum = 100
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE PatientSerNum = 100
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE PatientSerNum = 100
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE PatientSerNum = 100
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE PatientSerNum = 100
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["9kmS7qYQX8arnFFs4ZYJk1tqLFw1"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 100
;

-- Martins data read by Martin
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE PatientSerNum = 101
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE PatientSerNum = 101
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE PatientSerNum = 101
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE PatientSerNum = 101
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE PatientSerNum = 101
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE PatientSerNum = 101
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE PatientSerNum = 101
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["2grqcCoyPlVucfAPD4NM1SuCk3i1"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 101
;

-- Mikes data read by Mike
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE PatientSerNum = 103
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE PatientSerNum = 103
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE PatientSerNum = 103
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE PatientSerNum = 103
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE PatientSerNum = 103
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE PatientSerNum = 103
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE PatientSerNum = 103
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 103
;

-- Kathys data read by Mike and Kathy
UPDATE Announcement
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE PatientSerNum = 102
;
UPDATE Appointment
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE PatientSerNum = 102
  AND ScheduledStartTime < NOW()
;
UPDATE Document
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE PatientSerNum = 102
;
UPDATE EducationalMaterial
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE PatientSerNum = 102
;
UPDATE PatientTestResult
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE PatientSerNum = 102
;
UPDATE TxTeamMessage
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE PatientSerNum = 102
;
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE PatientSerNum = 102
AND NotificationControlSerNum IN (4, 5, 7, 15)
;
UPDATE Notification
INNER JOIN Questionnaire ON Questionnaire.QuestionnaireSerNum = Notification.RefTableRowSerNum
SET ReadStatus = 1,
    ReadBy = '["hSJdAae7xWNwnemd2YypQSVfoOb2", "OPWj4Cj5iRfgva4b3HGtVGjvuk13"]'
WHERE Notification.NotificationControlSerNum = 13
  AND Questionnaire.CompletionDate IS NOT NULL
  AND Notification.PatientSerNum = 102
;

-- lauries data are all read
UPDATE Notification
SET ReadStatus = 1,
    ReadBy = '["a51fba18-3810-4808-9238-4d0e487785c8"]'
WHERE PatientSerNum = 92
;
