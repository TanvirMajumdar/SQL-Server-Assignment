--1
begin tran
select * from Region with(holdlock)
select * from Territories with(holdlock)
select * from EmployeeTerritories with(holdlock)
select * from Employees with(holdlock)
insert into Region (RegionID,RegionDescription) values (10,'Middle Earth')
insert into Territories(TerritoryID,TerritoryDescription,RegionID)
values(98600,'Gondor', 15)
insert into EmployeeTerritories(EmployeeID,TerritoryID) values (50,98600)
insert into Employees(LastName,FirstName) values ('king','aragorn')
rollback

--2
begin tran
update Territories set TerritoryDescription='Arnor' where TerritoryDescription='Gondor'
rollback

--3
begin tran
delete from Region where RegionID=10 and RegionDescription='Middle Earth'
rollback

--4
create view view_product_order_majumdar as
select distinct p.ProductName, sum(d.Quantity) as totalQuantity
from Products p
join [Order Details] d
on p.ProductID= d.ProductID
group by p.ProductName

--5
create procedure sp_product_order_quantity_majumdar @ProductID int as
select p.ProductID, p.ProductName, sum(d.Quantity) as totalQuantity
from Products p
join [Order Details] d
on p.ProductID= d.ProductID
where p.ProductID=@ProductID
group by p.ProductID, p.ProductName
go
exec sp_product_order_quantity_majumdar @ProductID=1

--6
create proc sp_product_order_city_majumdar @product_name varchar(50)
as
select * from(
select p.productid, p.ProductName, c.city, sum(d.quantity) as TotalQty, rank() over(partition by p.productid order by sum(d.quantity) desc) rk 
from Customers c
join orders o 
on c.CustomerID= o.CustomerID
left join [Order Details] d on 
o.OrderID=d.OrderID
left join Products p 
on d.ProductID=p.ProductID
where @product_name=p.ProductName
group by p.ProductID, p.ProductName, c.City) cc
where cc.rk<=5

--7
create proc sp_move_employees_majumdar @terroityDescription varchar(50) = 'tory'
as
if exists
(select e.EmployeeID 
from Territories t
join employeeterritories et 
on t.TerritoryID=et.TerritoryID
join Employees e 
on et.EmployeeID=e.EmployeeID
where TerritoryDescription=@terroityDescription 
group by e.EmployeeID
having count(t.TerritoryDescription)>0 )
begin
insert into Territories(TerritoryID,TerritoryDescription,RegionID) values (98700,'Stevens Point',5)
insert into Region(RegionID,RegionDescription) values(5,'North')
end
go

--8
create trigger trigger_Majumdar on territories
for update as
if exists(select e.employeeid
from Territories t
join employeeterritories et 
on t.TerritoryID=et.TerritoryID
join Employees e 
on et.EmployeeID=e.EmployeeID
where t.TerritoryDescription= 'stevens point'
group by e.EmployeeID
having count(t.TerritoryDescription)>100)
begin
update Territories set TerritoryDescription= 'Tory' where TerritoryDescription='stevens point'
End

--9
create table people_majumdar (id int,p_name char(20),cityid int)
create table city_majumdar (cityid int,city char(20))
insert into people_majumdar(id,p_name,cityid) values(1,'Aaron Rodgers', 2)
insert into people_majumdar(id,p_name,cityid) values(2,'Russell Wilson', 1)
insert into people_majumdar(id,p_name,cityid) values(3,'Jody Nelson', 2)
insert into city_majumdar(cityid,city) values(1,'Settle')
insert into city_majumdar(cityid,city) values(2,'Green Bay')
update city_majumdar set city = 'Madison' where  cityid=1
create view packers_majumdar as
select p.p_name
from people_majumdar p 
join city_majumdar c 
on p.cityid=c.cityid 
where c.city='Green bay'
begin transaction
rollback
drop table people_majumdar
drop table city_majumdar
drop view packers_majumdar

--10
create proc sp_birthday_employees_majumdar as
begin
select Employeeid, LastName, FirstName, Title, TitleOfCourtesy,BirthDate,HireDate, Address, 
City, Region, PostalCode, Country, HomePhone, Photo, Notes, ReportsTo, PhotoPath  into birthday_employees_majumdar 
from Employees
where month(BirthDate)=2
end

drop table birthday_employees_majumdar

--11

create proc sp_majumdar_1 as
select c.city as City, count(c.CustomerID) as TotalCustomers
from Customers c
join (
select n.CustomerID, count(n.CustomerID) nn
from (select distinct c.CustomerID, p.ProductID 
from Products p
join [Order Details] od 
on p.ProductID=od.ProductID
join Orders o 
on od.OrderID=o.OrderID
join Customers c 
on o.CustomerID=c.CustomerID) n
group by n.CustomerID
having count(n.CustomerID)<2) nn
on c.CustomerID= nn.CustomerID
group by city
having count(c.CustomerID)>1

create proc sp_majumdar_2 as
select c.city, count(c.CustomerID) as TotalCustomers, count(d.ProductID)
from Customers c
join orders o
on c.CustomerID=o.CustomerID
join [Order Details] d
on o.OrderID=d.OrderID
group by city
having count(c.CustomerID)>=2 and count(d.ProductID)<1

--12
SELECT * FROM Table1
UNION
SELECT * FROM Table2
If records are greater than any of two tables, they do not have same data.

--14
select p.FirstName+' ' +p.LastName+' '+p.MiddleName '.' as "Full Name" from People p

--15
select max(Marks)
from table1
where Sex='F'

--16
select Student, Marks, Sex
from table1
group by Sex, Marks
order by Sex, Marks Desc
