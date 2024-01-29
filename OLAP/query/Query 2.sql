SELECT
    s.store_name,
    st.first_name + ' ' + st.last_name AS StaffName,
    COUNT(sf.orderKey) AS TotalOrders,
    SUM(sf.quantity) AS TotalSales
FROM
    BikeSalesDWGroup3..salesFact sf
JOIN
    BikeSalesDWGroup3..StoreDIM s ON sf.storeKey = s.storeKey
JOIN
    BikeSalesDWGroup3..StaffDIM st ON sf.staffKey = st.staffKey
GROUP BY
    s.store_name, st.first_name, st.last_name
ORDER BY
    TotalSales DESC;
