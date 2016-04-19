class AddLatAndLngToStores < ActiveRecord::Migration
  def change
    add_column :stores, :lat, :float
    add_column :stores, :lng, :float
  end
end