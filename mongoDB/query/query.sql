--- MongoDB Query 1

--mongodb version
db.ZeroStock.find({"list_price":{"$lt":2000},"category_name":"Road Bike","quantity":0},{"product_name":1,"_id":0})

--sql verison
use BikeSalesGroup3;

SELECT p.product_id, p.product_name, b.brand_name, c.category_name, p.model_year, p.list_price, 
COALESCE(s.quantity, 0) AS quantity 
FROM production.products p 
JOIN production.brands b ON p.brand_id = b.brand_id 
JOIN production.categories c ON c.category_id = p.category_id 
LEFT JOIN production.stocks s ON s.product_id = p.product_id 
WHERE (COALESCE(s.quantity, 0) = 0 OR s.product_id is null) AND (p.list_price<2000 AND c.category_name='Road Bike');


--- MongoDB Query 2

--mongodb version
--Unduplicated category names
db.UnSold.distinct("category_name")
--Unduplicated brand names
db.UnSold.distinct("brand_name")

--sql verison
USE BikeSalesGroup3;

SELECT DISTINCT c.category_name AS unduplicated_category_name
FROM production.products p
JOIN production.brands b ON p.brand_id = b.brand_id
JOIN production.categories c ON c.category_id = p.category_id
LEFT JOIN sales.order_items s ON s.product_id = p.product_id
WHERE s.product_id IS NULL;

SELECT DISTINCT b.brand_name AS unduplicated_brand_name
FROM production.products p
JOIN production.brands b ON p.brand_id = b.brand_id
JOIN production.categories c ON c.category_id = p.category_id
LEFT JOIN sales.order_items s ON s.product_id = p.product_id
WHERE s.product_id IS NULL;


--- MongoDB Query 3

--mongodb version
db.UnSold.aggregate([{$group:{_id:{category:"$category_name",brand:"$brand_name"}}}])

db.UnSold.aggregate([{$group:{_id:{category:"$category_name",brand:"$brand_name"}}},{$project:{_id:0,category:"$_id.category",brand:"$_id.brand"}}]);

--- MongoDB Query 4

--mongodb version
db.Stock.aggregate([{$lookup:{from:"UnSold",localField:"product_id",foreignField:"product_id",as:"unsoldInfo"}},{$match:{unsoldInfo:{$ne:[]}}},{$project:{_id:0,product_id:1,quantity:1,unsoldInfo:1}}]);


--- MongoDB Query 5

--mongodb version
db.Stock.aggregate([{$lookup:{from:"UnSold",localField:"product_id",foreignField:"product_id",as:"unsoldInfo"}},{$match:{unsoldInfo:{$ne:[]}}},{$group:{_id:"$product_id",totalStock:{$sum:"$quantity"}}},{$project:{_id:0,product_id:"$_id",totalStock:1}},{$sort:{totalStock:-1}}]);


--- MongoDB Query 6

--mongodb version
db.ZeroStock.aggregate([{$lookup:{from:"UnSold",localField:"product_id",foreignField:"product_id",as:"soldInfo"}},{$match:{soldInfo:{$eq:[]}}},{$project:{_id:0,product_id:1,quantity:1,soldInfo:1}}]);