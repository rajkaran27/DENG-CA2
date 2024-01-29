SELECT
    c.category_name,
    p.product_name,
    SUM(sf.quantity) AS TotalSales,
    SUM(sf.list_price - (sf.list_price * sf.discount)) AS TotalRevenue
FROM
    BikeSalesDWGroup3..salesFact sf
JOIN
    BikeSalesDWGroup3..ProductDIM p ON sf.productKey = p.productKey
JOIN
    BikeSalesDWGroup3..CategoryDIM c ON p.categoryKey = c.categoryKey
GROUP BY
    c.category_name, p.product_name
ORDER BY
    TotalRevenue DESC;
