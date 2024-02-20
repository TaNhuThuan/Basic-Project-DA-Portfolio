/*

Cleaning and  Formatting Data in SQL Queries

*/

SELECT *
FROM Historical_Product_Demand hpd 
LIMIT 10;

/* Standardize Date Format */

ALTER TABLE Historical_Product_Demand 

ADD COLUMN DateConverted DATE; 

-- > Use "Alter table" and "Add Column" syntax to add a new column to table.

UPDATE Historical_Product_Demand

SET DateConverted = CASE
                      WHEN `Date` NOT LIKE 'NA' THEN CONVERT(`Date`, DATE)
                      ELSE NULL
                   END
                   
WHERE `Date` NOT LIKE 'NA';

-- >  Use "Update" and "Set" syntax to convert values from 'Date' column.
-- >> "Case ... When" syntax to convert just valid values from 'Date' column.

ALTER TABLE Historical_Product_Demand

DROP COLUMN Date;

SELECT *

FROM Historical_Product_Demand hpd 

LIMIT 10;

/* Remove prefix of those metric in table, just keep code, warehouse letters and category */

UPDATE Historical_Product_Demand

SET
  product_code = CASE WHEN product_code LIKE 'product-%' THEN SUBSTRING(product_code, LENGTH('product-') + 1) ELSE product_code END,
  
  Warehouse = CASE WHEN Warehouse LIKE 'Whse_%' THEN SUBSTRING(Warehouse, LENGTH('Whse_') + 1) ELSE Warehouse END,
  
  Product_Category = CASE WHEN Product_Category LIKE 'Category_%' THEN SUBSTRING(Product_Category, LENGTH('Category_') + 1) ELSE Product_Category END;
  
-- >  In this UPDATE statement, each field (product_code, Warehouse, Product_Category) is processed with a CASE statement to check the condition before applying the SUBSTRING function. 
-- >> If the field satisfies the condition (e.g. product_code LIKE 'product-%'), the SUBSTRING function is applied; otherwise, the field value will not change.