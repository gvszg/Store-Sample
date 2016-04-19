class AddCreatedOnToOrders < ActiveRecord::Migration
  def up
    add_column :orders, :created_on, :date
  end

  def down
    remove_column :orders, :created_on
  end
end