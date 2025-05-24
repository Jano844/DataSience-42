-- Show all Tables
\dt

-- Create Table
CREATE TABLE personen (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  alter INTEGER,
  email TEXT
);

-- insert Info into the Table
INSERT INTO personen (name, alter, email)
VALUES
  ('Max Mustermann', 30, 'max@example.com'),
  ('Hans Muller', 25, 'test@gmail.com');

-- Show All Data from the table
SELECT * FROM personen;

-- Show one Collum
SELECT name, email FROM personen;

-- Filter
SELECT * FROM personen WHERE alter > 30;


-- Update something
UPDATE personen
SET email = 'neue_email@example.com'
WHERE name = 'Max Mustermann';

-- Delete something
DELETE FROM personen
WHERE name = 'Max Mustermann';

-- Delete Table
DROP TABLE personen;

