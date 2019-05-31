-- USE Northwind

-- Question 1
-- SELECT CompanyName, sum(Quantity*[Order Details].UnitPrice)
-- from Suppliers, Products, [Order Details]
-- WHERE Suppliers.SupplierID = Products.SupplierID AND Products.ProductID = [Order Details].ProductID
-- group by Suppliers.CompanyName


-- Question 2
-- SELECT Customers.ContactName, sum(Quantity*[Order Details].UnitPrice)
-- from Customers, [Order Details], Orders
-- WHERE Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = [Order Details].OrderID
-- GROUP BY Customers.ContactName


-- Question 3
-- SELECT year(Orders.OrderDate), Suppliers.CompanyName, count(Orders.OrderID) 
-- from Products, Suppliers, Orders, [Order Details]
-- where Suppliers.SupplierID = Products.SupplierID And [Order Details].ProductID = Products.ProductID And [Order Details].OrderID = Orders.OrderID
-- GROUP BY  year(Orders.OrderDate), Suppliers.CompanyName


-- Question 4
-- select Customers.ContactName, Suppliers.CompanyName, sum(Quantity*[Order Details].UnitPrice)
-- from Products, Suppliers, Orders, [Order Details], Customers
-- WHERE Products.SupplierID = Suppliers.SupplierID AND orders.OrderID = [Order Details].OrderID and Products.ProductID = [Order Details].ProductID AND Orders.CustomerID = Customers.CustomerID
-- GROUP BY Customers.ContactName, Suppliers.CompanyName


-- Question 5
-- SELECT sums1.ContactName, sums1.totalprice, (sums1.totalprice - average.test) as dist
-- from 
-- (SELECT Customers.ContactName, sum(Quantity*[Order Details].UnitPrice)
-- from Customers, [Order Details], Orders
-- WHERE Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = [Order Details].OrderID
-- GROUP BY Customers.ContactName) AS sums1(ContactName, totalprice),
-- (select avg(sums.totalprice)
-- from
-- (SELECT Customers.ContactName, sum(Quantity*[Order Details].UnitPrice)
-- from Customers, [Order Details], Orders
-- WHERE Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = [Order Details].OrderID
-- GROUP BY Customers.ContactName) AS sums(ContactName, totalprice)) as average(test)

