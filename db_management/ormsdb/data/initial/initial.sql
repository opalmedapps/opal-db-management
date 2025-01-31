INSERT INTO `Hospital` (`HospitalId`, `HospitalCode`, `HospitalName`, `Format`) VALUES
(1,	'RVH',	'Opal General Hospital 1 (RVH)',	'^[0-9]{7}$'),
(2,	'MGH',	'Opal General Hospital 2 (MGH)',	'^[0-9]{7}$'),
(3,	'MCH',	'Opal Children\'s Hospital',	'^[0-9]{7}$'),
(4,	'LAC', 'Opal General Hospital 3 (LAC)', '^[0-9]{7}$'),
(5,	'CRE', 'Opal General Hospital 4 (CRE)', '^[0-9]{7}$');

REPLACE INTO `SpecialityGroup` (`SpecialityGroupId`, `HospitalId`, `SpecialityGroupCode`, `SpecialityGroupName`, `LastUpdated`) VALUES
(1, 1, 'CCC', 'Cedars Cancer Centre', '2022-01-22 02:34:21'),
(2, 1, 'MedClin', 'Medicine Clinics - RVH', '2022-01-22 02:34:21'),
(3, 1, 'SurgClin', 'Surgical Clinics - RVH', '2022-01-22 02:34:21'),
(4, 3, 'GI', 'Medicine Clinics - MGH', '2022-01-22 02:34:21'),
(5, 2, 'NEPH', 'Nephrology', '2022-01-22 02:34:21');

INSERT INTO `ClinicHub` (`ClinicHubId`, `SpecialityGroupId`, `ClinicHubName`, `LastUpdated`) VALUES
(1, 1, 'D RC', '2022-01-22 02:34:26'),
(2, 1, 'D S1', '2022-01-22 02:34:26'),
(3, 1, 'D 02', '2022-01-22 02:34:26'),
(4, 2, 'Cardiovascular Clinics', '2022-01-22 02:34:26'),
(5, 2, 'CVIS - ID Clinics', '2022-01-22 02:34:26'),
(6, 2, 'Medical Clinics', '2022-01-22 02:34:26'),
(7, 3, 'Surgical Clinics - North', '2022-01-22 02:34:26'),
(8, 3, 'Surgical Clinics - South', '2022-01-22 02:34:26'),
(9, 4, 'IBD clinic', '2022-01-22 02:34:26'),
(10, 5, 'Nephrology', '2022-01-22 02:34:26');

INSERT INTO `Insurance` (`InsuranceId`, `InsuranceCode`, `InsuranceName`, `Format`) VALUES
(1,	'RAMA',	'Régie de l\'assurance maladie de l\'Alberta',	'^[0-9]{9}$'),
(2,	'RAMC',	'Régie de l\'assurance maladie de la Colombie-Britannique',	'^[0-9]{10}$'),
(3,	'RAMM',	'Régie de l\'assurance maladie du Manitoba',	'^[0-9]{9}$'),
(4,	'RAMB',	'Régie de l\'assurance maladie du Nouveau-Brunswick',	'^[0-9]{9}$'),
(5,	'RAMN',	'Régie de l\'assurance maladie de Terre-Neuve',	'^[0-9]{12}$'),
(6,	'RAMT',	'Régie de l\'assurance maladie des Territoires NO',	'^[0-9]{7}$'),
(7,	'RAME',	'Régie de l\'assurance maladie de la Nouvelle-Ecosse',	'^[0-9]{10}$'),
(8,	'RAMU',	'Régie de l\'assurance maladie du Nunavut',	'^[0-9]{9}$'),
(9,	'RAMO',	'Régie de l\'assurance maladie de l\'Ontario',	'^([0-9]{10}[A-Z]{2}|[0-9]{10})$'),
(10, 'RAMI', 'Régie de l\'assurance maladie de l\'IPE',	'^[0-9]{8}$'),
(11, 'RAMQ', 'Régie de l\'assurance maladie du Québec',	'^[a-zA-Z]{4}[0-9]{8}$'),
(12, 'RAMS', 'Régie de l\'assurance maladie de la Saskatchewan',	'^[0-9]{9}$'),
(13, 'RAMY', 'Régie de l\'assurance maladie du Yukon',	'^[0-9]{9}$');

INSERT INTO `BuildType` (`Name`) VALUES
('Production');
