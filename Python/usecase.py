#top 3 stores with highest sales
import pandas as pd

data = pd.read_csv('Python/sales_2024-09-01.csv')

#print(data.head())

top_stores = data.groupby(['store_id', 'store_name'])['dollar_sales'].sum().nlargest(3)
print(top_stores)