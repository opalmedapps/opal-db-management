ALTER TABLE `PatientActivityLog`
    ADD COLUMN `Parameters` VARCHAR(2048) NULL DEFAULT '' COMMENT 'The parameters passed to the request.' COLLATE 'latin1_swedish_ci' AFTER `Request`,
    ADD COLUMN `TargetPatientId` INT NULL DEFAULT NULL COMMENT 'PatientSerNum of the patient targeted by the request (if the request targets patient data).' AFTER `Parameters`;
