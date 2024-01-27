INSERT INTO BikeSalesDWGroup3..ProductDIM (product_id, categoryKey, brandKey, product_name, model_year, list_price, stock_quantity, stock_date)
SELECT p.product_id, c.categoryKey, b.brandKey, p.product_name, p.model_year, p.list_price, ISNULL(s.total_quantity, 0) AS stock_quantity, GETDATE() AS stock_date
FROM production.products p
JOIN BikeSalesDWGroup3..CategoryDIM c ON p.category_id = c.category_id
JOIN BikeSalesDWGroup3..BrandDIM b ON p.brand_id = b.brand_id
LEFT JOIN (SELECT product_id, SUM(quantity) AS total_quantity FROM production.stocks GROUP BY product_id) s ON p.product_id = s.product_id
