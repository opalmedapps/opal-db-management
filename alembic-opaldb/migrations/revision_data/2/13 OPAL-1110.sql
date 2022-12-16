Update module
set operation = 3
where name_EN not in (
    'Tasks / Appointments / Documents', 'Diagnosis Import and Aliasing',
    'Trigger (API only / No GUI)', 'Master Lists Management (API only / No GUI)',
    'Resources (API only / No GUI)'
    )
and operation = 7
;


update oaRoleModule
set access = 3
where oaRoleId not in (
	select ID From module
	where name_EN not in (
		'Tasks / Appointments / Documents', 'Diagnosis Import and Aliasing',
		'Trigger (API only / No GUI)', 'Master Lists Management (API only / No GUI)',
		'Resources (API only / No GUI)'
		)
	)
and access = 7
;
