WITH MonthlySales AS (
    SELECT
        t.[Year] AS SalesYear,
        t.[MonthName] AS SalesMonth,
        SUM(sf.quantity) AS TotalBikesSold,
        CEILING(SUM(sf.list_price * sf.quantity)) AS TotalRevenue,
        LAG(SUM(sf.quantity)) OVER (
            PARTITION BY t.[Year]
            ORDER BY
                MIN(t.[Date])
        ) AS PreviousMonthBikesSold,
        LAG(CEILING(SUM(sf.list_price * sf.quantity))) OVER (
            PARTITION BY t.[Year]
            ORDER BY
                MIN(t.[Date])
        ) AS PreviousMonthRevenue
    FROM
        salesFact sf
        JOIN TimeDim t ON sf.timeKey = t.timeKey
    GROUP BY
        t.[Year],
        t.[MonthName]
)
SELECT
    SalesYear,
    SalesMonth,
    TotalBikesSold,
    TotalRevenue,
    TotalBikesSold - COALESCE(PreviousMonthBikesSold, 0) AS BikesSoldDifference,
    TotalRevenue - COALESCE(PreviousMonthRevenue, 0) AS RevenueDifference
FROM
    MonthlySales
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
    END;