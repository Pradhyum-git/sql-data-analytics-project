/*
--------------------------------------------------
             Cummulative Measure
--------------------------------------------------

*/
-- [cummulative measure]by[date dimension]


-- Calculate the total sales per month 
-- and running total sales over time
SELECT
order_date,total_sales,
SUM(total_sales) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_sales
FROM
(
	SELECT
	DATE_FORMAT(order_date,'%Y-%M') as order_date,
	SUM(sales_amount) as total_sales
	FROM
	gold.fact_sales
    WHERE order_date is NOT NULL
	GROUP BY DATE_FORMAT(order_date,'%Y-%M')
)t;


-- calculate the avg sales and moving average sales for every year
SELECT
year,avg_sales,
AVG(avg_sales) OVER(ORDER BY year) as running_average
FROM
(
	SELECT
	YEAR(order_date) as year,
	AVG(sales_amount) as avg_sales
	FROM
	gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY Year(order_date)
)t;
