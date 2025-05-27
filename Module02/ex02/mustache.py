import psycopg2
import pandas as pd
import matplotlib.pyplot as plt
import statistics
import numpy as np


def load_data_of_user_id_and_prises(table_name: str, event_type: str) -> pd.DataFrame:

    conn = psycopg2.connect(
        host="localhost",
        port=5432,
        database="db",
        user="jano",
        password="test"
    )

    query = f"""
    SELECT {table_name}.user_id AS id, {table_name}.price as price
    FROM {table_name}
    WHERE event_type = '{event_type}'
    ORDER BY event_time ASC
    """

    df = pd.read_sql(query, conn)
    conn.close()
    return df


def load_data_collumn(table_name: str, column_name: str, alias: str):
    """
    Load Data takes 2 Strings:
    1. The collum name of the Database
    2. The alias name it has in the Dataframe

    It returns the Requested Collum

    Only if the Item was purchesed and
    Orderd by the Event_time

    """
    conn = psycopg2.connect(
        host="localhost",
        port=5432,
        database="db",
        user="jano",
        password="test"
    )

    query = f"""
    SELECT {column_name} AS {alias}
    FROM {table_name}
    WHERE event_type = 'purchase'
    ORDER BY event_time ASC
    """

    df = pd.read_sql(query, conn)
    conn.close()
    return df

def show_statistics(df):
    
    # prises = df['prises'].unique()
    prises = df['prises'].to_numpy()

    print(f"count:       {round(sum(prises), 2)}")
    print(f"mean:        {round(statistics.mean(prises), 2)}")
    print(f"std:         {round(statistics.stdev(prises), 2)}")
    print(f"median:      {round(statistics.median(prises), 2)}")
    print(f"min:         {round(min(prises), 2)}")
    print(f"25%:         {round(np.percentile(prises, 25), 2)}")
    print(f"50%:         {round(np.percentile(prises, 50), 2)}")
    print(f"75%:         {round(np.percentile(prises, 75), 2)}")
    print(f"max:         {round(max(prises), 2)}")

    
def shwo_box_plot(df):
    prises = df['prises'].to_numpy()

    plt.boxplot(prises, orientation="horizontal")
    plt.show()
    plt.close()


def average_basket_prise_per_user():
    # Liste von der Summe aller Prese von User im Basket

    # Liste aller User mit event_type cart

    # Group By User_ID

    # Sum up all Prises





    # Liste von von der Summe aller Prese aller entfernten Items von User

    # Liste aller User mit event_type remove from cart

    # Group By User_ID

    # Sum up all Prises




    #--> for user in First List 
    # if user in second list
    # prises [first list] - prises[second list]

    pass


def main():
    df = load_data_collumn("customers", "customers.price", "prises")
    show_statistics(df)
    shwo_box_plot(df)
    pass


if __name__ == "__main__":
    main()