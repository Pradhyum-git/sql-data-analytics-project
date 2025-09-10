/*
======================================================================
                   DataBase Exploration
=======================================================================
Purpose:
      - To explore the structure of database including list of tables
      - To inspect the columns.
Tables Used:
      - INFORMATION_SCHEMA.TABLES
      - INFORMATION_SCHEMA.COLUMNS
=======================================================================
*/

-- Explore all objects in the database.
USE INFORMATION_SCHEMA;
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Explore all columns in the database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

-- Explore all columns in the particular table
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_customers'
ORDER BY ORDINAL_POSITION;
