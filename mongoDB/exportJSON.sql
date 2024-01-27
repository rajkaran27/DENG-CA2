unsold
SELECT p.product_id, p.product_name, b.brand_name,c.category_name,p.model_year,p.list_price FROM production.products p JOIN production.brands b ON p.brand_id = b.brand_id JOIN production.categories c ON c.category_id = p.category_id LEFT JOIN sales.order_items s ON s.product_id = p.product_id WHERE s.product_id IS NULL for JSON path

zerostock
SELECT p.product_id, p.product_name, b.brand_name,   c.category_name,   p.model_year,  p.list_price, COALESCE(s.quantity, 0) AS quantity FROM production.products p JOIN production.brands b ON p.brand_id = b.brand_id JOIN production.categories c ON c.category_id = p.category_id LEFT JOIN production.stocks s ON s.product_id = p.product_id WHERE COALESCE(s.quantity, 0) = 0 for JSON path

stocks
select p.product_id,s.store_id,s.quantity from production.products p join production.stocks s on s.product_id=p.product_id for JSON path