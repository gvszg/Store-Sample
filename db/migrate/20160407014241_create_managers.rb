class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :username, :email, :password_digest
      t.integer :status, default: 0
      t.integer :position, default: 0
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :managers, :deleted_at
  end
end