WITH branchDiff AS (
	WITH base AS (
	SELECT 
		branch_Name, 
		AVG_Value,
		payroll_year
		FROM t_jiri_nohava_project_sql_primary_final
	GROUP BY branch_Name, payroll_year, AVG_Value)
	SELECT 
	base.branch_Name,
	(b2.AVG_Value - base.AVG_Value) AS delta,
	IF ((b2.AVG_Value - base.AVG_Value) < 0, 0, 1) AS diffUp
	FROM base 
	INNER JOIN base AS b2 ON base.branch_Name = b2.branch_Name
	AND base.payroll_year = b2.payroll_year - 1
)
SELECT IF (SUM(diffUp) = 12, 'Vzrůstala stále', 'Nevzrůstala stále') AS result, branch_Name
FROM branchDiff
GROUP BY branch_Name;