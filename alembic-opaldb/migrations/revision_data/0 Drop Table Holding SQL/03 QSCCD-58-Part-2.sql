-- Remove Phase In Treatment Table
ALTER TABLE EducationalMaterialControl DROP COLUMN PhaseInTreatmentSerNum;
-- Drop PhaseInTreatment table
DROP TABLE IF EXISTS PhaseInTreatment;
