class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_quantity
      t.string :item_name
      t.timestamps null: false
    end

    add_index :order_items, :order_id
  end
end