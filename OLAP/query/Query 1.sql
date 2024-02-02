WITH RankedSales AS (
    SELECT 
        t.[Year] AS SalesYear,
        t.[MonthName] AS SalesMonth,
        s.store_name,
        s.store_id,
        SUM(sf.quantity) AS TotalBikesSold,
        CEILING(SUM(sf.list_price * sf.quantity)) AS TotalRevenue,
        CEILING(SUM(sf.list_price * sf.quantity * sf.discount/100)) AS TotalDiscount,
        CEILING(SUM(sf.list_price * sf.quantity)) - CEILING(SUM(sf.list_price * sf.quantity * sf.discount/100)) AS TotalRevenueAfterDiscount,
        RANK() OVER (PARTITION BY t.[Year], s.store_id ORDER BY CEILING(SUM(sf.list_price * sf.quantity * (1 - sf.discount/100))) DESC) AS SalesRank
    FROM 
        salesFact sf
    JOIN 
        TimeDim t ON sf.timeKey = t.timeKey
    JOIN 
        StoreDIM s ON sf.storeKey = s.storeKey
    GROUP BY 
        t.[Year],
        t.[MonthName],
        s.store_name,
        s.store_id
)
SELECT 
    SalesYear,
    SalesMonth,
    store_name,
    store_id,
    TotalBikesSold,
    TotalRevenue,
    TotalDiscount,
    TotalRevenueAfterDiscount,
    CASE WHEN SalesRank = 1 THEN 'Highest Earning' ELSE 'Not Highest Earning' END AS Highlight
FROM 
    RankedSales
ORDER BY 
    SalesYear, CASE 
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
    END,  store_name;



-- raj

INSIGHTS

Monthly Performance:

The data spans multiple years, and each year is divided into months.
The performance metrics (bikes sold, total revenue, total discount, total revenue after discount) are reported for each month.
Store Performance:

Three stores (Baldwin Bikes, Rowlett Bikes, and Santa Cruz Bikes) are tracked for each month.
The performance metrics are reported for each store, indicating their individual contributions to sales and revenue.
Earning Status:

The "Highlight" column indicates whether a particular store had the highest revenue in a given month ("Highest Earning") or not.
This information helps identify the top-performing store for each month.
Trends Over Time:

By comparing the "Highest Earning" status over different months, you can identify trends and patterns in store performance.
It seems that the store with the highest revenue varies from month to month.
Seasonal Variations:

There may be seasonal variations in bike sales and revenue, as seen by changes in performance metrics across different months.
Inconsistent Highest Earning Store:

The "Highest Earning" status does not follow a consistent pattern for any specific store. Different stores achieve the highest earnings in different months.
Store-Specific Performance:

Some stores consistently perform well ("Santa Cruz Bikes" in June 2016 and June 2017), while others fluctuate in their performance.
Potential Areas for Improvement:

Stores that are not consistently the highest earning in their respective months may need to explore strategies for improvement.
Outliers:

In April 2018, there is a significant spike in performance metrics for all stores, indicating an outlier or special event that led to exceptionally high sales.
Overall Business Trends:

The data provides an overview of the overall business trends, indicating periods of growth or decline.