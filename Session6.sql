USE Northwind

declare @totalPrice int
set @totalPrice = 0;

declare @totalPriceSum int
set @totalPriceSum = 0;

declare @maxTotalPrice int
set @maxTotalPrice = 0;

declare @supCharHolder varchar(10);
set @supCharHolder = 'A';

declare @custCharHolder varchar(10);
set @custCharHolder = 'A';

while ASCII(@supCharHolder) < 91
begin
	set @custCharHolder = 65
	set @totalPrice = 0;
	while ASCII(@custCharHolder) < 91
	begin
		set @totalPrice = (select sum(c3) 
		from (select Suppliers.CompanyName,Customers.CompanyName,sum([Order Details].Quantity*[Order Details].UnitPrice) from Orders,[Order Details],Suppliers,Customers,Products
		where Orders.CustomerID=Customers.CustomerID and Orders.OrderID=[Order Details].OrderID
		and Suppliers.CompanyName like @supCharHolder+'%' and Customers.CompanyName like @custCharHolder+'%'
		and [Order Details].ProductID=Products.ProductID and Products.SupplierID= Suppliers.SupplierID
		group by Suppliers.CompanyName,Customers.CompanyName) as test (c1,c2,c3)
		)
		
		if @maxTotalPrice < @totalPrice 
			set @maxTotalPrice = @totalPrice

		if @totalPrice IS NOT Null
			set @totalPriceSum = @totalPriceSum + @totalPrice
		set @custCharHolder = char(ASCII(@custCharHolder)+1);
	end

	set @supCharHolder = char(ASCII(@supCharHolder)+1);
end


set @supCharHolder = 65
set @custCharHolder = 65

declare @printer varchar(100)

while ASCII(@supCharHolder)<91
begin
set @custCharHolder = 65
	set @totalPrice = 0;
	while ASCII(@custCharHolder)<91
	begin
		set @totalPrice = 0;
		set @totalPrice = (select sum(c3) 
		from (select Suppliers.CompanyName,Customers.CompanyName,sum([Order Details].Quantity*[Order Details].UnitPrice) from Orders,[Order Details],Suppliers,Customers,Products
		where Orders.CustomerID=Customers.CustomerID and Orders.OrderID=[Order Details].OrderID
		and Suppliers.CompanyName like @supCharHolder+'%' and Customers.CompanyName like @custCharHolder+'%'
		and [Order Details].ProductID=Products.ProductID and Products.SupplierID= Suppliers.SupplierID
		group by Suppliers.CompanyName,Customers.CompanyName) as test (c1,c2,c3)
		)
		
		if @totalPrice > 0 
		begin
		set @printer = @supCharHolder + ' - ' + @custCharHolder + ' - ' + cast(@totalPrice as char) + ' - '
		declare @i int
		declare @count int
		set @count = 50 * @totalPrice / @maxTotalPrice
		set @i =0 
		while (@i < @count)
		begin
			set @printer = @printer + '*'
			set @i = @i + 1
		end

		
		print @printer
		end
		set @custCharHolder = char(ASCII(@custCharHolder)+1);
		
	end
	
	
	set @supCharHolder = char(ASCII(@supCharHolder)+1);
end


