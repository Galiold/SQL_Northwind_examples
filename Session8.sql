-- ALTER FUNCTION findMaxOrderID (@year INT)
-- RETURNS INT
-- AS BEGIN
--     DECLARE @maxOrder INT
--     SET @maxOrder = 0
--     SET @maxOrder = (SELECT TOP 1 [Order Details].OrderID
--                             FROM [Order Details], Orders WHERE [Order Details].[OrderID] = Orders.OrderID 
--                                 AND YEAR(Orders.OrderDate) = @year
--                                 GROUP BY [Order Details].OrderID ORDER BY SUM([Order Details].Quantity * [Order Details].UnitPrice) DESC)

    -- DECLARE @maxOrderID INT
    -- SET @maxOrderID = (SELECT
    --                             [Order Details].OrderID
    --                         FROM
    --                             [Order Details], Orders
    --                         WHERE
    --                             [Order Details].[OrderID] = Orders.OrderID AND YEAR(Orders.OrderDate) = @year
    --                         GROUP BY [Order Details].OrderID
    --                         HAVING 
    --                             (SUM([Order Details].Quantity * [Order Details].UnitPrice) = @maxOrder))
--     RETURN @maxOrder
-- END


-- alter function findBestSupName(@orderID int)
-- returns varchar(30)
-- as begin
-- 	declare @supMax VARCHAR(30)
-- 	set @supMax= (Select TOP 1 Suppliers.CompanyName
-- 	from [Order Details],Products,Suppliers
-- 	where [Order Details].OrderID=@orderID
-- 	and Products.ProductID = [Order Details].ProductID
-- 	and Suppliers.SupplierID = Products.SupplierID
-- 	group by Suppliers.CompanyName ORDER BY (sum([Order Details].UnitPrice*Quantity)) DESC) 

-- -- 	declare @supName varchar(30)
-- -- 	set @supName =''
-- -- 	set @supName= (select Suppliers.CompanyName
-- -- 	from [Order Details],Products,Suppliers
-- -- 	where [Order Details].OrderID=@orderID
-- -- 	and Products.ProductID = [Order Details].ProductID
-- -- 	and Suppliers.SupplierID = Products.SupplierID
-- 	group by Suppliers.CompanyName
-- 	having (sum([Order Details].UnitPrice*Quantity) = @supMax))

-- 	return @supMAX
-- end



select DISTINCT year(Orders.OrderDate) AS Year,Orders.OrderID, Suppliers.CompanyName ,Customers.CompanyName 
from [Order Details],Orders,Products,Customers,Suppliers
WHERE [Order Details].OrderID = Orders.OrderID 
AND Orders.OrderID = dbo.findMaxOrderID(year(Orders.OrderDate))
AND Products.ProductID = [Order Details].ProductID
AND Products.SupplierID = Suppliers.SupplierID
AND Orders.CustomerID = Customers.CustomerID
AND Suppliers.CompanyName = dbo.findBestSupName(Orders.OrderID)

