class AddShipStoreNameToOrderInfos < ActiveRecord::Migration
  def change
    add_column :order_infos, :ship_store_name, :string
  end
end