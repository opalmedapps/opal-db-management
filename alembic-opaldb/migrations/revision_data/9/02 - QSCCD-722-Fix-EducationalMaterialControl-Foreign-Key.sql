-- Remove the foreign key between the EducationalMaterialControl and PhaseInTreatment.
-- Allow NULL in the PhaseInTreatmentSerNum in the table EducationalMaterialControl

ALTER TABLE `EducationalMaterialControl`
	DROP FOREIGN KEY IF EXISTS `EducationalMaterialControl_ibfk_1`,
	CHANGE COLUMN `PhaseInTreatmentSerNum` `PhaseInTreatmentSerNum` INT NULL AFTER `ShareURL_FR`;
