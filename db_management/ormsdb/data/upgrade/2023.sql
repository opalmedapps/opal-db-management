-- Upgrade script to upgrade from the latest version (January 2022) at the MUHC to the new version (TBD in 2023)

-- Add BuildType table and set to Production
DROP TABLE IF EXISTS `BuildType`;
CREATE TABLE `BuildType` (
  `Name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `BuildType` (`Name`) VALUES
('Production');
