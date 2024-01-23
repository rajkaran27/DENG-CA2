INSERT INTO BikeSalesDWGroup3..CustomerDIM (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
SELECT customer_id, first_name, last_name, phone, email, street, city, state, zip_code
FROM sales.customers;
