CREATE TABLE retail_cleaned AS
SELECT *
FROM online_retail
WHERE Quantity > 0
  AND UnitPrice > 0
  AND CustomerID IS NOT NULL;
