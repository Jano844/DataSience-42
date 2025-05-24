
 -- Creates new Table with Distinct Lines (deletes all duplicats)
CREATE TABLE customers_clean AS
SELECT DISTINCT * FROM customers;

 -- Removes the old Table
DROP TABLE customers;

 -- Rename new Table to old Table
ALTER TABLE customers_clean RENAME TO customers;
