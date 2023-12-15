WITH foodPrice AS (
	SELECT 
	branch_Name,
	AVG_Value,
	Food_Name,
	AVG_Price_Value,
	payroll_year,
	price_unit
	FROM t_jiri_nohava_project_sql_primary_final
	WHERE Food_Name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
	GROUP BY branch_name, AVG_Value, payroll_year, Food_Name 
	)
	SELECT 
	f1.branch_Name,
	f1.Food_Name,
	CONCAT(ROUND(f1.AVG_Value / f1.AVG_Price_Value, 2), '/', f1.price_unit) AS can_Buy_2006,
	CONCAT(ROUND(f2.AVG_Value / f2.AVG_Price_Value, 2), '/', f1.price_unit)  AS can_Buy_2018
FROM foodPrice AS f1
	INNER JOIN foodPrice AS f2
	ON f1.branch_Name = f2.branch_Name 
	AND f1.food_Name = f2.food_Name 
	AND f2.payroll_year = 2018 
	WHERE f1.payroll_year = 2006;