INSERT INTO BikeSalesDWGroup3..CustomerDIM (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
SELECT customer_id, first_name, last_name, phone, email, street, city, state, zip_code
FROM sales.customers;

INSERT INTO BikeSalesDWGroup3..StaffDIM (staff_id, first_name, last_name, email, phone, active, manager_id)
SELECT staff_id, first_name, last_name, email, phone, active, manager_id
FROM sales.staffs;