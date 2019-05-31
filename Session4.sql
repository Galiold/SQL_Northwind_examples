-- Use Northwind;


-- Question 1
-- select result.sup_name, result.ship_co_name, Sum(result.Quantity * result.price) from 
-- (SELECT Suppliers.CompanyName, Shippers.CompanyName, [Order Details].Quantity, [Order Details].UnitPrice
-- from Orders, Shippers, [Order Details], Products, Suppliers
-- where Suppliers.SupplierID = Products.SupplierID AND [Order Details].ProductID = Products.ProductID AND Orders.OrderID = [Order Details].[OrderID] AND Orders.ShipVia = Shippers.ShipperID) AS result(sup_name, ship_co_name, Quantity, price)
-- GROUP BY result.sup_name, result.ship_co_name


-- Question 2
-- select Shippers.CompanyName,SUM(UnitPrice*Quantity)
-- from Shippers,Orders,[Order Details]
-- where [Order Details].OrderID=Orders.OrderID and Shippers.ShipperID=Orders.ShipVia
-- group by Shippers.CompanyName;


-- QUESTION 3
-- declare @a float;
-- set @a = (select avg(total_price)
-- from
-- (select Customers.ContactName,SUM(UnitPrice*Quantity)
-- from Customers,Orders,[Order Details]
-- where Customers.CustomerID=Orders.CustomerID and Orders.OrderID=[Order Details].OrderID
-- group by Customers.ContactName) as result(cust_name,total_price));

-- select cust_name,total_price,
-- case
-- 	when total_price<@a then 'low'
-- 	when total_price>=@a then 'high'
-- end as Kind
-- from
-- (select Customers.ContactName,SUM(UnitPrice*Quantity)
-- from Customers,Orders,[Order Details]
-- where Customers.CustomerID=Orders.CustomerID and Orders.OrderID=[Order Details].OrderID
-- group by Customers.ContactName) as result(cust_name,total_price);
