QSCCD-130: Edit the push notification descriptions (in NotificationControl) to add $patientName and improve phrasing.
The placeholder will be replaced with the patient's first name in UPS / Caregiver.

QSCCD-455: Due to moving the Device model to Django, PushNotification shouldn't have a foreign key to
the PatientDeviceIdentifier table anymore (use of this table will be discontinued).

QSCCD-209: Adds two new fields 'Parameters' and 'TargetPatientId' to PatientActivityLog. This will improve logging
after the introduction of loading-on-demand and UPS request targeting.

QSCCD-427: Drops an unused procedure to get registration encryption info to decrypt requests.
This information is now fetched from the new Django backend.
