-- Fix the Diagnosis Code in the Diagnosis table
UPDATE `Diagnosis` SET `DiagnosisCode` = 'C50.1' WHERE `DiagnosisSerNum` = 1;
UPDATE `Diagnosis` SET `DiagnosisCode` = 'C07' WHERE `DiagnosisSerNum` = 4;
UPDATE `Diagnosis` SET `DiagnosisCode` = 'C16.9' WHERE `DiagnosisSerNum` = 5;
