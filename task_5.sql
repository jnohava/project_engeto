WITH Food AS (
SELECT *
FROM (
	WITH foodPrice AS (
		SELECT 
		AVG(AVG_Price_Value) AS AVG_FoodPrice,
		AVG(AVG_Value) AS AVG_payroll,
		payroll_year,
		sec.GDP_mil_dollars
	FROM t_jiri_nohava_project_sql_primary_final
	INNER JOIN t_jiri_nohava_project_sql_secondary_final AS sec 
		ON sec.country = 'Czech Republic' 
		AND payroll_year = `year` 
	GROUP BY payroll_year
	)
	SELECT 
	f1.payroll_year AS year_1,
	f2.payroll_year AS year_2,
	ROUND((1 -(f2.AVG_FoodPrice / f1.AVG_FoodPrice)) * 100, 2) AS Food_Percent, 
	ROUND((1 -(f2.AVG_payroll / f1.AVG_payroll)) * 100, 2) AS Payroll_Percent, 
	ROUND((1 -(f2.GDP_mil_dollars / f1.GDP_mil_dollars)) * 100, 2) AS GDP_Percent, 
	ROUND((1 -(f3.GDP_mil_dollars / f2.GDP_mil_dollars)) * 100, 2) AS GDP_Before_Percent
	FROM foodPrice AS f1
	INNER JOIN foodPrice AS f2
		ON f1.payroll_year - 1 = f2.payroll_year 
	LEFT JOIN foodPrice AS f3 
		ON f2.payroll_year - 1 = f3.payroll_year ) AS foodPriceDiff
	) 
SELECT *
FROM Food;