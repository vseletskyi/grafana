SELECT p.kind, p.attribute, p.identifier, p.scope FROM "grafana"."permission" as p
WHERE
  p.action = 'folders:read'
AND p.role_id IN (
  SELECT role_id FROM "grafana"."builtin_role" as br WHERE (br.role = 'None' AND (br.org_id = 1 OR br.org_id = 0))
    UNION
  SELECT role_id FROM "grafana"."user_role" as ur WHERE ur.user_id = 1 AND (ur.org_id = 1 OR ur.org_id = 0)
    UNION
    SELECT role_id FROM "grafana"."team_role" as tr WHERE tr.team_id IN (1, 2) AND tr.org_id = 1
)
