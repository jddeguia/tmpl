import duckdb
import pandas as pd

# Path to your DuckDB database (DBT defaults to target/database.duckdb)
db_path = '/home/jddeguia/temple/temple_project/dev.duckdb'

# Connect to DuckDB
con = duckdb.connect(database=db_path, read_only=False)

# List of mart tables you want to export
mart_tables = [
    'mart_avg_order_value_by_nps',
    'mart_daily_promoter_ratio',
    'mart_nps_opportunities',
    'mart_nps_trend_by_state_customer',
    'mart_nps_trends',
    'mart_order_summary',
    'mart_product_category_performance'
]

# Loop through tables and export each to CSV
for table in mart_tables:
    # Read the table into a pandas DataFrame
    df = con.execute(f"SELECT * FROM {table}").df()
    
    # Export to CSV
    csv_file = f"{table}.csv"
    df.to_csv(csv_file, index=False)
    print(f"Exported {table} to {csv_file}")

# Close connection
con.close()
