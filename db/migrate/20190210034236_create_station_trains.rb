class CreateStationTrains < ActiveRecord::Migration[5.0]
  def change
    create_table :station_trains do |t|
      t.integer :train_id
      t.integer :station_id
      t.time :departure_time

      t.timestamps
    end
  end
end
