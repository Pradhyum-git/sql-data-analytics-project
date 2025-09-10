/*
========================================================
              Date Exploration
========================================================
Purpose:
        - To explore the date columns of tables.

Functions used:
        - MIN
        - MAX
        - TIMESTAMPDIFF

*/
-- Find date of first and last order date
-- How many sales are available
SELECT
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
TIMESTAMPDIFF(year,MIN(order_date),MAX(order_date))
FROM
gold.fact_sales; 

-- Find youngest and oldest customer

SELECT
MIN(birthdate) young_birthdate,
TIMESTAMPDIFF(year,MIN(birthdate),NOW()) as younger_age,
MAX(birthdate) old_birthdate,
TIMESTAMPDIFF(year,MAX(birthdate),NOW()) as older_age
FROM gold.dim_customers
