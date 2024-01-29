SELECT
    p.product_name,
    c.category_name,
    SUM(sf.quantity) AS TotalSales,
    SUM(p.stock_quantity) AS TotalInventory
FROM
    BikeSalesDWGroup3..salesFact sf
JOIN
    BikeSalesDWGroup3..ProductDIM p ON sf.productKey = p.productKey
JOIN
    BikeSalesDWGroup3..CategoryDIM c ON p.categoryKey = c.categoryKey
GROUP BY
    p.product_name, c.category_name
ORDER BY
    TotalSales DESC;
