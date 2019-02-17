class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.integer :seller_user_id
      t.text :seller_user_description
      t.integer :train_id
      t.integer :get_on_station_id
      t.integer :get_off_station_id
      t.integer :car_number
      t.integer :sheet_type
      t.integer :sheet_number
      t.integer :buyer_user_id

      t.timestamps
    end
  end
end
