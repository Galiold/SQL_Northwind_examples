USE Northwind;

-- supplier average
declare @x float;
set @x = (select avg(total_price)
from
(select Sup.CompanyName,SUM (OrD.UnitPrice * OrD.Quantity)
from [Suppliers] Sup, [Products] Prod, [Order Details] OrD
where Sup.SupplierID = Prod.SupplierID and OrD.ProductID = Prod.ProductID
group by Sup.CompanyName) as result(CompanyName, total_price));
PRINT @x;

-- customer average
declare @y float;
set @y = (select avg(total_price)
from
(select Customers.ContactName,SUM (UnitPrice * Quantity)
from Customers,Orders,[Order Details]
where Customers.CustomerID=Orders.CustomerID and Orders.OrderID=[Order Details].OrderID
group by Customers.ContactName) as result(cust_name,total_price));
PRINT @y;

IF @x < @y
    SELECT customer_list.NUM, supplier_list.CompanyName, supplier_list.total_price, customer_list.ContactName, customer_list.total_price FROM

    (select TOP 5 ROW_NUMBER() OVER(ORDER BY SUM (UnitPrice * Quantity)) AS NUM, Customers.ContactName, SUM (UnitPrice * Quantity) AS total_price
    from Customers,Orders,[Order Details]
    where Customers.CustomerID=Orders.CustomerID and Orders.OrderID=[Order Details].OrderID
    group by Customers.ContactName) AS customer_list,

    (select top 5 ROW_NUMBER() OVER(ORDER BY  SUM (OrD.UnitPrice * OrD.Quantity)) AS NUM , Sup.CompanyName, SUM (OrD.UnitPrice * OrD.Quantity) AS total_price
    from [Suppliers] Sup, [Products] Prod, [Order Details] OrD
    where Sup.SupplierID = Prod.SupplierID and OrD.ProductID = Prod.ProductID
    group by Sup.CompanyName) AS supplier_list

    WHERE customer_list.NUM = supplier_list.NUM;

    -- SELECT TOP 5 Customers.CompanyName, ROW_NUMBER() OVER(ORDER BY Customers.CompanyName) AS TEST FROM Customers;
ELSE
    SELECT customer_list.NUM, supplier_list.CompanyName, supplier_list.total_price, customer_list.ContactName, customer_list.total_price FROM

    (select TOP 5 ROW_NUMBER() OVER(ORDER BY SUM (UnitPrice * Quantity) DESC) AS NUM, Customers.ContactName, SUM (UnitPrice * Quantity) AS total_price
    from Customers,Orders,[Order Details]
    where Customers.CustomerID=Orders.CustomerID and Orders.OrderID=[Order Details].OrderID
    group by Customers.ContactName) AS customer_list,

    (select top 5 ROW_NUMBER() OVER(ORDER BY SUM (OrD.UnitPrice * OrD.Quantity) DESC) AS NUM , Sup.CompanyName, SUM (OrD.UnitPrice * OrD.Quantity) AS total_price
    from [Suppliers] Sup, [Products] Prod, [Order Details] OrD
    where Sup.SupplierID = Prod.SupplierID and OrD.ProductID = Prod.ProductID
    group by Sup.CompanyName) AS supplier_list

    WHERE customer_list.NUM = supplier_list.NUM;
