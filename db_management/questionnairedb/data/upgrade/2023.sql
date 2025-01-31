-- Upgrade script to upgrade from the latest version (January 2022) at the MUHC to the new version (TBD in 2023)

-- Insert alembic tracking table
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
INSERT INTO `alembic_version` (`version_num`) VALUES
('a8a23f24d61b');
