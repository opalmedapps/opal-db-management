-- change the appointment module name
UPDATE module
SET name_EN = 'Appointments / Documents', name_FR = 'Rendez-vous / Documents',
	description_EN = 'Tool for appointments and documents.', description_FR = 'Gestion des rendez-vous et documents.',
	subModule = '{"1": {"ID": 1, "name_EN": "Appointment","name_FR": "Rendez-vous","iconClass": "calendar"},"2": {"ID": 2, "name_EN": "Document","name_FR": "Document","iconClass": "folder-open"}}'
WHERE name_EN = 'Tasks / Appointments / Documents';
