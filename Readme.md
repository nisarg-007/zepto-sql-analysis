# Zepto Quick-Commerce Inventory & Pricing Analysis 🛒

## Project Overview
This project analyzes a dataset from **Zepto** (a quick-commerce grocery delivery platform) to evaluate pricing strategies, inventory distribution, and product discounts. Using **PostgreSQL**, the analysis focuses on identifying unit economics (price per gram), revenue potential per category, and inventory heavy-lifters.

## 📂 Data Structure
**Source:** Kaggle (Zepto V2 Dataset)
**Database:** PostgreSQL
**Row Count:** ~3,731 SKUs

The data includes product details such as MRP, selling price, weight, availability, and discount percentages.

## 🛠️ Tech Stack
* **SQL Dialect:** PostgreSQL
* **Tools:** PgAdmin4 / PSQL Command Line

## 🧹 Data Cleaning & Preparation
Before analysis, the raw data required the following transformation:
1.  **Currency Normalization:** Raw prices were in 'paise'. Converted `MRP` and `DiscountedSellingPrice` to INR (Rupees) by dividing by 100.
2.  **Data Pruning:** Removed invalid entries where `MRP` or `SellingPrice` was 0.
3.  **Categorization:** Grouped products into 'Low', 'Medium', and 'Bulk' based on weight using `CASE` statements.

## 📊 Key Insights & Business Questions

### 1. Discount Strategy
* Identified top 10 "Best Value" products to understand loss-leaders.
* *Query:* Calculated the spread between MRP and Selling Price.

### 2. Inventory Risks (Stockouts)
* Analyzed products with **High MRP but 0 Availability**.
* *Business Impact:* These represent significant lost revenue opportunities.

### 3. Unit Economics
* Calculated **Price per Gram** for products >100g.
* *Insight:* Helps identify the most expensive commodities by weight vs. volume.

### 4. Category Performance
* **Highest Inventory Weight:** The 'Munchies' and 'Cooking Essentials' categories account for the heaviest logistics load.
* **Revenue Potential:** Aggregated potential revenue (`Selling Price * Quantity`) to identify high-value categories.

## 🚀 How to Run
1.  Create the database:
    ```sql
    CREATE DATABASE zepto_db;
    ```
2.  Run the schema script located in `sql_scripts/01_schema_setup.sql`.
3.  Import the CSV data (Ensure `zepto_v2.csv` is in the correct path).
4.  Run cleaning script `sql_scripts/02_data_cleaning.sql`.
5.  Execute analysis `sql_scripts/03_analysis.sql`.

## 📈 Future Improvements
* Integrate delivery time data to correlate "Out of Stock" instances with peak delivery hours.
* Perform ABC Analysis to classify inventory value.