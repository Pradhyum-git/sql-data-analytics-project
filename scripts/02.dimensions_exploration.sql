/*
===================================================================
                      Dimension Exploration
===================================================================
Purpose:
      - To explore the structure of dimension tables
Functions Used:
      - DISTINCT
*/
# Explore all countries come from
SELECT DISTINCT country FROM gold.dim_customers;

# Explore all categories 'All major divisions'
SELECT 
DISTINCT category,sub_category,product_name 
FROM 
gold.dim_products; 
