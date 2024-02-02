-- SELECT
--     c.category_name,
--     p.product_name,
--     SUM(sf.quantity) AS TotalSales,
--     SUM(sf.list_price - (sf.list_price * sf.discount)) AS TotalRevenue
-- FROM
--     BikeSalesDWGroup3..salesFact sf
-- JOIN
--     BikeSalesDWGroup3..ProductDIM p ON sf.productKey = p.productKey
-- JOIN
--     BikeSalesDWGroup3..CategoryDIM c ON p.categoryKey = c.categoryKey
-- GROUP BY
--     c.category_name, p.product_name
-- ORDER BY
--     category_name DESC;

SELECT 
    product_id,
    product_name,
    category_name,
    total_sales
FROM (
    SELECT 
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(sf.list_price - sf.discount) AS total_sales,
        RANK() OVER (PARTITION BY c.category_id ORDER BY SUM(sf.list_price - sf.discount) DESC) AS sales_rank
    FROM 
        ProductDIM p
    JOIN 
        salesFact sf ON p.productKey = sf.productKey
    JOIN 
        CategoryDIM c ON p.categoryKey = c.categoryKey
    GROUP BY 
        p.product_id, p.product_name, c.category_name, c.category_id
) AS RankedProducts
WHERE 
    sales_rank = 1;


-- What is the top best-selling product in each category?

