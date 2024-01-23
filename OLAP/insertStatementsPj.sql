INSERT INTO BikeSalesDWGroup3..OrderStatusDIM (order_status)
SELECT order_status
FROM sales.orders;

INSERT INTO BikeSalesDWGroup3..OrderDIM (order_id, orderStatusKey, order_date, required_date, shipped_date)
SELECT s.order_id, o.orderStatusKey, s.order_date, s.required_date, s.shipped_date
FROM sales.orders s
JOIN BikeSalesDWGroup3..OrderStatusDIM o ON s.orderStatusKey = o.orderStatusKey;