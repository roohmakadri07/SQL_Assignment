USE Northwind
GO

-- PROCEDURE 01
CREATE PROCEDURE "AverageFreight_By_Customer"
@CustomerID	nchar(5),
@EmployeeID	int	,
@OrderDate	datetime,
@RequiredDate	datetime,
@ShippedDate	datetime,
@ShipVia	int	,
@Freight	money,
@ShipName	nvarchar(40),
@ShipAddress	nvarchar(60),
@ShipCity	nvarchar(15),
@ShipRegion	nvarchar(15),
@ShipPostalCode	nvarchar(10),
@ShipCountry	nvarchar(15),
@type nvarchar(6)

AS
BEGIN
	
	if(@type='insert')
		if(@Freight<(select AVG(O.Freight) from Orders O where O.CustomerID=@CustomerID))
			INSERT into Orders (CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry) 
				values (@CustomerID,
							@EmployeeID,
							@OrderDate,
							@RequiredDate,
							@ShippedDate,
							@ShipVia,
							@Freight,
							@ShipName,
							@ShipAddress,
							@ShipCity	,
							@ShipRegion	,
							@ShipPostalCode,
							@ShipCountry
					)
	
	else if(@type='update')
		if (@Freight<(select AVG(O.Freight) from Orders O where O.CustomerID=@CustomerID))
			update Orders 
				set Freight=@Freight where  CustomerID=@CustomerID and OrderDate=@OrderDate

	else
		print('invalid')
END

EXEC AverageFreight_By_Customer 'VINET',6,'1996-07-04 00:00:00.000',	'1996-08-01 00:00:00.000','1996-07-16 00:00:00.000',3,32.3800,'Vins et alcools Chevalier','59 rue de lAbbaye','Reims',NULL,51100,'France','insert'



-- PROCEDURE 02
CREATE PROCEDURE "EmpSales_By_Country" 
@countryName nvarchar(15)
AS
	SELECT e.FirstName, e.LastName, o.ShipCountry, COUNT(o.EmployeeID) AS [Total Sales By Employee]
	FROM Employees e
	JOIN Orders o
	ON e.EmployeeID = o.EmployeeID
	WHERE o.ShipCountry = @countryName
	GROUP BY e.FirstName, e.LastName, o.ShipCountry
GO

EXEC EmpSales_By_Country 'Austria'



-- PROCEDURE 03
CREATE PROCEDURE "Sales_By_Year"
@year int
AS
	SELECT YEAR(o.OrderDate) AS [Year], COUNT(o.OrderId) AS [Total Sales]
	FROM Orders o
	GROUP BY YEAR(o.OrderDate)
	HAVING YEAR(o.OrderDate) = @year
GO

EXEC Sales_By_Year '1996'



-- PROCEDURE 04
ALTER PROCEDURE "Sales_By_Category"
@categoryName nvarchar(15)
AS
	SELECT c.CategoryName, COUNT(c.CategoryName) AS [Total Sales]
	FROM Categories c
	JOIN Products p
	ON c.CategoryID = p.CategoryID
	JOIN [Order Details] od
	ON p.ProductID = od.ProductID
	GROUP BY c.CategoryName
	HAVING c.CategoryName = @categoryName
GO

EXEC Sales_By_Category 'Dairy Products'



-- PROCEDURE 05
CREATE PROCEDURE "Ten_Expensive_Products"
AS
	SELECT TOP 10 p.ProductID, p.ProductName, p.UnitPrice
	FROM Products p
	ORDER BY p.UnitPrice DESC
GO

EXEC Ten_Expensive_Products



-- PROCEDURE 06
CREATE PROCEDURE "New_Customer_OrderDetails"
@orderID int,
@productID int,
@unitPrice money,
@qty smallint,
@discount real
AS
	INSERT INTO [Order Details] VALUES
	(@orderID, @productID, @unitPrice, @qty, @discount)
GO

EXEC New_Customer_OrderDetails '10265','10','99.99','99','0.12'

SELECT * FROM [Order Details] WHERE OrderID = '10265' AND ProductID = '10'


-- PROCEDURE 07
CREATE PROCEDURE "Update_Customer_OrderDetails"
@orderID int,
@productID int,
@unitPrice money,
@qty smallint,
@discount real
AS
	UPDATE [Order Details] SET
	UnitPrice = @unitPrice,Quantity = @qty, Discount = @discount
	WHERE OrderID = @orderID AND ProductID = @productID
GO

EXEC Update_Customer_OrderDetails '10265','10','89.99','9','0.22'
SELECT * FROM [Order Details] WHERE OrderID = '10265' AND ProductID = '10'