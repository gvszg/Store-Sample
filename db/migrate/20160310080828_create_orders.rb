class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, :total
      t.integer :total, default: 0
      t.boolean :is_paid, default: false
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end