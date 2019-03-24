class RemoveConfirmationColumnFromSales < ActiveRecord::Migration[5.0]
  def change
    remove_column :sales, :confirmation, :integer
  end
end
