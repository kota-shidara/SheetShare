class AddColumnToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :confirmation, :integer
  end
end
