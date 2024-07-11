import pandas as pd

# Membaca file CSV
branch_a = pd.read_csv('branch_a.csv')
branch_b = pd.read_csv('branch_b.csv')
branch_c = pd.read_csv('branch_c.csv')

# Menggabungkan semua file CSV menjadi satu DataFrame
all_branch = pd.concat([branch_a, branch_b, branch_c])

# # Menghapus baris yang memiliki nilai NaN pada kolom transaction_id, date, dan customer_id
# all_branch.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)

# # Mengubah format kolom date menjadi tipe datetime
# all_branch['date'] = pd.to_datetime(all_branch['date'])

# # Menghilangkan duplikat berdasarkan transaction_id, pilih data berdasarkan date terbaru
# all_branch.sort_values('date', ascending=False, inplace=True)
# all_branch.drop_duplicates(subset='transaction_id', keep='first', inplace=True)

# # Menghitung total penjualan per cabang
# all_branch['total_sales'] = all_branch['quantity'] * all_branch['price']
# total_sales_per_branch = all_branch.groupby('branch')['total_sales'].sum().reset_index()

# # Menyimpan hasil ke file baru total_sales_per_branch.csv
# total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)
