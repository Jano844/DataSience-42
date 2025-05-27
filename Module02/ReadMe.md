Access DataBase in Command line


docker exec -it container_name bash
psql -U user_name -d your_database_name

<!-- Selct Data Table -->
SELECT * FROM your_table_name; 

<!-- Filter Data: WHERE event_type = 'purchase' LIMIT 10; -->
SELECT * FROM customers_enriched_clean_items WHERE event_type = 'purchase' LIMIT 10;


