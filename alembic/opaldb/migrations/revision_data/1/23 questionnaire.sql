CREATE TABLE IF NOT EXISTS `Questionnaire` (
  `QuestionnaireSerNum` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `QuestionnaireControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `PatientQuestionnaireDBSerNum` int(11) DEFAULT NULL,
  `CompletedFlag` tinyint(4) NOT NULL,
  `CompletionDate` datetime DEFAULT NULL,
  `SessionId` text NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`QuestionnaireSerNum`),
  KEY `QuestionnaireControlSerNum` (`QuestionnaireControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `Questionnaire_ibfk_1` FOREIGN KEY (`QuestionnaireControlSerNum`) REFERENCES `QuestionnaireControl` (`QuestionnaireControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Questionnaire_ibfk_2` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Questionnaire_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `QuestionnaireControl` (
  `QuestionnaireControlSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionnaireDBSerNum` int(11) NOT NULL,
  `QuestionnaireName_EN` varchar(2056) NOT NULL,
  `QuestionnaireName_FR` varchar(2056) NOT NULL,
  `Intro_EN` text NOT NULL,
  `Intro_FR` text NOT NULL,
  `PublishFlag` tinyint(4) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastPublished` datetime NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`QuestionnaireControlSerNum`),
  KEY `QuestionnaireDBSerNum` (`QuestionnaireDBSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`),
  CONSTRAINT `QuestionnaireControl_ibfk_1` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `OAUser` (`OAUserSerNum`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `QuestionnaireControlMH` (
  `QuestionnaireControlSerNum` int(11) NOT NULL,
  `RevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionnaireDBSerNum` int(11) NOT NULL,
  `QuestionnaireName_EN` varchar(2056) NOT NULL,
  `QuestionnaireName_FR` varchar(2056) NOT NULL,
  `Intro_EN` text NOT NULL,
  `Intro_FR` text NOT NULL,
  `PublishFlag` tinyint(4) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdatedBy` int(11) DEFAULT NULL,
  `LastPublished` datetime NOT NULL,
  `SessionId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`QuestionnaireControlSerNum`,`RevSerNum`),
  KEY `LastUpdatedBy` (`LastUpdatedBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `QuestionnaireMH` (
  `QuestionnaireSerNum` int(11) NOT NULL,
  `QuestionnaireRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `QuestionnaireControlSerNum` int(11) NOT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `PatientQuestionnaireDBSerNum` int(11) DEFAULT NULL,
  `CompletedFlag` tinyint(4) NOT NULL,
  `CompletionDate` datetime DEFAULT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  PRIMARY KEY (`QuestionnaireSerNum`,`QuestionnaireRevSerNum`),
  KEY `QuestionnaireControlSerNum` (`QuestionnaireControlSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  KEY `PatientQuestionnaireDBSerNum` (`PatientQuestionnaireDBSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
