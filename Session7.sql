
-- Create Procedure findTotalPrice(
-- 	@cust_name varchar(50),
-- 	@total_price int OUTPUT
-- ) AS
-- Begin
-- 	select @total_price = TotalPrices.Sum
-- 	from(
-- 	select Customers.CompanyName, SUM(Quantity*UnitPrice) as Sum
-- 	from Customers, Orders, [Order Details]
-- 	where Customers.CustomerID = Orders.CustomerID and [Order Details].OrderID = Orders.OrderID
-- 	and @cust_name = Customers.CompanyName
-- 	group by Customers.CompanyName)as TotalPrices(cust_name, Sum)
-- End;

declare @name varchar(50)

declare @outTotal int
set @outTotal = 0

declare @sumTotal int
set @sumTotal = 0

declare @printer varchar(100)

declare db_cursor CURSOR FOR
	select Customers.CompanyName 
	from Customers, Orders, [Order Details]
	where Customers.CustomerID = Orders.CustomerID and [Order Details].OrderID = Orders.OrderID
	group by Customers.CompanyName

Open db_cursor

FETCH NEXT FROM db_cursor INTO @name

while @@FETCH_STATUS = 0
Begin
	exec findTotalPrice 
		@cust_name = @name,
		@total_price = @outTotal output;

	print 'Cust_Name		Totatl_Price'

	set @printer = @name + '		' + CAST(@outTotal as char)
	print @printer
	
	set @sumTotal = @sumTotal + @outTotal
	
	FETCH NEXT FROM db_cursor INTO @name
End

set @printer = 'Sum is ' + CAST(@sumTotal as char)
print @printer

close db_cursor