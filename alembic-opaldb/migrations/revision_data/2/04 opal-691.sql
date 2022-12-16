ALTER TABLE `TestResultControl`
	DROP FOREIGN KEY `TestResultControl_ibfk_3`;
ALTER TABLE `TestResultControl`
	ADD CONSTRAINT `FK_TestResultControl_EducationalMaterialControl` FOREIGN KEY (`EducationalMaterialControlSerNum`) REFERENCES `EducationalMaterialControl` (`EducationalMaterialControlSerNum`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `TestResultExpression`
	DROP FOREIGN KEY `TestResultExpression_ibfk_1`;
ALTER TABLE `TestResultExpression`
	ADD CONSTRAINT `FK_TestResultExpression_TestResultControl` FOREIGN KEY (`TestResultControlSerNum`) REFERENCES `TestResultControl` (`TestResultControlSerNum`) ON UPDATE CASCADE ON DELETE RESTRICT;
