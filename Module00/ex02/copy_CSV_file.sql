\copy data_2022_dec(
	event_time,
	event_type,
	product_id,
	price,
	user_id,
	user_session
) FROM '/home/jan/Downloads/subject/customer/data_2022_dec.csv' DELIMITER ',' CSV HEADER;

\copy data_2022_nov(
	event_time,
	event_type,
	product_id,
	price,
	user_id,
	user_session
) FROM '/home/jan/Downloads/subject/customer/data_2022_nov.csv' DELIMITER ',' CSV HEADER;

\copy data_2022_oct(
	event_time,
	event_type,
	product_id,
	price,
	user_id,
	user_session
) FROM '/home/jan/Downloads/subject/customer/data_2022_oct.csv' DELIMITER ',' CSV HEADER;

\copy data_2023_jan(
	event_time,
	event_type,
	product_id,
	price,
	user_id,
	user_session
) FROM '/home/jan/Downloads/subject/customer/data_2023_jan.csv' DELIMITER ',' CSV HEADER;
