class AddIndexAndColunmToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :integer, default: 0
    add_column :orders, :payment_method, :string
    add_column :orders, :token, :string

    add_index :orders, :user_id
  end
end