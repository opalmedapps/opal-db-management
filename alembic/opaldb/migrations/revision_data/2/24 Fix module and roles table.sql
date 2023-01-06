Update module
set active = 1
where ID in (13, 20);

DELETE FROM oaRoleModule WHERE oaRoleId IN (SELECT DISTINCT oaRoleId FROM OAUser WHERE `type` = 2);

INSERT INTO oaRoleModule (moduleId, oaRoleId, access)
SELECT DISTINCT m.ID AS moduleId, o.oaRoleId, m.operation AS access FROM OAUser o, module m WHERE o.`type` = 2;
