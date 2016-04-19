class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, :real_name
      t.string :gender, :address, :uid
      t.integer :phone
      t.integer :status, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end