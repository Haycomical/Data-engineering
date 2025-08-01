import pandas as pd
import numpy as np


df = pd.read_csv('orders.csv')

df['deliverydate'] = pd.to_datetime(df['deliverydate'])

df['delay_days'] = (pd.Timestamp.today() - df['deliverydate']).dt.days
df['delayed'] = np.where(df['delay_days'] > 0, 1, 0)

delay_summary = df.groupby('customerid')['delayed'].sum().sort_values(ascending=False)
print("Top delayed customers:")
print(delay_summary)

df.to_csv('cleaned_orders.csv', index=False)
