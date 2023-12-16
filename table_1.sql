CREATE TABLE t_jiri_nohava_project_SQL_primary_final AS
SELECT 
	AVG(cp.value) AS AVG_Value,
	'Kč' AS currency_code,
	cpib.name AS branch_Name,
	cp.payroll_year,
	cp2.avgValue AS AVG_Price_Value,
	cp2.inValue AS Min_Value,
	cp2.axValue AS Max_Value,
	cpc.name AS Food_Name,
	cpc.price_value,
	cpc.price_unit 
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib 
	ON cpib.code = cp.industry_branch_code 
JOIN (
		SELECT YEAR(subCp.date_from) AS cpYear,
		AVG(subCp.value) AS avgValue,
		MIN(subcp.value) AS inValue,
		MAX(subcp.value) AS axValue,
		subCp.category_code
		FROM czechia_price subCp 
		WHERE YEAR(subCp.date_from) BETWEEN 2006 AND 2018
		GROUP BY YEAR(subCp.date_from), subCp.category_code
	) AS cp2 ON cp.payroll_year = cp2.cpYear
JOIN czechia_price_category cpc 
	ON cpc.code = cp2.category_code
WHERE cp.calculation_code = 100 
AND cp.value IS NOT NULL 
AND cp.unit_code = 200 
AND cp.value_type_code = 5958 
GROUP BY cp.payroll_year, cpib.name, cpc.code, cpc.name, cp2.avgValue, cp2.inValue, cp2.axValue;
