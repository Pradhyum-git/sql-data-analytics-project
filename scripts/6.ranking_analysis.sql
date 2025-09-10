/*
========================================================
                Ranking Analysis
========================================================
Purpose:
      - To analyse the ranking of aggregated measures by dimensions
Functions Used:
      - SUM(),AVG(),GROUP BY(),ORDER BY(),COUNT(),LIMIT

*/

-- which 5 product generates highest revenue
SELECT
d.product_name,
SUM(f.sales_amount) AS total_revenue
FROM
gold.fact_sales f
LEFT JOIN
gold.dim_products d
ON f.product_key=d.product_key
GROUP BY d.product_name
ORDER BY total_revenue  DESC LIMIT 5;

-- What are the 5 worst performance products in terms of sales
SELECT
d.product_name,
SUM(f.sales_amount) AS total_revenue
FROM
gold.fact_sales f
LEFT JOIN
gold.dim_products d
ON f.product_key=d.product_key
GROUP BY d.product_name
ORDER BY total_revenue  LIMIT 5;

-- find the top 10 customers generated the highest revenue

SELECT
d.customer_key,
d.firstname,
d.lastname,
SUM(f.sales_amount) as total_revenue
FROM
gold.fact_sales f
LEFT JOIN
gold.dim_customers d
ON f.customer_key=d.customer_key
GROUP BY d.customer_key,d.firstname,d.lastname
ORDER BY total_revenue DESC LIMIT 10;

-- find the 3 customer they placed fewer orders
SELECT
d.customer_key,
d.firstname,
d.lastname,
COUNT(DISTINCT order_number) as total_orders
FROM
gold.fact_sales f
LEFT JOIN
gold.dim_customers d
ON f.customer_key=d.customer_key
GROUP BY d.customer_key,d.firstname,d.lastname
ORDER BY total_orders LIMIT 3;
