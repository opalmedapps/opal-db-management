-- MediVisit is not the correct database source name.
Update `SourceDatabase` SET `SourceDatabaseName` = 'eRDV', `Enabled` = 1 WHERE `SourceDatabaseSerNum` = 5;
