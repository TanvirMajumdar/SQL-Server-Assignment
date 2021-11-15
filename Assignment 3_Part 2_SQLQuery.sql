--1
select distinct c.City
From Customers c
where c.City in (select City from Employees)

--2a
select distinct c.City
From Customers c
where c.City not in (select City from Employees)

--2b
select distinct c.City
from Customers c
left join Employees e
on e.City=c.City
except 
select distinct e.City
from Employees e

--3
select distinct p.ProductName, sum(o.Quantity) as TotalQuantity
from Products p
inner join [Order Details] o
on p.ProductID=o.ProductID
group by p.ProductName

--4
select c.City, sum(d.Quantity) TotalQuantity
from Orders o
join Customers c
on o.CustomerID=c.CustomerID
join [Order Details] d
on o.OrderID=d.OrderID
group by c.City

--5a
select c.City from Customers c group by c.City having count(c.City)>2
union 
select u.City from Customers u group by u.City having count(u.City)=2

--5b
select distinct c.City
from Customers c
where c.City in (select u.City from Customers u group by u.City having count(u.City)>=2)

--6
select distinct c.City
from Orders o 
left join Customers c
on c.CustomerID=o.CustomerID
left join [Order Details] d
on o.OrderID=d.OrderID
group by c.City, d.ProductID
having count(c.City)>=2

--7
select c.CompanyName
from Customers c 
left join Orders o
on c.CustomerID=o.CustomerID
group by c.CompanyName, c.City, o.ShipCity
having c.City<>o.ShipCity

--8
select top 5 p.ProductName, avg(d.UnitPrice) "Average price", c.City
from Orders o 
left join [Order Details] d
on d.OrderID=o.OrderID
left join Products p
on p.ProductID=d.ProductID
left join Customers c
on o.CustomerID=c.CustomerID
group by p.ProductName,c.City
order by sum(d.Quantity) desc

--9a
select distinct e.City
from Employees e
where e.City not in (select u.City from Customers u inner join Orders o on u.CustomerID=o.CustomerID)

--9b
select distinct e.City
from Employees e
inner join Orders o
on o.EmployeeID=e.EmployeeID
Except 
select distinct c.City
from Customers c
inner join Orders o
on o.CustomerID= c.CustomerID

--10
select distinct  b.city 
from orders a 
join customers b 
on a.CustomerID = b.CustomerID 
where b.city in 
(select top 1 d.city  
from Products b 
join [Order Details] a
on a.ProductID = b.ProductID 
join Orders c 
on c.OrderID = a.OrderID
join Customers d  
on d.CustomerID = c.CustomerID 
group by d.City 
order by count(c.orderid) desc)
and b.city in 
(select top 1 d.city  
from Products b 
join [Order Details] a
on a.ProductID = b.ProductID 
join Orders c 
on c.OrderID = a.OrderID
join Customers d  
on d.CustomerID = c.CustomerID 
group by d.City 
order by count(a.Quantity) desc)

--11
Find duplicate rows using GROUP BY clause or ROW_NUMBER() function.
Use DELETE statement to remove the duplicate rows.

--12
select empid
from Employee 
except 
select mgrid
from Employee

--13
with cte as(
select d.deptname, DENSE_RANK() OVER (ORDER BY count(e.Empid)desc) AS Rnk 
from Employee e
inner join Dept d
on e.Deptid= d.Deptid
group by d.deptname)
select * from cte where Rnk=1

--14
with cte as(
select d.deptname, e.Empid, e.Salary, DENSE_RANK() OVER (PARTITION BY d.deptname  order BY e.Salary desc) AS Rnk 
from Employee e
inner join Dept d
on e.Deptid= d.Deptid
group by d.deptname,e.Empid,e.Salary )
select * from cte where Rnk<=3

--15
with cte as(
select c.City, p.ProductName, DENSE_RANK() OVER (PARTITION BY c.City  order BY sum(d.quantity) desc) AS Rnk 
from Products p
inner join [Order Details] d
on p.ProductID=d.ProductID
inner join Orders o
on o.OrderID=d.OrderID
inner join Customers c
on o.CustomerID=c.CustomerID
group by c.City, p.ProductName)
select * from cte where Rnk<=3