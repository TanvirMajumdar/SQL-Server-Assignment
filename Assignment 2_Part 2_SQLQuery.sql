Select count(p.ProductID) "Total Products" 
from Production.Product p

Select count(p.ProductID) "Total products"
from Production.Product p
where p.ProductSubcategoryID is not null

select ProductSubcategoryID, count (ProductSubcategoryID) "CountedProducts"
from Production.Product 
where ProductSubcategoryID is not NULL
group by ProductSubcategoryID

select count(p.ProductID) "Total products"
from Production.Product p
where p.ProductSubcategoryID is null

Select * 
From Production.ProductInventory

select ProductID, Sum(quantity) "TheSum"
from Production.ProductInventory
where LocationID = 40
group by ProductID
having Sum(quantity) < 100

select Shelf, ProductID, Sum(quantity) "TheSum"
From Production.ProductInventory
Where LocationID = 40
Group by ProductID, shelf
Having Sum(quantity) < 100

select Avg(quantity) "Avg"
From Production.ProductInventory
Where LocationID = 10

select ProductID, Shelf, Avg(quantity) "Avg"
From Production.ProductInventory
Group by Rollup (Shelf, ProductID)

select ProductID, Shelf, Avg(quantity) "Avg"
From Production.ProductInventory
where Shelf not in ('N/A')
Group by Rollup (Shelf, ProductID)

select c.Name as country, s.Name as province
from Person.CountryRegion c
join Person.StateProvince s
on c.CountryRegionCode=s.CountryRegionCode

select c.Name as country, s.Name as province
from Person.CountryRegion c
join Person.StateProvince s
on c.CountryRegionCode=s.CountryRegionCode
where c.Name in ('Germany', 'Canada')
order by c.Name

select distinct p.ProductName
from [Order Details] o
left join Products p
on p.ProductID=o.ProductID
left join Orders d
on o.OrderID=d.OrderID
where d.OrderDate between '1996-11-12' and '2021-11-11'

select  top 5 o.ShipPostalCode
from Orders o
group by o.ShipPostalCode
order by count(o.ShipPostalCode) desc

select top 5 o.ShipPostalCode 
from Orders o
where o.OrderDate between '2001-11-12' and '2021-11-11'
group by o.ShipPostalCode
order by count(o.ShipPostalCode) desc

select o.ShipCity, count(c.CustomerID) "Number of Customers"
from Orders o
join Customers c
on o.CustomerID=c.CustomerID
group by o.ShipCity

select o.ShipCity, count(c.CustomerID) "Number of Customers"
from Orders o
join Customers c
on o.CustomerID=c.CustomerID
group by o.ShipCity
having count(c.CustomerID)>10

select c.ContactName, o.OrderDate
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
where o.OrderDate> '1998-1-1'


SELECT *
  FROM 
	(select c.ContactName, o.OrderDate as MostRecentDate, dense_rank() over (partition by c.ContactName order by o.OrderDate desc) rnk
	from Customers c
	join Orders o
	on c.CustomerID=o.CustomerID) a
WHERE a.rnk = 1

select c.ContactName, count(d.Quantity) as "Total Products Bought"
from Orders o 
join Customers c
on c.CustomerID=o.CustomerID
join [Order Details] d
on o.OrderID=d.OrderID
group by c.ContactName

select c.ContactName, count(d.Quantity) as "Total Products Bought"
from Orders o 
left join Customers c
on c.CustomerID=o.CustomerID
left join [Order Details] d
on o.OrderID=d.OrderID
group by c.ContactName
order by c.ContactName

select c.CustomerID, count(d.Quantity) as "Total Products Bought"
from Orders o 
left join Customers c
on c.CustomerID=o.CustomerID
left join [Order Details] d
on o.OrderID=d.OrderID
group by c.CustomerID
having count(d.Quantity)>100

select su.CompanyName "Supplier Company Name ", sh.CompanyName "Shipping Company Name"
from Shippers sh
cross join Suppliers su

select distinct o.OrderDate, p.ProductName
from [Order Details] d 
join Orders o
on o.OrderID=d.OrderID
join Products p
on d.ProductID=p.ProductID

select * 
from Employees e inner join Employees m 
on e.Title = m.Title

select e.EmployeeID, e.LastName, e.FirstName
from Employees e, Employees m
where e.EmployeeID=m.ReportsTo
group by e.EmployeeID, e.LastName, e.FirstName
having count(m.ReportsTo)>2

select city, ContactName, 'Customer' "Type" from Customers
union 
select city, ContactName, 'Supplier' "Type" from Suppliers

select * 
from F1 
inner join F2 
on F1.T1 = F2.T2

F1.T1 F2.T2
2 2
3 3


select * from F1 
left join F2 
on F1.T1 = F2.T2

F1.T1 F2.T2
1 null
2 2
3 3