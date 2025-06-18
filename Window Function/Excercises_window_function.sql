/*  Aggregate Sum with the Over()

Create a query with the following columns:
FirstName and LastName, from the Person.Person table**
JobTitle, from the HumanResources.Employee table**
Rate, from the HumanResources.EmployeePayHistory table*
A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row
**All the above tables can be joined on BusinessEntityID
All the tables can be inner joined, and you do not need to apply any criteria.

"MaximumRate" that returns the largest of all values in the "Rate" column, in each row.
"DiffFromAvgRate" that returns the result of the following calculation:
"PercentofMaxRate" that returns the result of the following calculation
An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.

*/

SELECT p.FirstName, p.LastName, e.JobTitle, ep.Rate, AverageRate = avg(ep.Rate) OVER(), MaximumRate = MAX(ep.Rate) Over(), DiffFromAvgRate = (ep.Rate - avg(ep.Rate) OVER()), PercentofMaxRate =  CONCAT((ep.Rate/MAX(ep.Rate) Over()) * 100, ' %' )
FROM Person.Person (nolock) p INNER JOIN 
HumanResources.Employee (nolock) e ON p.BusinessEntityID = e.BusinessEntityID 
INNER JOIN
HumanResources.EmployeePayHistory (nolock) ep ON e.BusinessEntityID = ep.BusinessEntityID

/*
Excercise with the Partition 
“Name” from the Production.Product table, which can be alised as “ProductName”
“ListPrice” from the Production.Product table
“Name” from the Production. ProductSubcategory table, which can be alised as “ProductSubcategory”*
“Name” from the Production.ProductCategory table, which can be alised as “ProductCategory”**
*Join Production.ProductSubcategory to Production.Product on “ProductSubcategoryID”
**Join Production.ProductCategory to ProductSubcategory on “ProductCategoryID”

"AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.
"AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.
"ProductVsCategoryDelta" that returns the result of the following calculation:
A product's list price, MINUS the average ListPrice for that product’s category.
*/
SELECT AVG(p.ListPrice), pc.Name
FROM Production.Product p INNER JOIN Production.ProductSubcategory ps 
ON p.ProductSubcategoryID = ps.ProductSubcategoryID  
INNER JOIN Production.ProductCategory pc
ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name

SELECT p.Name as ProductName, p.ListPrice, ps.Name, pc.Name,
AvgPriceByCategory= AVG(p.ListPrice) OVER(),
AvgPriceByCategoryAndSubcategory = AVG(p.ListPrice) OVER(PARTITION BY ps.Name, pc.Name),
ProductVsCategoryDelta = p.ListPrice - AVG(p.ListPrice) OVER (PARTITION BY pc.Name)
FROM Production.Product p INNER JOIN Production.ProductSubcategory ps 
ON p.ProductSubcategoryID = ps.ProductSubcategoryID  
INNER JOIN Production.ProductCategory pc
ON ps.ProductCategoryID = pc.ProductCategoryID




