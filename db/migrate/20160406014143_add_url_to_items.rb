class AddUrlToItems < ActiveRecord::Migration
  def change
    add_column :items, :url, :string

    add_column :item_specs, :deleted_at, :datetime
    add_column :item_specs, :status, :integer, default: 0
    add_index :item_specs, :deleted_at
  end
end