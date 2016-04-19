class AddSourceItemIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :source_item_id, :integer

    add_index :order_items, :source_item_id
  end  
end