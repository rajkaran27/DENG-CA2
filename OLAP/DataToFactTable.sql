use NorthwindDW

DELETE FROM SalesFacts

INSERT INTO NorthwindDW..SalesFacts
(
  TimeKey,ShipperKey, CustomerKey,EmployeeKey,
  ProductKey,RegionKey, UnitPrice, Quantity, Discount)
    
SELECT
 replace(CONVERT(DATE,o.OrderDate, 112),'-',''),
 s.ShipperKey,
 c.CustomerKey,
 e.EmployeeKey,
 p.ProductKey, 
 r.RegionID,
 od.UnitPrice,
 od.Quantity,
 od.Discount

FROM 
Northwind..[Order Details] od INNER JOIN Northwind..[Orders] o ON od.OrderID = o.OrderID
INNER JOIN NorthwindDW..[ShippersDIM] s ON o.ShipVia = s.ShipperKey
INNER JOIN NorthwindDW..[CustomerDIM] c ON o.CustomerID = c.CustomerKey
INNER JOIN NorthwindDW..[EmployeeDIM] e ON o.EmployeeID = e.EmployeeKey
INNER JOIN NorthwindDW..[ProductDIM] p  ON od.ProductID = p.ProductKey
INNER JOIN
	(select [EmployeeID], [RegionID]
		from Northwind..[EmployeeTerritories] et
			 inner join Northwind..[Territories] t on et.TerritoryID=t.TerritoryID
		group by [EmployeeID],[RegionID]) r
	on o.EmployeeID=r.EmployeeID



