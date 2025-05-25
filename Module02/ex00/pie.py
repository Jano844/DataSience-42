import psycopg2
import pandas as pd
import matplotlib.pyplot as plt

# 1. Cennect to Database
conn = psycopg2.connect(
    host="localhost",
    port=5432,
    database="db",
    user="jano",
    password="test"
)

# 2. SQL-request: (filter for Kategory or size)

# SELECT event_type, COUNT(*) as count --> count rows of event-type
# FROM customers_enriched_clean_items --> Choose Table
# GROUP BY event_type --> nach event_type Groupen
# ORDER BY count DESC --> In descending Order
# LIMIT 10; --> only the top 10 most 

query = """
SELECT event_type, COUNT(*) as count
FROM customers_enriched_clean_items
GROUP BY event_type
ORDER BY count DESC
LIMIT 10;
"""

# 3. load Data into Dataframe
df = pd.read_sql(query, conn)

# 4. close Connection
conn.close()

# print(df)
all_count: int = 0
for index, row in df.iterrows():
    #  print(f"Index: {index}, Event: {row['event_type']}, Count: {row['count']}")
     all_count = all_count + int(row['count'])

# print Percentages
per = [round((count / all_count) * 100, 2) for count in df['count']]
print(per)


# 5. create Pie Chart
labels = df['event_type']
sizes = df['count']

plt.figure(figsize=(8, 8))
plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=140)
plt.axis('equal')

plt.savefig("pie.png")
