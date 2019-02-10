class ChangeLineIdToTrainLineId < ActiveRecord::Migration[5.0]
  def change
    add_column :trains, :train_line_id, :integer
    add_column :stations, :train_line_id, :integer
    remove_column :trains, :line_id, :integer
    remove_column :stations, :line_id, :integer
  end
end
