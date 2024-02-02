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

SELECT TOP 20
    c.customer_id,
    c.first_name,
    c.last_name,
	COUNT(DISTINCT sf.orderKey) AS 'Number of Orders',
	COUNT(sf.productKey) AS 'Number of Products purchased',
    SUM(sf.list_price - sf.discount) AS total_sales,
    SUM(sf.list_price - sf.discount) / COUNT(DISTINCT sf.orderKey) AS 'Average Order Value',
	MAX(sf.list_price - sf.discount) AS 'Most Expensive Order Purchased'
FROM 
    CustomerDIM c
JOIN 
    salesFact sf ON c.customerKey = sf.customerKey
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_sales DESC;


-- Who are the top 20 customers in terms of total sales? It helps identify high-value customers and their contribution to overall sales.
-- What is the average order value for each customer?