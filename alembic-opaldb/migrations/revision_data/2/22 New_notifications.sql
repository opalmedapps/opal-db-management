INSERT INTO `NotificationTypes` (`NotificationTypeId`, `NotificationTypeName`, `DateAdded`, `LastUpdated`) 
VALUES('AppointmentNew','New Appointment', now(), now());

INSERT INTO `NotificationControl` (`Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationType`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `LastUpdated`, `SessionId`) 
VALUES('Appointment Cancelled','Rendez-vous annulé',
		'Your appointment on $oldAppointmentDateEN at $oldAppointmentTimeEN has been cancelled.',
		'Votre rendez-vous le $oldAppointmentDateFR à $oldAppointmentTimeFR à été annulé.','AppointmentCancelled',
		(select `NotificationTypeSerNum` from `NotificationTypes` where `NotificationTypeId` = 'AppointmentCancelled'), 
		now(), null, '0000-00-00 00:00:00', now(), null
	);

INSERT INTO `NotificationControl` (`Name_EN`, `Name_FR`, `Description_EN`, `Description_FR`, `NotificationType`, `NotificationTypeSerNum`, `DateAdded`, `LastUpdatedBy`, `LastPublished`, `LastUpdated`, `SessionId`) VALUES
	('New Appointment', 'Nouveau rendez-vous', 'You have a new appointment on $newAppointmentDateEN at $newAppointmentTimeEN', 
		'Vous avez un nouveau rendez-vous le $newAppointmentDateFR à $newAppointmentTimeFR', 'AppointmentNew', 
		(select `NotificationTypeSerNum` from `NotificationTypes` where `NotificationTypeId` = 'AppointmentNew'), 
		now(), NULL, '0000-00-00 00:00:00', now(), NULL
	);
