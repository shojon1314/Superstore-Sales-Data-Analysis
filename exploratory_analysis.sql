-- Exploratory Data Analysis SQL Script
USE superstore;

-- 1. Overview of Sales, Profit, and Orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore_sales;

-- 2. Date Range of Orders
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM superstore_sales;

-- 3. Monthly Sales Trend
SELECT 
    YEAR(order_date) AS year, 
    MONTH(order_date) AS month, 
    SUM(sales) AS total_sales
FROM superstore_sales
GROUP BY year, month
ORDER BY year, month;

-- 4. Top 10 Best-Selling Products
SELECT 
    product_name, 
    COUNT(order_id) AS total_orders, 
    SUM(quantity_ordered) AS total_quantity, 
    SUM(sales) AS total_sales
FROM superstore_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 5. Top 5 Most Profitable Product Categories
SELECT 
    category, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profit
FROM superstore_sales
GROUP BY category
ORDER BY total_profit DESC
LIMIT 5;

-- 6. Customer Segments with Highest Sales
SELECT 
    segment, 
    SUM(sales) AS total_sales, 
    SUM(profit) AS total_profit
FROM superstore_sales
GROUP BY segment
ORDER BY total_sales DESC;

-- 7. Most Common Shipping Mode
SELECT 
    ship_mode, 
    COUNT(*) AS total_orders 
FROM superstore_sales
GROUP BY ship_mode
ORDER BY total_orders DESC;

-- 8. Average Delivery Time (Order Date to Ship Date)
SELECT 
    AVG(DATEDIFF(ship_date, order_date)) AS avg_delivery_time
FROM superstore_sales
WHERE ship_date IS NOT NULL AND order_date IS NOT NULL;
