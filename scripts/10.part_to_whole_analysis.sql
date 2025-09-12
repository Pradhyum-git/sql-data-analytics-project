
/*
----------------------------------------------------------------------------------------------------------
                                Part to Whole Analysis
----------------------------------------------------------------------------------------------------------

*/
-- ([Measure]/[Total Measure]) * 100 by [Dimension]

-- Which category contributes the most to sales
SELECT category,total_sales,
SUM(total_sales) OVER() as overall_sales,
CONCAT(ROUND((total_sales/SUM(total_sales) OVER() )*100,2),'%') as percentage_of_total
FROM(
SELECT
p.category,
SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN
gold.dim_products p
ON f.product_key=p.product_key
GROUP BY p.category
)t;


-- Contribution of countries for orders
SELECT
country,
No_of_orders,
SUM(No_of_orders) OVER() AS overall_orders,
(No_of_orders/SUM(No_of_orders) OVER())*100 as percentage_of_orders
FROM
(
	SELECT
	c.country as country,
	COUNT(DISTINCT f.order_number) AS No_of_orders
	FROM
	gold.fact_sales f
	LEFT JOIN 
	gold.dim_customers c
	ON c.customer_key=f.customer_key
	WHERE c.country IS NOT NULL
	GROUP BY c.country
)t;
