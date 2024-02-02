-- SELECT
--     c.first_name + ' ' + c.last_name AS CustomerName,
--     COUNT(DISTINCT sf.orderKey) AS TotalOrders,
--     SUM(sf.quantity) AS TotalUnits,
--     SUM(sf.list_price - (sf.list_price * sf.discount)) AS TotalRevenue
-- FROM
--     BikeSalesDWGroup3..salesFact sf
-- JOIN
--     BikeSalesDWGroup3..CustomerDIM c ON sf.customerKey = c.customerKey
-- GROUP BY
--     c.first_name, c.last_name
-- ORDER BY
--     TotalRevenue DESC;

SELECT TOP 10
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(sf.list_price - sf.discount) AS total_sales,
    AVG(sf.list_price - sf.discount) AS avg_order_value
FROM 
    CustomerDIM c
JOIN 
    salesFact sf ON c.customerKey = sf.customerKey
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_sales DESC;


-- Who are the top 10 customers in terms of total sales?
-- What is the average order value for each customer?