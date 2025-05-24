CREATE TABLE data_2022_dec (
	event_time TIMESTAMPTZ,         -- Timestamp with Time Zone
	event_type VARCHAR(255),
	product_id BIGINT,
	price NUMERIC(10,2),
	user_id BIGINT,
	user_session UUID
);

\copy data_2022_dec(
	event_time,
	event_type,
	product_id,
	price,
	user_id,
	user_session
) FROM '/home/jan/Downloads/subject/customer/data_2022_dec.csv' DELIMITER ',' CSV HEADER;

