UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New document',
    nc.Description_FR = '$patientName: Nouveau document'
WHERE
    nc.NotificationControlSerNum = 2
    AND nc.NotificationType = 'Document'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New message from your treatment team',
    nc.Description_FR = '$patientName: Nouveau message de votre équipe soignante'
WHERE
    nc.NotificationControlSerNum = 4
    AND nc.NotificationType = 'TxTeamMessage'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New general announcement',
    nc.Description_FR = '$patientName: Nouvelle annonce générale'
WHERE
    nc.NotificationControlSerNum = 5
    AND nc.NotificationType = 'Announcement'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: Appointment on $oldAppointmentDateEN at $oldAppointmentTimeEN has been changed to $newAppointmentDateEN at $newAppointmentTimeEN',
    nc.Description_FR = '$patientName: Rendez-vous du $oldAppointmentDateFR à $oldAppointmentTimeFR a été changé au $newAppointmentDateFR à $newAppointmentTimeFR'
WHERE
    nc.NotificationControlSerNum = 6
    AND nc.NotificationType = 'AppointmentTimeChange'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New educational material',
    nc.Description_FR = '$patientName: Nouveau matériel éducatif'
WHERE
    nc.NotificationControlSerNum = 7
    AND nc.NotificationType = 'EducationalMaterial'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: Next appointment',
    nc.Description_FR = '$patientName: Prochain rendez-vous'
WHERE
    nc.NotificationControlSerNum = 8
    AND nc.NotificationType = 'NextAppointment'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: Document updated',
    nc.Description_FR = '$patientName: Document mis à jour'
WHERE
    nc.NotificationControlSerNum = 9
    AND nc.NotificationType = 'UpdDocument'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: Please go to $roomNumber for your appointment',
    nc.Description_FR = '$patientName: Veuillez vous rendre à $roomNumber pour votre rendez-vous'
WHERE
    nc.NotificationControlSerNum = 10
    AND nc.NotificationType = 'RoomAssignment'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New questionnaire received. Please complete it before seeing your health care provider.',
    nc.Description_FR = '$patientName: Nouveau questionnaire reçu. Veuillez le compléter avant votre rendez-vous avec votre professionnel de la santé.'
WHERE
    nc.NotificationControlSerNum = 11
    AND nc.NotificationType = 'Questionnaire'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: Successfully checked in for your appointment(s) at $getDateTime. You will receive another notification when you are called in to your appointment(s).',
    nc.Description_FR = '$patientName: Enregistrement réussi à votre/vos rendez-vous de $getDateTime. Vous recevrez une autre notification lorsque vous serez appelé(e) à votre/vos rendez-vous.'
WHERE
    nc.NotificationControlSerNum = 12
    AND nc.NotificationType = 'CheckInNotification'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New questionnaire received. Please complete it before seeing your health care provider.',
    nc.Description_FR = '$patientName: Nouveau questionnaire reçu. Veuillez le compléter avant votre rendez-vous avec votre professionnel de la santé.'
WHERE
    nc.NotificationControlSerNum = 13
    AND nc.NotificationType = 'LegacyQuestionnaire'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: Couldn\'t check into one or more appointments. Please go to the reception.',
    nc.Description_FR = '$patientName: Enregistrement impossible à un ou plusieurs rendez-vous. Veuillez vous rendre à la réception.'
WHERE
    nc.NotificationControlSerNum = 14
    AND nc.NotificationType = 'CheckInError'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New lab test result',
    nc.Description_FR = '$patientName: Nouveau résultat de test de laboratoire'
WHERE
    nc.NotificationControlSerNum = 15
    AND nc.Name_EN = 'New Lab Result'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: Appointment on $oldAppointmentDateEN at $oldAppointmentTimeEN has been cancelled.',
    nc.Description_FR = '$patientName: Rendez-vous du $oldAppointmentDateFR à $oldAppointmentTimeFR a été annulé.'
WHERE
    nc.NotificationControlSerNum = 16
    AND nc.NotificationType = 'AppointmentCancelled'
;

UPDATE OpalDB.NotificationControl nc
SET
    nc.Description_EN = '$patientName: New appointment on $newAppointmentDateEN at $newAppointmentTimeEN',
    nc.Description_FR = '$patientName: Nouveau rendez-vous le $newAppointmentDateFR à $newAppointmentTimeFR'
WHERE
    nc.NotificationControlSerNum = 17
    AND nc.NotificationType = 'AppointmentNew'
;
