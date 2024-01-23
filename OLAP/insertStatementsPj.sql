INSERT INTO BikeSalesDWGroup3..OrderDIM (order_id, order_status, order_date, required_date, shipped_date)
SELECT order_id, order_status, order_date, required_date, shipped_date
FROM sales.orders;