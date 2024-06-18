-- Upgrade script to upgrade from the latest version (January 2022) at the MUHC to the new version (TBD in 2024)

-- Insert alembic tracking table
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
INSERT INTO `alembic_version` (`version_num`) VALUES
('a8a23f24d61b');

-- Update respondentDisplayName for completed and in progress questionnaires
UPDATE answerQuestionnaire AS aq
JOIN patient AS p ON aq.patientId = p.ID
JOIN OpalDB.Patient AS op ON op.PatientSerNum = p.externalId
SET aq.respondentDisplayName = CONCAT_WS(' ', op.FirstName, op.LastName)
WHERE aq.Status = 1 OR aq.Status = 2;

-- Update respondentUsername for completed and in progress questionnaires
UPDATE answerQuestionnaire AS aq
JOIN patient AS p ON aq.patientId = p.ID
JOIN OpalDB.Users AS ou ON ou.UserTypeSerNum = p.externalId
SET aq.respondentUsername = ou.Username
WHERE aq.Status = 1 OR aq.Status = 2;
