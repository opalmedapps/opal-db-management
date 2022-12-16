-- Remove the foreign key to allow TOC to be updated
ALTER TABLE `cronControlEducationalMaterial`
	DROP FOREIGN KEY IF EXISTS `fk_cronContEM_cronContEMCSerNum_EMC_EMCSerNum`;

-- Remove the foreign key to allow TOC to be updated
ALTER TABLE `cronControlPatient_EducationalMaterial`
	DROP FOREIGN KEY IF EXISTS `fk_cronContPatient_Edu_cronContPSerNum_Patient_PatientSerNum`;