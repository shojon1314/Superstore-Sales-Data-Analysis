# Customer Segmentation Using RFM Segmentation in SQL

## Overview

This project analyzes the Superstore Sales Dataset using SQL for data cleaning, exploratory data analysis (EDA), and customer segmentation using RFM analysis.



## Methodology:
Steps
1. **Database Creation**: Created a MySQL database and table to store the sales data.
2. **Data Insertion**: Inserted the provided CSV data into the MySQL table.
3. **Data Cleaning**: Cleaned the data by handling missing values and updating the schema if necessary.
4. **Exploratory Data Analysis**: Performed various SQL queries to analyze sales, profit, and customer segments.
5. **RFM Segmentation**: Segmented customers based on Recency, Frequency, and Monetary value.


## Tools and Technologies
- MySQL
- SQL

## Files
 -  `SuperstoreSalesData.csv`: The raw sales data file
- `create_tables.sql`: Creates the database and tables.
- `data_cleaning.sql`: Cleans and formats the data.
- `exploratory_analysis.sql`: Runs EDA queries for insights.
- `rfm_segmentation.sql`: Performs RFM segmentation.

### Note: Insert the Data (Bulk Insertion) from the CSV file by using online tools.


#Description of process

- `Data Cleaning`:
   •	Fixed date format issues
   •	Removed duplicates
   •	Standardized text fields
   •	Handled NULL values
- `Exploratory Data Analysis (EDA)`:
   •	Sales trends over time
   •	Top-selling products & categories
   •	Customer behavior & segmentation
   •	Shipping & delivery trends
- `RFM Segmentation`:
   •	Recency: Days since last purchase
   •	Frequency: Number of purchases
   •	Monetary: Total amount spent
   •	Customer Segments: Best Customers, Loyal Customers, At Risk, Lost Customers

## Findings
- **Total Sales by Region**: The West region recorded the highest sales.
- **Total Profit by Product Category**: Technology products generated the highest profit.
- **Average Discount by Customer Segment**: Corporate customers received the highest average discount.


