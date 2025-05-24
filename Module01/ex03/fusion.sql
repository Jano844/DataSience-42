CREATE TABLE customers_enriched AS --Create New Table with with collums of the costumer(c) and items(i)
SELECT
    c.event_time,
    c.event_type,
    c.product_id,
    c.price,
    c.user_id,
    c.user_session,
    i.category_id,
    i.category_code,
    i.brand
FROM
    customers c
LEFT JOIN
    item i
ON
    c.product_id::TEXT = i.product_id; -- Create The link bewteen Product_id
