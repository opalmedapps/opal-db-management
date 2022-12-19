CREATE TABLE IF NOT EXISTS `Announcement` (
  `AnnouncementSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL DEFAULT 0,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`AnnouncementSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`),
  CONSTRAINT `Announcement_ibfk_1` FOREIGN KEY (`PatientSerNum`) REFERENCES `Patient` (`PatientSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Announcement_ibfk_2` FOREIGN KEY (`PostControlSerNum`) REFERENCES `PostControl` (`PostControlSerNum`) ON UPDATE CASCADE,
  CONSTRAINT `Announcement_ibfk_3` FOREIGN KEY (`CronLogSerNum`) REFERENCES `CronLog` (`CronLogSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `AnnouncementMH` (
  `AnnouncementSerNum` int(11) NOT NULL,
  `AnnouncementRevSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronLogSerNum` int(11) DEFAULT NULL,
  `PatientSerNum` int(11) NOT NULL,
  `PostControlSerNum` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `ReadStatus` int(11) NOT NULL,
  `ModificationAction` varchar(25) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`AnnouncementSerNum`,`AnnouncementRevSerNum`),
  KEY `PatientSerNum` (`PatientSerNum`),
  KEY `PostControlSerNum` (`PostControlSerNum`),
  KEY `CronLogSerNum` (`CronLogSerNum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
