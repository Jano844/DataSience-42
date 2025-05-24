CREATE TABLE data_2022_dec (
	event_time TIMESTAMPTZ,         -- Timestamp with Time Zone
	event_type VARCHAR(255),
	product_id BIGINT,
	price NUMERIC(10,2),
	user_id BIGINT,
	user_session UUID
);

CREATE TABLE data_2022_nov (
	event_time TIMESTAMPTZ,
	event_type VARCHAR(255),
	product_id BIGINT,
	price NUMERIC(10,2),
	user_id BIGINT,
	user_session UUID
);

CREATE TABLE data_2022_oct (
	event_time TIMESTAMPTZ,
	event_type VARCHAR(255),
	product_id BIGINT,
	price NUMERIC(10,2),
	user_id BIGINT,
	user_session UUID
);

CREATE TABLE data_2023_jan (
	event_time TIMESTAMPTZ,
	event_type VARCHAR(255),
	product_id BIGINT,
	price NUMERIC(10,2),
	user_id BIGINT,
	user_session UUID
);


-- with using the loop --> no Copy Paste
DO $$
DECLARE
	tablename TEXT;
	tablenames TEXT[] := ARRAY['data_2022_dec', 'data_2022_nov', 'data_2022_oct', 'data_2023_jan'];
BEGIN
	FOREACH tablename IN ARRAY tablenames
	LOOP
		EXECUTE format('
			CREATE TABLE %I (
				event_time TIMESTAMPTZ,
				event_type VARCHAR(255),
				product_id BIGINT,
				price NUMERIC(10,2),
				user_id BIGINT,
				user_session UUID
			);', tablename);
	END LOOP;
END
$$;
