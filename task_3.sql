SELECT 
	Food_Name,
	AVG(delta) AS Decline
FROM (WITH foodPrice AS (
	SELECT 
	Food_Name, 
	AVG_Price_Value,
	payroll_year
	FROM t_jiri_nohava_project_sql_primary_final
	GROUP BY Food_Name, payroll_year, AVG_Price_Value
)
	SELECT
	f1.Food_Name,
	ROUND((1 -(f1.AVG_Price_Value / f2.AVG_Price_Value)) * 100, 2) AS delta
FROM foodPrice AS f1
INNER JOIN foodPrice AS f2 
	ON f1.Food_Name = f2.Food_Name 
	AND f1.payroll_year = f2.payroll_year - 1 ) AS foodPriceDiff
GROUP BY Food_Name
-- HAVING AVG(delta) > 0
ORDER BY Decline ASC;