/* dbv_opaldb/data/revisions/1/ */

/* dbv_opaldb/data/revisions/2/ */

CREATE OR REPLACE VIEW v_masterSourceTestResult AS
SELECT TestExpressionSerNum AS ID, externalId, TestCode AS `code`, ExpressionName AS description, SourceDatabaseSerNum AS `source`,
deleted, deletedBy, DateAdded AS creationDate, createdBy, LastUpdated AS lastUpdated, updatedBy FROM TestExpression;

CREATE OR REPLACE VIEW v_login AS 
    select 
        `OAUser`.`OAUserSerNum` AS `id`,
        `OAUser`.`Username` AS `username`,
        `OAUser`.`Password` AS `password`,
        `OAUser`.`Language` AS `language`,
        `OAUser`.`oaRoleId` AS `role`,
        `OAUser`.`type` AS `type` 
    from `OAUser` 
    WHERE `deleted` = 0
    ;


/* dbv_opaldb/data/revisions/3/ */

/* dbv_opaldb/data/revisions/4/ */

/* dbv_opaldb/data/revisions/5/ */

/* dbv_opaldb/data/revisions/6/ */

/* dbv_opaldb/data/revisions/7/ */

/* dbv_opaldb/data/revisions/8/ */

/* dbv_opaldb/data/revisions/9/ */

/* dbv_opaldb/data/revisions/10/ */

/* dbv_opaldb/data/revisions/11/ */