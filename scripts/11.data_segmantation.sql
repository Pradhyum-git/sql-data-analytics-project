
/*
-------------------------------------------------------------------------------------------------------------
                            Data Segmentation 
-------------------------------------------------------------------------------------------------------------
*/

-- Data Segmentation : [Measure] by [Measure]
  
-- segement the product by cost and count how many products comes in each segment
WITH product_segment AS
(
	SELECT
	product_number,
	product_name,
	cost,
	CASE 
		WHEN cost<=100 THEN '0-100'
		WHEN cost>100 AND cost<=250 THEN '101-250'
		WHEN cost>250 AND cost<=500 THEN '251-500'
		WHEN cost>500 AND cost<=750 THEN '501-750'
		WHEN cost>750 AND cost>=1000 THEN '751-1000'
		ELSE 'Above 1000'
	END AS price_range
	FROM
	gold.dim_products
)
SELECT
price_range,
COUNT(*) AS count_of_products
FROM
product_segment
GROUP BY price_range;


/*Group customers into three segments based on their spending behaviour
Vip customer - customers with atleast 12 months of history and spending more than 5000
Regular customer - customers with atleast 12 months of history and spending less than 5000
New - customers with a life span less than 12 months.
Find the number of customers in each group 
*/
WITH customer_spending AS
(
SELECT
c.customer_key,
SUM(f.sales_amount) as total_spending,
MIN(f.order_date) as first_order_date,
MAX(f.order_date) as last_order_date,
TIMESTAMPDIFF(MONTH,MIN(f.order_date),MAX(f.order_date)) as lifespan
FROM
gold.fact_sales f
LEFT JOIN
gold.dim_customers c
ON c.customer_key=f.customer_key
GROUP BY c.customer_key
)
SELECT
customer AS customer_segment,
COUNT(*) AS no_of_customers
FROM
(SELECT
*,
CASE 
	WHEN lifespan>=12 AND total_spending>5000 THEN 'VIP Customer'
    WHEN lifespan >=12 AND total_spending<=5000 THEN 'Regular Customer'
    ELSE 'New Customer'
END AS customer
FROM
customer_spending
)t
GROUP BY customer
ORDER BY no_of_customers DESC
