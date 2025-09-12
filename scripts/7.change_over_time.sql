/*
-------------------------------------------------------------
            Change-Over_Time
-------------------------------------------------------------
*/
/*
Purpose :
    To explore the measure over time.(e.g. sales in every year)
Functions used:
    -YEAR(),SUM(),MONTH(),COUNT(),MONTHNAME()
*/

-- Total sales over time
SELECT
YEAR(order_date) AS order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) AS total_customers
FROM
gold.fact_sales;

-- Monthly trend of sales
SELECT
MONTHNAME(order_date) AS month_name,
MONTH(order_date) AS order_month,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) AS total_customers
FROM
gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTHNAME(order_date),MONTH(order_date)
ORDER BY order_month;
