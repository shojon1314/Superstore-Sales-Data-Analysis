-- RFM Segmentation SQL Script
USE superstore;

-- 1. Find the Most Recent Order Date (Reference Date for Recency Calculation)
SELECT MAX(order_date) INTO @max_order_date FROM superstore_sales;

-- 2. Calculate RFM Metrics
WITH rfm AS (
    SELECT 
        customer_id,
        customer_name,
        DATEDIFF(@max_order_date, MAX(order_date)) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM superstore_sales
    GROUP BY customer_id, customer_name
)
SELECT * FROM rfm;

-- 3. Assign RFM Scores (1 to 5)
WITH rfm AS (
    SELECT 
        customer_id,
        customer_name,
        DATEDIFF(@max_order_date, MAX(order_date)) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM superstore_sales
    GROUP BY customer_id, customer_name
),
rfm_scores AS (
    SELECT 
        customer_id,
        customer_name,
        recency,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm
)
SELECT *, CONCAT(r_score, f_score, m_score) AS rfm_segment FROM rfm_scores ORDER BY rfm_segment DESC;

-- 4. Customer Segmentation Based on RFM Scores
WITH rfm AS (
    SELECT 
        customer_id,
        customer_name,
        DATEDIFF(@max_order_date, MAX(order_date)) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM superstore_sales
    GROUP BY customer_id, customer_name
),
rfm_scores AS (
    SELECT 
        customer_id,
        customer_name,
        recency,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm
),
rfm_segments AS (
    SELECT *, 
        CONCAT(r_score, f_score, m_score) AS rfm_segment,
        CASE  
            WHEN r_score = 5 AND f_score = 5 AND m_score = 5 THEN 'Best Customers'
            WHEN r_score >= 4 AND f_score >= 4 THEN 'Loyal Customers'
            WHEN r_score = 5 AND f_score <= 3 THEN 'Recent Buyers'
            WHEN r_score <= 2 AND f_score >= 4 THEN 'At Risk Customers'
            WHEN r_score = 1 AND f_score = 1 THEN 'Lost Customers'
            ELSE 'Other'
        END AS customer_segment
    FROM rfm_scores
)
SELECT * FROM rfm_segments ORDER BY rfm_segment DESC;
