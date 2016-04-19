class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :item_id
      t.string :image
      t.datetime :deleted_at
      t.timestamps
    end
  end
end