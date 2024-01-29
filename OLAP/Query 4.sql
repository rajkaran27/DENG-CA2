SELECT
    c.first_name + ' ' + c.last_name AS CustomerName,
    COUNT(DISTINCT sf.orderKey) AS TotalOrders,
    SUM(sf.quantity) AS TotalUnits,
    SUM(sf.list_price - (sf.list_price * sf.discount)) AS TotalRevenue
FROM
    BikeSalesDWGroup3..salesFact sf
JOIN
    BikeSalesDWGroup3..CustomerDIM c ON sf.customerKey = c.customerKey
GROUP BY
    c.first_name, c.last_name
ORDER BY
    TotalRevenue DESC;