WITH Food AS (
	SELECT 
	IF (deltaFoodPercent - deltaPayrollPercent > 10, 1, 0) AS diff
FROM (WITH foodPrice AS (
	SELECT 
	AVG(AVG_Price_Value) AS AVG_FoodPrice,
	AVG(AVG_Value) AS AVG_payroll,
	payroll_year
	FROM t_jiri_nohava_project_sql_primary_final
	GROUP BY payroll_year
)
	SELECT 
	f1.payroll_year AS year1,
	f2.payroll_year AS year2,
	ROUND((1 -(f1.AVG_FoodPrice / f2.AVG_FoodPrice)) * 100, 2) AS deltaFoodPercent, 
	ROUND((1 -(f1.AVG_payroll / f2.AVG_payroll)) * 100, 2) AS deltaPayrollPercent
	FROM foodPrice AS f1
	INNER JOIN foodPrice AS f2 
		ON f1.payroll_year = f2.payroll_year - 1 ) AS foodPriceDiff
) 
	SELECT IF (SUM(diff) > 0, 'Existuje', 'Neexistuje') AS Food
	FROM Food;