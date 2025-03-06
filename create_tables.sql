-- Create Database
CREATE DATABASE IF NOT EXISTS superstore;
USE superstore;

-- Create Table
CREATE TABLE IF NOT EXISTS superstore_sales (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state_or_province VARCHAR(50),
    region VARCHAR(50),
    postal_code VARCHAR(20),
    product_id VARCHAR(50),
    product_name VARCHAR(200),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales DECIMAL(10,2),
    quantity_ordered INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2),
    return_status VARCHAR(20) NULL
);

-- Verify Table Structure
DESC superstore_sales;

