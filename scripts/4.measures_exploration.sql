/*
============================================================
                Measures Exploration
============================================================
Purpose:
        - To calculate aggregate values(e.g: total sales,average revenue) for quick insights
Functions used:
        - SUM(),AVG(),COUNT()

*/


-- Find the total sales 
SELECT SUM(sales_amount) FROM gold.fact_sales;

-- Find how many items sold
SELECT SUM(quantity) as total_quantity FROM gold.fact_sales;

-- Find the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Find the total number of orders
SELECT COUNT(order_number) FROM gold.fact_sales;
SELECT COUNT(DISTINCT order_number) FROM gold.fact_sales;

-- Find the total number of products
SELECT COUNT(product_number) FROM gold.dim_products;
SELECT COUNT(DISTINCT product_number) FROM gold.dim_products;

-- Find the total number of customers
SELECT COUNT(customer_key) FROM gold.dim_customers;

-- find the total number of customers that placed order
SELECT COUNT(DISTINCT customer_key) FROM gold.fact_sales;


 -- Generate a report that show all key metrics of business
 SELECT 'Total Sales' AS measure_name,SUM(sales_amount) as measure_value 
 FROM gold.fact_sales
 UNION ALL
SELECT 'Total quantity' AS measure_name,SUM(quantity) as measure_value 
 FROM gold.fact_sales
 UNION ALL
SELECT 'Average Price' AS measure_name,AVG(price) as measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total No of Orders' AS measure_name,COUNT(DISTINCT order_number) as measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 'Total No of Products' AS measure_name,COUNT(DISTINCT product_number) as measure_value 
FROM gold.dim_products
UNION ALL
SELECT 'Total No of Customers' AS measure_name,COUNT(customer_key) as measure_value 
FROM gold.dim_customers
