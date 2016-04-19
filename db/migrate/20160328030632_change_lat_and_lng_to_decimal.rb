class ChangeLatAndLngToDecimal < ActiveRecord::Migration
  def up
    change_column :stores, :lat, :decimal, precision: 9, scale: 7
    change_column :stores, :lng, :decimal, precision: 10, scale: 7
  end

  def down
    change_column :stores, :lat, :float
    change_column :stores, :lng, :float
  end
end