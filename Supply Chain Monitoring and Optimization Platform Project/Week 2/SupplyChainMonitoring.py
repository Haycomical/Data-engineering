import pandas as pd
import numpy as np
import requests

df = pd.read_json('supply_chain.json')

df['delivery_date'] = pd.to_datetime(df['delivery_date'])
df['delay_days'] = (pd.Timestamp.today() - df['delivery_date']).dt.days
df['is_delayed'] = np.where(df['delay_days'] > 0, 1, 0)

print("Processed Supply Chain Data:")
print(df[['order_id', 'supplier_id', 'delay_days', 'is_delayed']].head())

df.to_csv('cleaned_supply_chain.csv', index=False)