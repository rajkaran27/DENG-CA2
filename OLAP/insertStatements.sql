-- Load data from sales.stores (OLTP) to sales.StoreDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..StoreDIM (store_id, store_name, phone, email, street, city, state, zip_code)
SELECT store_id, store_name, phone, email, street, city, state, zip_code
FROM sales.stores;

-- Load data from sales.staffs (OLTP) to BikeSalesDWGroup3.StaffDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..StaffDIM (staff_id, first_name, last_name, email, phone, active, manager_id)
SELECT staff_id, first_name, last_name, email, phone, active, manager_id
FROM sales.staffs;

-- Load data from production.categories (OLTP) to BikeSalesDWGroup3.CategoryDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..CategoryDIM (category_id, category_name)
SELECT category_id, category_name
FROM production.categories;

-- Load data from production.brands (OLTP) to BikeSalesDWGroup3.BrandDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..BrandDIM (brand_id, brand_name)
SELECT brand_id, brand_name
FROM production.brands;

-- Load data from sales.customers (OLTP) to BikeSalesDWGroup3.CustomerDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..CustomerDIM (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
SELECT customer_id, first_name, last_name, phone, email, street, city, state, zip_code
FROM sales.customers;

INSERT INTO BikeSalesDWGroup3..ProductDIM (product_id, categoryKey, brandKey, product_name, model_year, list_price, stock_quantity, stock_date)
SELECT p.product_id, c.categoryKey, b.brandKey, p.product_name, p.model_year, p.list_price, ISNULL(s.total_quantity, 0) AS stock_quantity, GETDATE() AS stock_date
FROM production.products p
JOIN BikeSalesDWGroup3..CategoryDIM c ON p.category_id = c.category_id
JOIN BikeSalesDWGroup3..BrandDIM b ON p.brand_id = b.brand_id
LEFT JOIN (SELECT product_id, SUM(quantity) AS total_quantity FROM production.stocks GROUP BY product_id) s ON p.product_id = s.product_id

-- still editing 
-- Load data from sales.orders (OLTP) to BikeSalesDWGroup3.BrandDIM (OLAP)


-- Dont run these codes
-- need fix
-- Load data from production.products (OLTP) to BikeSalesDWGroup3.ProductDIM (OLAP)


-- Load data from sales.orders (OLTP) to BikeSalesDWGroup3.OrderDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..OrderDIM (order_id, order_date, required_date, shipped_date, orderStatusKey)
SELECT order_id, order_date, required_date, shipped_date, order_status
FROM sales.orders;

-- Load data from sales.order_items (OLTP) to BikeSalesDWGroup3.salesFact (OLAP)
INSERT INTO BikeSalesDWGroup3..salesFact (timeKey, orderKey, customerKey, storeKey, staffKey, productKey, quantity, list_price, discount)
SELECT t.timeKey, o.orderKey, c.customerKey, s.storeKey, st.staffKey, p.productKey, oi.quantity, oi.list_price, oi.discount
FROM sales.order_items oi
JOIN BikeSalesDWGroup3..OrderDIM o ON oi.order_id = o.order_id
JOIN BikeSalesDWGroup3..CustomerDIM c ON o.customer_id = c.customer_id
JOIN BikeSalesDWGroup3..StoreDIM s ON o.store_id = s.store_id
JOIN BikeSalesDWGroup3..StaffDIM st ON o.staff_id = st.staff_id
JOIN BikeSalesDWGroup3..ProductDIM p ON oi.product_id = p.product_id
JOIN BikeSalesDWGroup3..TimeDim t ON o.order_date = t.Date;

-- Load data from production.stocks (OLTP) to BikeSalesDWGroup3.salesFact (OLAP)
INSERT INTO BikeSalesDWGroup3..salesFact (timeKey, storeKey, productKey, quantity, list_price, discount)
SELECT t.timeKey, s.storeKey, p.productKey, s.quantity, 0 AS list_price, 0 AS discount
FROM production.stocks s
JOIN BikeSalesDWGroup3..StoreDIM st ON s.store_id = st.store_id
JOIN BikeSalesDWGroup3..ProductDIM p ON s.product_id = p.product_id
JOIN BikeSalesDWGroup3..TimeDim t ON GETDATE() = t.Date; -- Assuming current date for stock data

-- Note: Adjust the column names and types according to your actual table structures
