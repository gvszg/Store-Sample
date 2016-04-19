class AddColumnToOrderInfosAndOrderItems < ActiveRecord::Migration
  def change
    add_column :order_infos, :ship_store_code, :integer
    add_column :order_infos, :ship_phone, :string

    add_column :order_items, :item_price, :integer
  end
end