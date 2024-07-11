import pandas as pd

# Read CSV file
def read_csv(path):
    return pd.read_csv(path)

# Concat all branch dataframes to 1 dataframe
def concat_df(x, y):
    return pd.concat([x, y], ignore_index=True)

branch_a = read_csv('branch_a.csv')
branch_b = read_csv('branch_b.csv')
branch_c = read_csv('branch_c.csv')

print("Concat all branch dataframes to 1 dataframe...")
all_branch = concat_df(branch_a, branch_b)
all_branch = concat_df(all_branch, branch_c)
print(all_branch)
print()

# 1. Delete rows that have NaN on [transaction_id, date, customer_id] column
print("1. Delete rows that have NaN on [transaction_id, date, customer_id] column...")
all_branch.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)
print(all_branch)
print()

# 2. Change format date column to datetime type
print("2. Change format date column to datetime type...")
print(all_branch.dtypes['date'])
all_branch['date'] = pd.to_datetime(all_branch['date'])
print(all_branch.dtypes['date'])
print()

# 3. Delete duplicated rows in transaction_id column, persist the newest date
print("3. Delete duplicated rows in transaction_id column, persist the newest date...")
all_branch.sort_values('date', ascending=False, inplace=True)
all_branch.drop_duplicates(subset='transaction_id', keep='first', inplace=True)
print(all_branch)
print()

# 4. Count total sales each branch
print("4. Count total sales each branch...")
all_branch['total_sales'] = all_branch['quantity'] * all_branch['price']
total_sales_per_branch = all_branch.groupby('branch')['total_sales'].sum().reset_index()
# save to total_sales_per_branch.csv
total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)
print(total_sales_per_branch)
