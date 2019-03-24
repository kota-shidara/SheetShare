class AddTransactionNumberToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :transaction_number, :integer
  end
end
