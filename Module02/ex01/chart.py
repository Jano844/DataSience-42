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


# SELECT event_type, COUNT(*) as count --> count rows of event-type
# FROM customers_enriched_clean_items --> Choose Table
# GROUP BY event_type --> nach event_type Groupen
# ORDER BY count DESC --> In descending Order
# LIMIT 10; --> only the top 10 most 

query = """
SELECT event_time, customers.price as prices, user_id
FROM customers
WHERE event_type = 'purchase' 
ORDER BY event_time ASC
"""

# 3. load Data into Dataframe
df = pd.read_sql(query, conn)

# 4. close Connection
conn.close()


# Form Data
def first_chart():
    df_event_time = df[['event_time']]
    print(df_event_time.head(10))

    df_event_time['event_time'] = pd.to_datetime(df_event_time['event_time'])
    df_grouped = df_event_time.groupby(df_event_time['event_time'].dt.date).size() / 1000 # /1000 fuer bessere Angaben

    # 5. Start Plotting
    plt.figure(figsize=(15, 8))
    df_grouped.plot(kind='line', marker=None)

    plt.tight_layout()
    plt.xticks(rotation=45)
    plt.ylabel("Number of Customer in k")
    plt.grid(True)
    plt.plot()

    plt.savefig("chart.png")

def second_chart():
    df_prises = df.drop(columns=['user_id'])
    print(df_prises.head(10))

    monthly_total = df_prises.groupby(df_prises['event_time'].dt.to_period('M'))['prices'].sum()
    monthly_total = monthly_total / 1000000

    plt.figure(figsize=(10, 5))
    monthly_total.plot(kind='bar', color='skyblue')


    plt.title("")
    plt.xlabel("month")
    plt.xticks(ticks=[0, 1, 2, 3, 4], labels=['okt', 'nov', 'dez', 'jan', 'feb'], rotation=45)
    plt.yticks(ticks=[1, 2])
    plt.ylabel("total sales in million")

    plt.tight_layout()
    plt.show()

    plt.close()


def third_chart():
    df['event_time'] = pd.to_datetime(df['event_time'])

    daily_users = df.groupby(df['event_time'].dt.date)['user_id'].nunique()
    dayly_sum_prises = df.groupby(df['event_time'].dt.date)['prices'].sum()

    # print(daily_users.head(100))
    # print(dayly_sum_prises.head(100))

    dates = daily_users.index.to_numpy()
    prises = dayly_sum_prises.to_numpy()
    users = daily_users.to_numpy()
    
    plt.plot(dates, prises / users)
    plt.show()


# first_chart()
# second_chart()
third_chart()