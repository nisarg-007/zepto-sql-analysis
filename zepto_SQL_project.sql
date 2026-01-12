

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);

--data exploration

--count of rows
select count(*) from zepto;

--sample data
SELECT * FROM zepto
LIMIT 10;

--null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

--different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--product in stock vs outof stock
Select outofstock, count(sku_id)
from zepto
group by outofstock;

--product names present multiple times
SELECT 
    name,
    COUNT(sku_id) AS "number of SKU"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

-- data cleaning

-- product with price=0
select * from zepto
where mrp=0 or Discountedsellingprice = 0;


Delete from zepto
where mrp=0;

-- convert paise to Rupees

Update zepto
set mrp= mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

-- Bussiness insight questions
-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountedsellingprice, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;


-- Q2.What are the Products with High MRP but Out of Stock
select distinct name, mrp 
from zepto 
where outofstock = true 
order by mrp desc;

-- Q3. Calculate Estimated Revenue for each category
SELECT category,
       SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- Q4. Find all products where MRP is greater than 500 and discount is less than 10%.
Select distinct name, mrp, discountpercent
from zepto
where mrp>500 and discountpercent < 10
order by mrp desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category, round(avg(discountpercent),2) as top_5
from zepto
group by category
order by top_5 desc
limit 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
select distinct name, weightingms, discountedsellingprice, round(abs(discountedsellingprice/weightingms),2) as ratepergram
from zepto
where weightingms>=100
order by ratepergram asc;

-- Q7.Group the products into categories like Low, Medium, Bulk.

select distinct name, quantity, weightingms,
case when weightingms <1000 then 'LOW'
	when weightingms <5000 then 'medium'
	else 'bulk'
	end as weight_category
from zepto;

--Q8 what is the total inventory weight per category
select category, sum(availablequantity*weightingms) as inventory_weight
from zepto
group by category
order by inventory_weight desc;