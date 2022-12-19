CREATE TABLE IF NOT EXISTS `accesslevel` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccessLevelName_EN` varchar(200) NOT NULL,
  `AccessLevelName_FR` varchar(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to store level of access in opal application. There are two levels 1- Need to Know and 2-All. ';
