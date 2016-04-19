class AddRememberTokenToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :remember_token, :string
  end
end