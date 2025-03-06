-- Data Cleaning SQL Script
USE superstore;

-- Replace Blank or Invalid Dates with NULL
UPDATE superstore_sales 
SET order_date = NULL 
WHERE order_date = '' OR order_date = '0000-00-00';

UPDATE superstore_sales 
SET ship_date = NULL 
WHERE ship_date = '' OR ship_date = '0000-00-00';

-- Fix Postal Code Format
ALTER TABLE superstore_sales MODIFY COLUMN postal_code VARCHAR(20);
UPDATE superstore_sales 
SET postal_code = NULL 
WHERE postal_code = '' OR postal_code = '0';

-- Standardize Text Data (Trim Spaces & Fix Case Sensitivity)
UPDATE superstore_sales 
SET customer_name = TRIM(customer_name), 
    product_name = TRIM(product_name), 
    city = TRIM(city), 
    state_or_province = TRIM(state_or_province),
    return_status = CASE WHEN return_status LIKE 'returned' OR return_status LIKE 'RETURNED' THEN 'Returned' ELSE return_status END;

-- Remove Duplicates (Keeping the First Entry)
DELETE FROM superstore_sales 
WHERE row_id NOT IN (
    SELECT MIN(row_id) FROM superstore_sales GROUP BY order_id, product_name
);

-- Convert Dates to Proper Format
UPDATE superstore_sales 
SET order_date = STR_TO_DATE(order_date, '%d-%m-%y'),
    ship_date = STR_TO_DATE(ship_date, '%d-%m-%y')
WHERE order_date IS NOT NULL AND ship_date IS NOT NULL;

-- Validate Data After Cleaning
SELECT * FROM superstore_sales LIMIT 10;
SELECT COUNT(*) FROM superstore_sales WHERE order_date IS NULL;
SELECT COUNT(*) FROM superstore_sales WHERE ship_date IS NULL;
