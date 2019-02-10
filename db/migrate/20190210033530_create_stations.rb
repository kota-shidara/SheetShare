class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.integer :line_id
      t.string :name

      t.timestamps
    end
  end
end
