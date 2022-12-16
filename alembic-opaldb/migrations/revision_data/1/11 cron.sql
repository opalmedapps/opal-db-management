CREATE TABLE IF NOT EXISTS `Cron` (
  `CronSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `NextCronDate` date NOT NULL,
  `RepeatUnits` varchar(50) NOT NULL,
  `NextCronTime` time NOT NULL,
  `RepeatInterval` int(11) NOT NULL,
  `LastCron` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`CronSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `CronLog` (
  `CronLogSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `CronSerNum` int(11) NOT NULL,
  `CronStatus` varchar(25) NOT NULL,
  `CronDateTime` datetime NOT NULL,
  PRIMARY KEY (`CronLogSerNum`),
  KEY `CronSerNum` (`CronSerNum`),
  CONSTRAINT `CronLog_ibfk_1` FOREIGN KEY (`CronSerNum`) REFERENCES `Cron` (`CronSerNum`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;