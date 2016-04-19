class CreateItemSpecs < ActiveRecord::Migration
  def change
    create_table :item_specs do |t|
      t.integer :item_id
      t.string :style
      t.integer :style_amount
      t.string :style_pic
      t.timestamps
    end

    add_index :item_specs, :item_id
  end  
end