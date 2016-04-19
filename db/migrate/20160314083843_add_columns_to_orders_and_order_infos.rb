class AddColumnsToOrdersAndOrderInfos < ActiveRecord::Migration
  def change
    add_column :orders, :uid, :string
    add_column :orders, :ship_fee, :integer
    add_column :orders, :items_price, :integer
    add_column :order_infos, :ship_store_id, :integer
  end
end