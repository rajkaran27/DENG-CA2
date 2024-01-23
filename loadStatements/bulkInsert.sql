BULK INSERT sales.customers
FROM 'C:\Users\rajka\OneDrive - Singapore Polytechnic\Year 2\Y2 Sem 2\DENG\CA2\customers - Copy (2).csv'
WITH (
    FIRSTROW = 2,  -- Skip the header row
    FIELDTERMINATOR = ',',  -- Specify the field terminator
    ROWTERMINATOR = '\n',  -- Specify the row terminator
    MAXERRORS = 0,
    CODEPAGE = 'ACP'  -- Specify the code page if needed
);


BULK INSERT sales.order_items
FROM 'C:\Users\rajka\OneDrive - Singapore Polytechnic\Year 2\Y2 Sem 2\DENG\CA2\OrderItems - Copy (1).csv'
WITH (
    FIRSTROW = 2,  -- Skip the header row
    FIELDTERMINATOR = ',',  -- Specify the field terminator
    ROWTERMINATOR = '\n',  -- Specify the row terminator
    MAXERRORS = 0,
    CODEPAGE = 'ACP'  -- Specify the code page if needed
);

BULK INSERT production.stocks
FROM 'C:\Users\rajka\OneDrive - Singapore Polytechnic\Year 2\Y2 Sem 2\DENG\CA2\Stocks - Copy (1).csv'
WITH (
    FIRSTROW = 2,  -- Skip the header row
    FIELDTERMINATOR = ',',  -- Specify the field terminator
    ROWTERMINATOR = '\n',  -- Specify the row terminator
    MAXERRORS = 0,
    CODEPAGE = 'ACP'  -- Specify the code page if needed
);

-- REMOVE ALL NULLS FROM ORDERS.CSV

CREATE TABLE sales.TempOrders (
    order_id varchar(10),
    customer_id varchar(10),
    order_status int NOT NULL,
    order_date varchar(10) NOT NULL,
    required_date varchar(10) NOT NULL,
    shipped_date varchar(10),
    store_id varchar(5) NOT NULL,
    staff_id varchar(5) NOT NULL
);

BULK INSERT sales.TempOrders
FROM 'C:\Users\rajka\OneDrive - Singapore Polytechnic\Year 2\Y2 Sem 2\DENG\CA2\Orders - Copy (1).csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    MAXERRORS = 0,
    CODEPAGE = 'ACP',
    DATAFILETYPE = 'char'  -- Use 'char' data type for all data
);

INSERT INTO sales.orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
SELECT 
    order_id, 
    customer_id, 
    order_status, 
    CONVERT(DATE, order_date, 103),  -- Assuming dd/mm/yyyy format
    CONVERT(DATE, required_date, 103),
    CASE 
        WHEN shipped_date IS NOT NULL THEN CONVERT(DATE, shipped_date, 103) 
        ELSE NULL 
    END,
    store_id, 
    staff_id
FROM sales.TempOrders;

DROP TABLE sales.TempOrders;

Use BikeSalesGroup3
Declare @Products varchar(max)
Select @Products =
BulkColumn
from OPENROWSET(BULK 'C:\Users\rajka\OneDrive - Singapore Polytechnic\Year 2\Y2 Sem 2\DENG\CA2\products - Copy (2).json', SINGLE_BLOB) JSON
Insert into production.products
Select * From OpenJSON(@Products, '$')
with (
product_id varchar(10) '$.product_id',
product_name varchar(255) '$.product_name',
brand_id varchar(5) '$.brand_id',
category_id varchar(5) '$.category_id',
model_year int '$.model_year',
list_price DECIMAL (10, 2) '$.list_price'
)

