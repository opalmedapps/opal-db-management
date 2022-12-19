CREATE TABLE `patientStudyMH` (
    `patientStudyId` BIGINT(20) NOT NULL,
    `revisionId` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `action` VARCHAR(128) NOT NULL,
    `patientId` INT(11) NOT NULL,
    `studyId` BIGINT(20) NOT NULL,
    `consentStatus` INT(11) NOT NULL,
    `readStatus` INT(11) NOT NULL,
    `lastUpdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`patientStudyId`, `revisionId`) USING BTREE,
    INDEX `patientId` (`patientId`) USING BTREE,
    INDEX `studyId` (`studyId`) USING BTREE,
    INDEX `lastUpdated` (`lastUpdated`) USING BTREE,
    INDEX `revisionId` (`revisionId`) USING BTREE
);

CREATE TRIGGER `patientStudy_after_insert` AFTER INSERT ON `patientStudy` FOR EACH ROW BEGIN
    INSERT INTO `patientStudyMH` (`patientStudyId`, `action`, `patientId`, `studyId`, `consentStatus`, `readStatus`, `lastUpdated`)
    VALUES (NEW.ID, 'INSERT', NEW.patientId, NEW.studyId, NEW.consentStatus, NEW.readStatus, NOW());
END;

CREATE TRIGGER `patientStudy_after_update` AFTER UPDATE ON `patientStudy` FOR EACH ROW BEGIN
    INSERT INTO `patientStudyMH` (`patientStudyId`, `action`, `patientId`, `studyId`, `consentStatus`, `readStatus`, `lastUpdated`)
    VALUES (NEW.ID, 'UPDATE', NEW.patientId, NEW.studyId, NEW.consentStatus, NEW.readStatus, NOW());
END;

CREATE TRIGGER `patientStudy_after_delete` AFTER DELETE ON `patientStudy` FOR EACH ROW BEGIN
    INSERT INTO `patientStudyMH`(`patientStudyId`, `action`, `patientId`, `studyId`, `consentStatus`, `readStatus`, `lastUpdated`)
    VALUES (OLD.ID, 'DELETE', OLD.patientId, OLD.studyId, OLD.consentStatus, OLD.readStatus, NOW());
END;
