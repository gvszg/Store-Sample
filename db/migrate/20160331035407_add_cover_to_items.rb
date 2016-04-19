class AddCoverToItems < ActiveRecord::Migration
  def change
    add_column :items, :cover, :string
  end
end