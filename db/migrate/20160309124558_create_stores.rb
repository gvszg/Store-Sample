class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.integer :county_id, :town_id, :road_id
      t.integer :store_type
      t.string :store_code
      t.string :name, :address, :phone
      t.timestamps null: false
    end
  end
end