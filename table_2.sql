CREATE TABLE t_jiri_nohava_project_SQL_secondary_final AS
SELECT 
	c.country,
	c.capital_city,
	e.year,
	ROUND (e.GDP / 1000000) AS GDP_mil_dollars
FROM countries c 
JOIN economies e 
	ON c.country = e.country 
	AND c.continent LIKE ('Europe') 
	AND e.`year` BETWEEN 2006 AND 2018
	AND c.independence_date IS NOT NULL
GROUP BY c.country, c.capital_city, e.year, GDP_mil_dollars;
