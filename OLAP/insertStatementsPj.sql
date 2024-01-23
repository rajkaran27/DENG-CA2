INSERT INTO BikeSalesDWGroup3..OrderStatusDIM (orderStatus_id, order_status)
SELECT order_status
FROM sales.orders;