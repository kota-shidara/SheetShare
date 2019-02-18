class CreateTrains < ActiveRecord::Migration[5.0]
  def change
    create_table :trains do |t|
      t.integer :line_id
      t.string :direction
      t.string :description

      t.timestamps
    end
  end
end
