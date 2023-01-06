CREATE TABLE IF NOT EXISTS `categoryModule` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. Auto-increment',
  `name_EN` varchar(128) NOT NULL COMMENT 'English name of the category',
  `name_FR` varchar(128) NOT NULL COMMENT 'French name of the category',
  `order` int(3) NOT NULL DEFAULT 999 COMMENT 'Order in the navigation menu',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
