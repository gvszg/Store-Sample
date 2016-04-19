class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string :image
      t.string :slug
      t.integer :status, default: 0
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end