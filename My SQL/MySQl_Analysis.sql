CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE amazon_sales (
    order_id VARCHAR(50),
    order_date DATE,
    status VARCHAR(50),
    fulfilment VARCHAR(50),
    sales_channel VARCHAR(50),
    ship_service_level VARCHAR(100),
    style VARCHAR(100),
    sku VARCHAR(100),
    category VARCHAR(100),
    size VARCHAR(20),
    asin VARCHAR(50),
    courier_status VARCHAR(50),
    qty INT,
    currency VARCHAR(10),
    amount DECIMAL(10,2),
    ship_city VARCHAR(100),
    ship_state VARCHAR(100),
    ship_postal_code VARCHAR(20),
    ship_country VARCHAR(50),
    promotion_ids VARCHAR(255),
    b2b VARCHAR(10),
    fulfilled_by VARCHAR(50)
);
SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';

TRUNCATE TABLE amazon_sales;

LOAD DATA LOCAL INFILE 'C:/Users/ayush/Amazon Sale Report.csv'
INTO TABLE amazon_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dummy, order_id, @order_date, status, fulfilment, sales_channel,
ship_service_level, style, sku, category, size, asin,
courier_status, qty, currency, amount, ship_city,
ship_state, ship_postal_code, ship_country,
promotion_ids, b2b, fulfilled_by)
SET order_date = STR_TO_DATE(@order_date, '%m-%d-%y');

SELECT * FROM amazon_sales;

-- 1. Top 10 Selling Products 

SELECT CATEGORY , SUM(AMOUNT) AS TOTAL_SALES
FROM AMAZON_SALES
GROUP BY CATEGORY
ORDER BY TOTAL_SALES DESC
LIMIT 10;

-- 2. Total Revenue 

SELECT SUM(AMOUNT) FROM AMAZON_SALES;

-- 3. Revenue by Category

SELECT CATEGORY, SUM(AMOUNT) AS REVENUE
FROM AMAZON_SALES
GROUP BY CATEGORY
ORDER BY REVENUE DESC;

-- 4. Product-wise Cancel Count

SELECT CATEGORY, COUNT(*) AS CANCEL_PRODUCT
FROM AMAZON_SALES
WHERE STATUS = 'CANCELLED'
GROUP BY CATEGORY
ORDER BY CANCEL_PRODUCT ASC;