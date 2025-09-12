
/*
-----------------------------------------------------------------------------------------------------------------------
                  Performance Analysis - comparing current values with target values
-----------------------------------------------------------------------------------------------------------------------
*/
-- current[measure]-target[measure]

-- analyze the yearly performance of products 
-- by comparing each products sales to both it's average and the previous year sales
WITH yearly_product_sales as 
(
	SELECT
	YEAR(f.order_date) AS year,
	p.product_name,
	SUM(f.sales_amount) as current_sales
	FROM
	gold.fact_sales f
	LEFT JOIN 
	gold.dim_products p
	ON f.product_key=p.product_key
	GROUP BY YEAR(f.order_date),p.product_name
)
SELECT  -- Year Over Year analysis
year,product_name,current_sales ,
AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
current_sales-AVG(current_sales) OVER(PARTITION BY product_name) as avg_diff,
CASE 
	WHEN current_sales-AVG(current_sales) OVER(PARTITION BY product_name)>0 THEN 'Above average'
    WHEN current_sales-AVG(current_sales) OVER(PARTITION BY product_name)<0 THEN 'Below Average'
    ELSE 'Average'
END AS avg_change,
LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year) as previous_year_sales,
current_sales-LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year) AS prev_year_diff,
CASE 
	WHEN current_sales-LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year)>0 THEN 'INCREASE'
    WHEN current_sales-LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year)<0 THEN 'Decrease'
    ELSE 'No Change'
END AS prev_change
FROM yearly_product_sales
ORDER BY product_name, year;
