#!/bin/bash

# This script creates a PostgreSQL table for each CSV file in the current directory
# get all PostgreSQL connection parameters from the user
read -p "Postgres Username: " PGUSER
read -sp "Postgres Password: " PGPASSWORD
echo
read -p "Database Name: " PGDATABASE

export PGPASSWORD

cd ./customer

# For each CSV file in the current directory
for csvfile in *.csv; do
	# extract the table name from the CSV file name
	tablename=$(basename "$csvfile" .csv)

	echo "Creating table $tablename..."

	# PostgreSQL: create table
	# Drop the table if it exists and create a new one
	# The table structure is based on the CSV file
	psql -U "$PGUSER" -d "$PGDATABASE" -h localhost <<EOF
	DROP TABLE IF EXISTS $tablename;
	CREATE TABLE $tablename (
		event_time TIMESTAMPTZ,
		event_type VARCHAR(255),
		product_id BIGINT,
		price NUMERIC(10,2),
		user_id BIGINT,
		user_session UUID
	);
EOF

	echo "Importing data into $tablename..."

	# PostgreSQL: import CSV-Data into the table
	# The CSV file is assumed to have a header row 
	psql -U "$PGUSER" -d "$PGDATABASE" -h localhost -c "\copy $tablename(event_time, event_type, product_id, price, user_id, user_session) FROM '$(pwd)/$csvfile' DELIMITER ',' CSV HEADER;"

done
