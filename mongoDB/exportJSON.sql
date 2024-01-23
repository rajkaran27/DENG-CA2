unsold
select p.product_id,p.product_name,b.brand_name,c.category_name,p.model_year,p.list_price from production.products p join production.brands b on p.brand_id=b.brand_id join production.categories c on c.category_id=p.category_id join production.stocks s on s.product_id=p.product_id where s.quantity!=0  for JSON path

zerostock
select p.product_id,p.product_name,b.brand_name,c.category_name,p.model_year,p.list_price,s.quantity from production.products p join production.brands b on p.brand_id=b.brand_id join production.categories c on c.category_id=p.category_id join production.stocks s on s.product_id=p.product_id where s.quantity=0 for JSON path

stocks
select p.product_id,s.store_id,s.quantity from production.products p join production.stocks s on s.product_id=p.product_id for JSON path