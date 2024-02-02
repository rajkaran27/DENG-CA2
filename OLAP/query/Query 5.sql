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
    category,
    product,
    total_quantity_sold,
    total_sales_amount
FROM (
    SELECT 
        c.category_name AS category,
        p.product_name AS product,
        SUM(sf.quantity) AS total_quantity_sold,
        SUM(sf.list_price - sf.discount) AS total_sales_amount,
        ROW_NUMBER() OVER (PARTITION BY c.category_name ORDER BY SUM(sf.list_price) DESC) AS product_rank
    FROM
        salesFact sf
    JOIN
        ProductDIM p ON sf.productKey = p.productKey
    JOIN
        CategoryDIM c ON p.categoryKey = c.categoryKey
    GROUP BY
        c.category_name, p.product_name
) AS RankedProducts
WHERE
    product_rank <= 3
ORDER BY
    category, product_rank;



-- What is the top best-selling product in each category?

-- What are the top 3 products based on total sales amount within each category?
-- Query Result:

-- The result will display the top 3 products in each category along with their total quantity sold and total sales amount. This information can help the owner focus on the most profitable products in each category.
-- Insights:

-- Identify top-performing products: The owner can quickly identify the top 3 products in terms of sales amount within each category.
-- Category-specific insights: Understand the most successful products within each category for targeted marketing or inventory optimization.
-- Competitive analysis: Compare the performance of products across categories to make informed business decisions.
