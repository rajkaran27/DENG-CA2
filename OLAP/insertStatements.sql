--use BikeSalesDWGroup3
DECLARE @StartDate DATETIME = '20160101' --Starting value of Date Range
DECLARE @EndDate DATETIME = '20181231' --End Value of Date Range

DECLARE @curDate DATE
DECLARE @FirstDayMonth DATE
DECLARE @QtrMonthNo int
DECLARE @FirstDayQtr DATE

SET @curdate = @StartDate
while @curDate < @EndDate 
  Begin
		   
    SET @FirstDayMonth = DateFromParts(Year(@curDate), Month(@curDate), '01')
	SET @QtrMonthNo = ((DatePart(Quarter, @CurDate) - 1) * 3) + 1 
    Set @FirstDayQtr = DateFromParts(Year(@curDate), @QtrMonthNo, '01')

	INSERT INTO [TimeDim]
    select 
	  CONVERT (char(8),@curDate,112) as TimeKey,
	  @CurDate AS Date,
	  CONVERT (char(10), @CurDate,103) as FullDateUK,
	  CONVERT (char(10), @CurDate,101) as FullDateUSA,
	  DATEPART(Day, @curDate) AS DayOfMonth,

	  --Apply Suffix values like 1st, 2nd 3rd etc..
	  CASE 
		WHEN DATEPART(Day,@curDate) IN (11,12,13) 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'th'
		WHEN RIGHT(DATEPART(Day,@curDate),1) = 1 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'st'
		WHEN RIGHT(DATEPART(Day,@curDate),1) = 2 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'nd'
		WHEN RIGHT(DATEPART(Day,@curDate),1) = 3 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'rd'
		ELSE CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'th' 
	  END AS DaySuffix,

	  DATENAME(WeekDay, @curDate) AS DayName,
	  DATEPART(weekDay, @curDate) AS DayOfWeekUSA,
	
	  -- Convert DayOfWeek in USA to UK
	  CASE DATEPART(WeekDay, @curDate)
		WHEN 1 THEN 7
		WHEN 2 THEN 1
		WHEN 3 THEN 2
		WHEN 4 THEN 3
		WHEN 5 THEN 4
		WHEN 6 THEN 5
		WHEN 7 THEN 6
	  END AS DayOfWeekUK,
	  
	   -- Calcuate the Week Number with a Month
	  DatePart(DayOfYear, @curDate) AS DayOfYear,
	  (DatePart(Week, @curDate) - DatePart(Week, @FirstDayMonth)) + 1 
	       as WeekOfMonth,	
      (DatePart(Week, @curDate) - DatePart(Week, @FirstDayQtr)) + 1 
	       as WeekOfQuarter,
	  DatePart(Week, @curDate) as WeekOfYear,
	  DatePart(Month, @curDate) AS Month,
	  Datename(Month, @curDate) AS MonthName,
	  ((DatePart(Month, @curDate) - 1) % 3) + 1 As MonthOFQuarter,
	  DatePart(Quarter, @curDate) as Quarter,
	  CASE DatePart(Quarter, @curDate)
			WHEN 1 THEN 'First'
			WHEN 2 THEN 'Second'
			WHEN 3 THEN 'Third'
			WHEN 4 THEN 'Fourth'
	  END AS QuarterName,
	  DatePart(Year, @curDate) as Year,
	  CONCAT('CY ', DatePart(Year, @startDate)) as YearName,
	  CONCAT(LEFT(DATENAME(Month, @curDate), 3), '-', 
	          DATEPART(Year, @curDate)) AS MonthYear,
	  CONCAT(RIGHT(CONCAT('0', DATEPART(Month, @curDate)), 2),  
		      DATEPART(Year, @curDate)) AS MMYYYY,
      @FirstDayMonth as FirstDayOfMonth,
	  EOMONTH(@curDate) as LastDayOfMonth,
	  DATEADD(Quarter, DATEDIFF(Quarter, 0, @curDate), 0) AS FirstDayOfQuarter,
	  DATEADD(Quarter, DATEDIFF(Quarter, -1, @curDate), -1) AS LastDayOfQuarter,
	  DateFromParts(Year(@curDate), '01', '01') as FirstDayOfYear,
	  DateFromParts(Year(@curDate), '12', '31') as LastDayOfYear,
	  NULL AS IsHolidayUSA,
	  CASE
		WHEN DATEPART(WeekDay, @curDate) in (1, 7) THEN 0
		WHEN DATEPART(WeekDay, @curDate) in (2, 3, 4, 5, 6) THEN 1
	  END as IsWeekDay,
	  NULL AS HolidayUSA, 
	  Null, Null    	
		
    /* Increate @curDate by 1 day */
	SET @curDate = DateAdd(Day, 1, @curDate)
  End



-- use BikeSalesGroup3
-- Load data from sales.stores (OLTP) to sales.StoreDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..StoreDIM (store_id, store_name, phone, email, street, city, state, zip_code)
SELECT store_id, store_name, phone, email, street, city, state, zip_code
FROM sales.stores;

-- Load data from sales.staffs (OLTP) to BikeSalesDWGroup3.StaffDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..StaffDIM (staff_id, first_name, last_name, email, phone, active, manager_id)
SELECT staff_id, first_name, last_name, email, phone, active, manager_id
FROM sales.staffs;

-- Load data from production.categories (OLTP) to BikeSalesDWGroup3.CategoryDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..CategoryDIM (category_id, category_name)
SELECT category_id, category_name
FROM production.categories;

-- Load data from production.brands (OLTP) to BikeSalesDWGroup3.BrandDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..BrandDIM (brand_id, brand_name)
SELECT brand_id, brand_name
FROM production.brands;

-- Load data from sales.customers (OLTP) to BikeSalesDWGroup3.CustomerDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..CustomerDIM (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
SELECT customer_id, first_name, last_name, phone, email, street, city, state, zip_code
FROM sales.customers;

-- Load data from production.products (OLTP) to BikeSalesDWGroup3.ProductDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..ProductDIM (product_id, categoryKey, brandKey, product_name, model_year, list_price, stock_quantity, stock_date)
SELECT p.product_id, c.categoryKey, b.brandKey, p.product_name, p.model_year, p.list_price, ISNULL(s.total_quantity, 0) AS stock_quantity, GETDATE() AS stock_date
FROM production.products p
JOIN BikeSalesDWGroup3..CategoryDIM c ON p.category_id = c.category_id
JOIN BikeSalesDWGroup3..BrandDIM b ON p.brand_id = b.brand_id
LEFT JOIN (SELECT product_id, SUM(quantity) AS total_quantity FROM production.stocks GROUP BY product_id) s ON p.product_id = s.product_id

-- Load data from sales.orders (OLTP) to BikeSalesDWGroup3.OrderDIM (OLAP)
INSERT INTO BikeSalesDWGroup3..OrderDIM (order_id, order_status, order_date, required_date, shipped_date)
SELECT order_id, order_status, order_date, required_date, shipped_date
FROM sales.orders;

-- Load data from sales.order_items (OLTP) to BikeSalesDWGroup3.SalesFact (OLAP)
INSERT INTO BikeSalesDWGroup3..salesFact (timeKey, orderKey, customerKey, storeKey, staffKey, productKey, quantity, list_price, discount)
SELECT replace(CONVERT(DATE,os.order_date, 112),'-',''), o.orderKey, c.customerKey, s.storeKey, st.staffKey, p.productKey, oi.quantity, oi.list_price, oi.discount
FROM sales.order_items oi
JOIN sales.orders os ON oi.order_id = os.order_id
JOIN BikeSalesDWGroup3..OrderDIM o ON os.order_id = o.order_id
JOIN BikeSalesDWGroup3..CustomerDIM c ON os.customer_id = c.customer_id
JOIN BikeSalesDWGroup3..StoreDIM s ON os.store_id = s.store_id
JOIN BikeSalesDWGroup3..StaffDIM st ON os.staff_id = st.staff_id
JOIN BikeSalesDWGroup3..ProductDIM p ON oi.product_id = p.product_id;

