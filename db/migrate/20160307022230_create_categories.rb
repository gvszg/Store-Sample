class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.integer :status, default: 0
      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :item_categories do |t|
      t.integer :item_id, :category_id
      t.datetime :deleted_at
      t.timestamps null: false
    end

    add_index :items, :deleted_at
    add_index :categories, :deleted_at
    add_index :item_categories, :deleted_at
    add_index :item_categories, :item_id
    add_index :item_categories, :category_id
  end
end