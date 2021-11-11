select p.ProductID, p.Name, p.Color, p.ListPrice  
from Production.Product p

select p.ProductID, p.Name, p.Color, p.ListPrice  
from Production.Product p 
where p.ListPrice=0.00

select p.ProductID, p.Name, p.Color, p.ListPrice  
from Production.Product p 
where p.Color is NULL

select p.ProductID, p.Name, p.Color, p.ListPrice  
from Production.Product p 
where p.Color is not NULL

select p.ProductID, p.Name, p.Color, p.ListPrice  
from Production.Product p 
where p.Color is not NULL and p.ListPrice>0.00

select 'Name: '+ p.Name "Name", 'Color: '+ p.Color "Color"
from Production.Product p 
where p.Color is not NULL 

select p.Name, p.Color
from Production.Product p 
where p.Name like '%Crankarm'
or p.Name like 'Chainring%'
order by ProductID

select p.ProductID, p.Name
from Production.Product p 
where p.ProductID between 400 and 500

select p.ProductID, p.Name, p.Color
from Production.Product p 
where p.Color='black' or p.Color='blue'

select ProductID, Name, Color
from Production.Product p 
where p.Name like 'S%'

select p.Name, p.ListPrice
from Production.Product p 
where p.Name like 'S%'
order by p.Name

select p.Name, p.ListPrice
from Production.Product p 
where p.Name like '[a,s]%'
order by p.Name

select p.Name
from Production.Product p 
where p.Name like 'SPO[^K]%'
order by p.Name

select distinct p.Color
from Production.Product p 
where p.Color is not null
order by p.Color desc

select distinct p.ProductSubcategoryID, p.Class
from Production.Product p 
where p.ProductSubcategoryID is not null and p.Class is not null

SELECT ProductSubCategoryID
 , LEFT([Name],35) AS [Name]
 , Color, ListPrice 
FROM Production.Product
WHERE Color IN ('Red','Black') 
 AND ListPrice BETWEEN 1000 AND 2000 
 AND ProductSubCategoryID = 1
ORDER BY ProductID

SELECT ProductSubCategoryID
 , LEFT([Name],35) AS [Name]
 , Color, ListPrice 
FROM Production.Product
where ProductSubCategoryID between 1 and 14 
ORDER BY ProductSubCategoryID desc










