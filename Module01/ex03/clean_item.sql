CREATE TABLE items_clean AS
SELECT *
FROM items
WHERE category_id IS NOT NULL
   OR category_code IS NOT NULL
   OR brand IS NOT NULL;
