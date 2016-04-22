class AddShipEmailToOrderInfo < ActiveRecord::Migration
  def change
    add_column :order_infos, :ship_email, :string
  end
end