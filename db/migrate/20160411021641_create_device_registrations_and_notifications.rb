class CreateDeviceRegistrationsAndNotifications < ActiveRecord::Migration
  def change
    create_table :device_registrations do |t|
      t.integer :user_id
      t.string :registration_id
      t.timestamps
    end

    add_index :device_registrations, :user_id
    add_index :device_registrations, :registration_id

    create_table :notifications do |t|
      t.integer :item_id
      t.string :content_title
      t.string :content_text
      t.string :content_pic
      t.timestamps
    end

    add_index :notifications, :item_id
  end
end