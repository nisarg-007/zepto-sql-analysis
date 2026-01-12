-- Q1. Best Value Products (Top 10 by Discount %)
SELECT DISTINCT name, mrp, discountedsellingprice, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2. High Value Stockout Risk (High MRP but Out of Stock)
SELECT DISTINCT name, mrp 
FROM zepto 
WHERE outofstock = true 
ORDER BY mrp DESC;

-- Q3. Estimated Revenue per Category (Potential Revenue)
-- Logic: Selling Price * Available Quantity
SELECT category,
       SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- Q4. Premium Products with Low Discounts (>500 INR MRP, <10% Discount)
SELECT DISTINCT name, mrp, discountpercent
FROM zepto
WHERE mrp > 500 AND discountpercent < 10
ORDER BY mrp DESC;

-- Q5. Top 5 Categories by Average Discount
SELECT category, ROUND(AVG(discountpercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Unit Economics: Price per Gram (for items > 100g)
SELECT DISTINCT name, 
       weightingms, 
       discountedsellingprice, 
       ROUND(ABS(discountedsellingprice / weightingms), 2) AS price_per_gram
FROM zepto
WHERE weightingms >= 100
ORDER BY price_per_gram ASC;

-- Q7. Weight Categorization (Low/Medium/Bulk)
SELECT DISTINCT name, quantity, weightingms,
       CASE 
           WHEN weightingms < 1000 THEN 'Low'
           WHEN weightingms < 5000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto;

-- Q8. Inventory Logistics: Total Weight per Category
SELECT category, SUM(availablequantity * weightingms) AS inventory_weight
FROM zepto
GROUP BY category
ORDER BY inventory_weight DESC;