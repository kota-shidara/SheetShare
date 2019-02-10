class AddDayTypeToTrains < ActiveRecord::Migration[5.0]
  def change
    add_column :trains, :day_type, :integer
  end
end
