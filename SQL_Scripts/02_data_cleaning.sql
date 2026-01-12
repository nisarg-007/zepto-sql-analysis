/* DATA CLEANING STEPS
1. Remove invalid prices.
2. Convert currency from Paise to Rupee.
*/

-- 1. Remove products with 0 price (Invalid Data)
DELETE FROM zepto
WHERE mrp = 0;

-- 2. Convert Paise to Rupees (Standardization)
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedsellingprice = discountedsellingprice / 100.0;

-- Verification
SELECT * FROM zepto LIMIT 5;