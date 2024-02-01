SELECT
    s.store_name,
    st.first_name + ' ' + st.last_name AS StaffName,
    COUNT(sf.orderKey) AS TotalOrders,
    SUM(sf.quantity) AS TotalSales
FROM
    BikeSalesDWGroup3..salesFact sf
    JOIN BikeSalesDWGroup3..StoreDIM s ON sf.storeKey = s.storeKey
    JOIN BikeSalesDWGroup3..StaffDIM st ON sf.staffKey = st.staffKey
GROUP BY
    s.store_name,
    st.first_name,
    st.last_name
ORDER BY
    TotalSales DESC;

--raj
SELECT
    st.first_name + ' ' + st.last_name AS StaffName,
    s.store_name,
    ROUND(
        SUM(
            sf.list_price - (sf.list_price * sf.discount / 100)
        ),
        2
    ) AS total_sales,
    COUNT(sf.orderKey) AS TotalOrders,
    SUM(sf.quantity) AS TotalSales
FROM
    salesFact sf
    JOIN StaffDIM st ON sf.staffKey = st.staffKey
    JOIN StoreDIM s ON sf.storeKey = s.storeKey
GROUP BY
    st.first_name + ' ' + st.last_name,
    s.store_name
ORDER BY
    total_sales DESC;

SELECT
    st.first_name + ' ' + st.last_name AS StaffName,
    s.store_name,
    td.MonthName,
    td.Year,
    ROUND(
        SUM(
            sf.list_price - (sf.list_price * sf.discount / 100)
        ),
        2
    ) AS total_sales,
    COUNT(sf.orderKey) AS TotalOrders,
    SUM(sf.quantity) AS TotalSales
FROM
    salesFact sf
    JOIN StaffDIM st ON sf.staffKey = st.staffKey
    JOIN StoreDIM s ON sf.storeKey = s.storeKey
    JOIN TimeDim td ON sf.timeKey = td.timeKey
WHERE
    td.Year = '2018'
GROUP BY
    st.first_name + ' ' + st.last_name,
    s.store_name,
    td.MonthName,
    td.Year
ORDER BY
    td.Year DESC,
    td.MonthName DESC,
    total_sales DESC;

-- 4

SELECT 
    TD.WeekOfYear,
    TD.Year,
    SD.store_id,
    SD.store_name,
    StD.staff_id,
    CONCAT(StD.first_name, ' ', StD.last_name) AS staff_name,
    COUNT(DISTINCT SF.orderKey) AS number_of_transactions,
    SUM(SF.quantity) AS total_units_sold,
    SUM(SF.quantity * SF.list_price * (1 - SF.discount)) AS total_sales_value,
    AVG(SF.quantity * SF.list_price * (1 - SF.discount)) AS average_transaction_value
FROM 
    salesFact SF
INNER JOIN 
    TimeDim TD ON SF.timeKey = TD.timeKey
INNER JOIN 
    StoreDIM SD ON SF.storeKey = SD.storeKey
INNER JOIN 
    StaffDIM StD ON SF.staffKey = StD.staffKey
WHERE
    TD.IsWeekday = 1 -- Assuming you only want to consider weekdays
GROUP BY 
    TD.WeekOfYear,
    TD.Year,
    SD.store_id,
    SD.store_name,
    StD.staff_id,
    CONCAT(StD.first_name, ' ', StD.last_name)
ORDER BY 
    TD.Year, 
    TD.WeekOfYear, 
    SD.store_id, 
    StD.staff_id;

-- Total Sales Value per Week per Staff and Store: This shows how much each staff member in each store is selling weekly. It helps in identifying high-performing staff and stores.

-- Number of Transactions per Week per Staff and Store: This indicates the volume of transactions handled by each staff member in each store on a weekly basis.

-- Average Transaction Value per Week per Staff and Store: This provides an insight into the average size of transactions for each staff member in each store per week.