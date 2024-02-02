WITH StaffStorePerformance AS (
    SELECT
        t.[Year] AS SalesYear,
        t.[MonthName] AS SalesMonth,
        s.store_name,
        s.store_id,
        st.staff_id,
        st.first_name,
        st.last_name,
        SUM(sf.quantity) AS TotalBikesSold,
        CEILING(SUM(sf.list_price * sf.quantity)) AS TotalRevenue
    FROM
        salesFact sf
        JOIN TimeDim t ON sf.timeKey = t.timeKey
        JOIN StoreDIM s ON sf.storeKey = s.storeKey
        JOIN StaffDIM st ON sf.staffKey = st.staffKey
    GROUP BY
        t.[Year],
        t.[MonthName],
        s.store_name,
        s.store_id,
        st.staff_id,
        st.first_name,
        st.last_name
)
SELECT
    SalesYear,
    SalesMonth,
    store_name,
    store_id,
    staff_id,
    first_name,
    last_name,
    TotalBikesSold,
    TotalRevenue
FROM
    StaffStorePerformance
ORDER BY
    SalesYear,
    CASE
        WHEN SalesMonth = 'January' THEN 1
        WHEN SalesMonth = 'February' THEN 2
        WHEN SalesMonth = 'March' THEN 3
        WHEN SalesMonth = 'April' THEN 4
        WHEN SalesMonth = 'May' THEN 5
        WHEN SalesMonth = 'June' THEN 6
        WHEN SalesMonth = 'July' THEN 7
        WHEN SalesMonth = 'August' THEN 8
        WHEN SalesMonth = 'September' THEN 9
        WHEN SalesMonth = 'October' THEN 10
        WHEN SalesMonth = 'November' THEN 11
        WHEN SalesMonth = 'December' THEN 12
        ELSE 99
    END,
    store_name,
    staff_id;