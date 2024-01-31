
-- original
    SELECT
        t.MonthYear,
        SUM(sf.quantity) AS TotalSales,
        SUM(sf.list_price - (sf.list_price * sf.discount)) AS TotalRevenue,
        AVG(sf.discount) AS AverageDiscount
    FROM
        BikeSalesDWGroup3..salesFact sf
    JOIN
        BikeSalesDWGroup3..TimeDim t ON sf.timeKey = t.timeKey
    GROUP BY
        t.MonthYear
    ORDER BY
        t.MonthYear;

