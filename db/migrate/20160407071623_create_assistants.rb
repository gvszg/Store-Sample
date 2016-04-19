class CreateAssistants < ActiveRecord::Migration
  def change
    create_table :assistants do |t|
      t.string :username, :email, :password_digest
      t.integer :status, default: 0
      t.integer :position, default: 0
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :assistants, :deleted_at
  end
end