class RenameUsersTokenToAuthToken < ActiveRecord::Migration
  def up
  	rename_column :users, :token, :auth_token
  end

  def down
  	rename_column :users, :auth_token, :token
  end
end
