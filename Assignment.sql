create database Techdome
use Techdome
create table Products(ProductId int primary key, ProductName varchar(20), UnitPrice float)

create table Customers (CustomerId int primary key, FirstName varchar (20), LastName varchar(20), Email varchar(20))

create table Orders(OrderId int primary key, CustomerId int foreign key references Customers(CustomerId),Orderdate date,TotalAmount float)

create table OrderDetails (OrderDetailId int Primary key, OrderId int foreign key references Orders(OrderId),ProductId int,Quantity int)

--select * from sys.tables

--1 Retrieve a list of customers who have made at least 
one purchase,along with their total spending.

select sum(TotalAmount) as TotalSpending,C.CustomerId,C.FirstName
from Customers C
join Orders O
on C.CustomerId= O.CustomerId
group by C.FirstName,C.CustomerId
having Sum(TotalAmount) >0


--2 Calculate the total revenue generated from sales in the year 2022.
SELECT SUM(TotalAmount) as TotalRevenue
FROM Orders
WHERE YEAR(Orderdate) = 2022;


--3 identify the top 5 products by revenue in descending order.
select top 5 P.ProductId,Sum(P.UnitPrice*OD.Quantity) as Revenue
from Products P
join OrderDetails OD
on p.ProductId = OD.ProductId
join OrderDetails O
on OD.OrderId = O.OrderId
group by P.ProductId
order by Sum(P.UnitPrice*OD.Quantity) desc


--4 Find the customer with the highest total spending  and list their detail
select * from Customers join (select top 1 O.CustomerId,sum(TotalAmount) as TotalSpending
from Orders O
group by CustomerId order by TotalSpending desc) As MaxSpending
on Customers.CustomerId = MaxSpending.CustomerId

--6 Calculate the total number of of products sold for each product category.

select productId,sum(Quantity) as TotalSold 
from OrderDetails
group by ProductId 


--7 Identify the product with the highest quantity sold in each product category.

select productId,Max(Quantity) as HighestSold
from OrderDetails
group by ProductId



