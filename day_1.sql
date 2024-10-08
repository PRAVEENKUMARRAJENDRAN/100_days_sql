/*
Write a SQL Statement that will give you a count of each object type in the AdventureWorks database. 
Order by count descending.
*/

SELECT 
	type_desc,
	COUNT(*) AS Count_type_desc
FROM 
	sys.objects
GROUP BY type_desc
ORDER BY 2 DESC;