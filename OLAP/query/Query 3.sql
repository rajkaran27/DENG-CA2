WITH ProductPerformance AS (
    SELECT
        p.product_name AS ProductName,
        CEILING(p.stock_quantity) AS CurrentStock,
        CEILING(COUNT(DISTINCT sf.orderKey)) AS TotalOrders,
        CEILING(SUM(sf.list_price * sf.quantity)) AS TotalSales,
        CEILING(AVG(sf.discount * sf.list_price)) AS AverageDiscount,
        CEILING(AVG(sf.list_price * sf.quantity * (1 - sf.discount))) AS AvgRevenueAftDiscount
    FROM
        salesFact sf
    JOIN
        ProductDIM p ON sf.productKey = p.productKey
    GROUP BY
        p.product_name, p.stock_quantity
)

SELECT
    pp.ProductName,
    pp.CurrentStock,
    pp.TotalOrders,
    pp.TotalSales,
    pp.AverageDiscount,
    pp.AvgRevenueAftDiscount,
    CASE
        WHEN pp.AvgRevenueAftDiscount > 1000 THEN 'Very Profitable'
        WHEN pp.AvgRevenueAftDiscount > 500 THEN 'Moderately Profitable'
        ELSE 'Less Profitable'
    END AS ProfitabilityLevel
FROM
    ProductPerformance pp
ORDER BY
    pp.TotalSales DESC;
