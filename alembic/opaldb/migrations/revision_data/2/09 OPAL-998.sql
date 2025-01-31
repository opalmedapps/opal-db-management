UPDATE Filters f LEFT JOIN Patient p ON p.PatientId = f.FilterId SET f.FilterId = p.PatientSerNum WHERE f.FilterType = "Patient" AND f.FilterId != "ALL";

UPDATE `OpalDB`.`publicationSetting` SET `opalDB`='SELECT DISTINCT PatientSerNum AS id, \'Patient\' AS type, 0 AS added, CONCAT(CONCAT(UCASE(SUBSTRING(LastName, 1, 1)), LOWER(SUBSTRING(LastName, 2))), \', \', CONCAT(UCASE(SUBSTRING(FirstName, 1, 1)), LOWER(SUBSTRING(FirstName, 2)))) AS name FROM Patient ORDER BY LastName;' WHERE  `ID`=2;
