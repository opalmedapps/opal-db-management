CREATE FUNCTION `getResource`(`in_Type` VARCHAR(25),
	`in_AppointmentSerNum` BIGINT
) RETURNS varchar(200) CHARSET latin1
    DETERMINISTIC
BEGIN
	Declare wsReturn, wsType, wsDescription VarChar(255);
	Declare wsAppointmentSerNum BigInt;
	Declare wsLoopCount, wsCount int;
	
	set wsType = in_Type;
	set wsAppointmentSerNum = in_AppointmentSerNum;

	select count(*) from ResourceAppointment where AppointmentSerNum = wsAppointmentSerNum into wsCount;
	
	set wsLoopCount = 0;
	set wsReturn = '';
	
	while wsLoopCount < wsCount do
		
		-- ResourceName
		-- ResourceType
		if (trim(wsType) = 'ResourceName') then
			Select trim(ResourceName) from ResourceAppointment RA, Resource R 
			where RA.AppointmentSerNum = wsAppointmentSerNum and RA.ResourceSerNum = R.ResourceSerNum
			limit wsLoopCount,1 into wsDescription;

			set wsReturn = wsDescription;
			-- set wsReturn = concat(wsReturn, wsDescription);
				
		end if; 
		
		if (wsType = 'ResourceType') then
			Select trim(ResourceType) from ResourceAppointment RA, Resource R 
			where RA.AppointmentSerNum = wsAppointmentSerNum and RA.ResourceSerNum = R.ResourceSerNum
			limit wsLoopCount,1 into wsDescription;
			
			set wsReturn = wsDescription;
		end if; 
		
		-- set wsReturn = concat(wsReturn, wsDescription);
					
		Set wsLoopCount = wsLoopCount + 1;
		
		if (wsLoopCount < wsCount) then
			set wsReturn = concat(wsReturn, ' -- ');
		end if;
				
	end while;
	
	Return wsReturn;
	
END;

CREATE TABLE IF NOT EXISTS `Resource` (
  `ResourceSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `SourceDatabaseSerNum` int(11) NOT NULL,
  `ResourceAriaSer` int(11) NOT NULL,
  `ResourceName` varchar(255) NOT NULL,
  `ResourceType` varchar(1000) NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ResourceSerNum`),
  KEY `ResourceAriaSer` (`ResourceAriaSer`),
  KEY `SourceDatabaseSerNum` (`SourceDatabaseSerNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `ResourceAppointment` (
  `ResourceAppointmentSerNum` int(11) NOT NULL AUTO_INCREMENT,
  `ResourceSerNum` int(11) NOT NULL,
  `AppointmentSerNum` int(11) NOT NULL,
  `ExclusiveFlag` varchar(11) NOT NULL,
  `PrimaryFlag` varchar(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ResourceAppointmentSerNum`),
  KEY `AppointmentSerNum` (`AppointmentSerNum`),
  CONSTRAINT `ResourceAppointment_ibfk_1` FOREIGN KEY (`AppointmentSerNum`) REFERENCES `Appointment` (`AppointmentSerNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;