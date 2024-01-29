-- drop database if exists DW; run this first
create database BikeSalesDWGroup3;
use BikeSalesDWGroup3;

-- raj
-- product,category,brand,time dimension
CREATE TABLE CategoryDIM(
    categoryKey int IDENTITY PRIMARY KEY,
    category_id varchar(5) NOT NULL,
    category_name VARCHAR (255) NOT NULL,
)

CREATE TABLE BrandDIM(
    brandKey int IDENTITY PRIMARY KEY,
    brand_id varchar(5) NOT NULL,
    brand_name VARCHAR (255) NOT NULL,
)
CREATE TABLE ProductDIM(
    productKey int IDENTITY PRIMARY KEY,
    product_id varchar(10) NOT NULL,
    categoryKey int NOT NULL,
    brandKey int NOT NULL,
    product_name VARCHAR (255) NOT NULL,
    model_year int NOT NULL,
    list_price DECIMAL (10, 2) NOT NULL,
    stock_quantity int ,
    stock_date DATE ,
    FOREIGN KEY (categoryKey) REFERENCES CategoryDIM (categoryKey),
    FOREIGN KEY (brandKey) REFERENCES BrandDIM (brandKey)
)


-- pj
CREATE TABLE StoreDIM (
storeKey int IDENTITY PRIMARY KEY,
store_id varchar(5),
store_name VARCHAR (255) NOT NULL,
phone VARCHAR (25),
email VARCHAR (255),
street VARCHAR (255),
city VARCHAR (255),
state VARCHAR (10),
zip_code VARCHAR (5)
);
-- pj

-- CREATE TABLE OrderStatusDIM (
-- orderStatusKey int IDENTITY PRIMARY KEY,
-- );

-- pj

CREATE TABLE OrderDIM (
orderKey int IDENTITY PRIMARY KEY,
order_id varchar(10),
order_status int NOT NULL,
order_date DATE NOT NULL,
required_date DATE NOT NULL,
shipped_date DATE,
);


-- lexuan
--Customer, staff dimention
CREATE TABLE CustomerDIM (
    customerKey INT IDENTITY PRIMARY KEY,
    customer_id VARCHAR(10) UNIQUE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(25),
    zip_code VARCHAR(5)
);

CREATE TABLE StaffDIM (
    staffKey INT IDENTITY PRIMARY KEY,
    staff_id VARCHAR(5) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active int NOT NULL,
    manager_id varchar(5),
);

CREATE TABLE TimeDim(	
        [timeKey] INT  primary key, 
		[Date] DATETIME,
		[FullDateUK] CHAR(10), -- Date in dd-MM-yyyy format
		[FullDateUSA] CHAR(10),-- Date in MM-dd-yyyy format
		[DayOfMonth] VARCHAR(2), -- Field will hold day number of Month
		[DaySuffix] VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc
		[DayName] VARCHAR(9), -- Contains name of the day, Sunday, Monday 
		[DayOfWeekUSA] CHAR(1),-- First Day Sunday=1 and Saturday=7
		[DayOfWeekUK] CHAR(1),-- First Day Monday=1 and Sunday=7
		[DayOfYear] VARCHAR(3),
		[WeekOfMonth] VARCHAR(1),-- Week Number of Month 
		[WeekOfQuarter] VARCHAR(2), --Week Number of the Quarter
		[WeekOfYear] VARCHAR(2),--Week Number of the Year
		[Month] VARCHAR(2), --Number of the Month 1 to 12
		[MonthName] VARCHAR(9),--January, February etc
		[MonthOfQuarter] VARCHAR(2),-- Month Number belongs to Quarter
		[Quarter] CHAR(1),
		[QuarterName] VARCHAR(9),--First,Second..
		[Year] CHAR(4),-- Year value of Date stored in Row
		[YearName] CHAR(7), --CY 2012,CY 2013
		[MonthYear] CHAR(10), --Jan-2013,Feb-2013
		[MMYYYY] CHAR(6),
		[FirstDayOfMonth] DATE,
		[LastDayOfMonth] DATE,
		[FirstDayOfQuarter] DATE,
		[LastDayOfQuarter] DATE,
		[FirstDayOfYear] DATE,
		[LastDayOfYear] DATE,
		[IsHolidayUSA] BIT,-- Flag 1=National Holiday, 0-No National Holiday
		[IsWeekday] BIT,-- 0=Week End ,1=Week Day
		[HolidayUSA] VARCHAR(50),--Name of Holiday in US
		[IsHolidayUK] BIT Null,
		[HolidayUK] VARCHAR(50) Null --Name of Holiday in UK
);



-- SalesFact
CREATE TABLE salesFact (
    timeKey INT,
    orderKey INT,
    customerKey INT,
    storeKey INT,
    staffKey INT,
    productKey INT,
    quantity INT,
    list_price DECIMAL(10, 2) not null,
    discount DECIMAL(5, 2) not null,
    PRIMARY KEY (timeKey, orderKey, customerKey, storeKey, staffKey, productKey),
    FOREIGN KEY (timeKey) REFERENCES TimeDim(timeKey),
    FOREIGN KEY (orderKey) REFERENCES OrderDIM(orderKey),
    FOREIGN KEY (customerKey) REFERENCES CustomerDIM(customerKey),
    FOREIGN KEY (storeKey) REFERENCES StoreDIM(storeKey),
    FOREIGN KEY (staffKey) REFERENCES StaffDIM(staffKey),
    FOREIGN KEY (productKey) REFERENCES ProductDIM(productKey)
);



