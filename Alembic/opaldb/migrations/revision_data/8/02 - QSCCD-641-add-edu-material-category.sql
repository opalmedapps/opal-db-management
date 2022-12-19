CREATE TABLE IF NOT EXISTS `EducationalMaterialCategory` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment.',
  `title_EN` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'English title of an educational material category.',
  `title_FR` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'French title of an educational material category.',
  `description_EN` VARCHAR(512) NOT NULL DEFAULT '' COMMENT 'English description of an educational material category.',
  `description_FR` VARCHAR(512) NOT NULL DEFAULT '' COMMENT 'French description of an educational material category.',
  PRIMARY KEY (`ID`)
) ENGINE = InnoDB;

SET @clinicalId = 1;

INSERT INTO `EducationalMaterialCategory` (`ID`, `title_EN`, `title_FR`, `description_EN`, `description_FR`) VALUES
(@clinicalId, 'Clinical', 'Clinique', 'Clinical category', 'Catégorie clinique');

INSERT INTO `EducationalMaterialCategory` (`ID`, `title_EN`, `title_FR`, `description_EN`, `description_FR`) VALUES
(@clinicalId + 1, 'Research', 'Recherche', 'Research category', 'Catégorie recherche');

SET @query = CONCAT('ALTER TABLE `EducationalMaterialControl` ADD COLUMN `EducationalMaterialCategoryId` BIGINT NOT NULL DEFAULT "', @clinicalId, '" COMMENT "Foreign key with ID in EducationalMaterialCategory table." AFTER `EducationalMaterialType_FR`;');
prepare stmt from @query;
execute stmt;
deallocate prepare stmt;

ALTER TABLE `EducationalMaterialControl`
ADD CONSTRAINT `fk_EMC_CategoryId_EMC_ID`
    FOREIGN KEY (`EducationalMaterialCategoryId`)
    REFERENCES `EducationalMaterialCategory` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

UPDATE `EducationalMaterialControl` SET `EducationalMaterialCategoryId` = @clinicalId;
