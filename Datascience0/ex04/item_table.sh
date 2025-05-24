
read -p "Postgres Username: " PGUSER
read -sp "Postgres Password: " PGPASSWORD
echo
read -p "Database Name: " PGDATABASE

export PGPASSWORD

cd ./item

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
		product_id TEXT,
		category_id TEXT,
		category_code TEXT,
		brand TEXT
	);
EOF

	echo "Importing data into $tablename..."

	# PostgreSQL: import CSV-Data into the table
	# The CSV file is assumed to have a header row 
	psql -U "$PGUSER" -d "$PGDATABASE" -h localhost -c "\copy $tablename(product_id, category_id, category_code, brand) FROM '$(pwd)/$csvfile' DELIMITER ',' CSV HEADER;"

done
