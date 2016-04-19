class AddIndexToOrdersAndPhotos < ActiveRecord::Migration
  def change
    add_index :orders, :deleted_at
    add_index :users, :deleted_at
    add_index :photos, :deleted_at
  end
end