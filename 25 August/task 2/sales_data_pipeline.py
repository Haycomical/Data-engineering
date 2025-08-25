import os
import pandas as pd
from azure.storage.blob import BlobServiceClient

# Load CSV
raw_path = "data/sales_data.csv"
df = pd.read_csv(raw_path)

# Save raw data (unchanged)
raw_output = "raw_sales_data.csv"
df.to_csv(raw_output, index=False)

# Step 2: Remove duplicate rows based on order_id
df = df.drop_duplicates(subset=["order_id"])

# Step 3: Handle missing values
df["region"].fillna("Unknown", inplace=True)
df["revenue"].fillna(0, inplace=True)

# Step 4: Add calculated column profit_margin
df["profit_margin"] = df.apply(
    lambda row: (row["revenue"] - row["cost"]) / row["revenue"]
    if row["revenue"] != 0 else 0, axis=1
)

# Step 5: Categorize customers into segments
def categorize(revenue):
    if revenue > 100000:
        return "Platinum"
    elif revenue > 50000:
        return "Gold"
    else:
        return "Standard"

df["customer_segment"] = df["revenue"].apply(categorize)

# Step 6: Save processed data
processed_output = "processed_sales_data.csv"
df.to_csv(processed_output, index=False)

# Azure Blob Upload
account_name = os.getenv("AZURE_STORAGE_ACCOUNT_NAME")
account_key = os.getenv("AZURE_STORAGE_ACCOUNT_KEY")
container_name = os.getenv("AZURE_CONTAINER_NAME")

if account_name and account_key and container_name:
    try:
        conn_str = f"DefaultEndpointsProtocol=https;AccountName={account_name};AccountKey={account_key};EndpointSuffix=core.windows.net"
        blob_service_client = BlobServiceClient.from_connection_string(conn_str)

        for file in [raw_output, processed_output]:
            blob_client = blob_service_client.get_blob_client(container=container_name, blob=file)
            with open(file, "rb") as data:
                blob_client.upload_blob(data, overwrite=True)
        print("Files uploaded to Azure Blob Storage successfully.")
    except Exception as e:
        print("Blob upload failed:", str(e))
else:
    print("Azure storage environment variables not set. Skipping upload.")
