class ModifyUsersForCustomAuthentification < ActiveRecord::Migration
  def up
  	remove_index :users, :email
    remove_index :users, :reset_password_token
  	remove_columns(:users, :nick, :encrypted_password, :reset_password_token,
  				 	:reset_password_sent_at, :remember_created_at, :sign_in_count,
  				 	:current_sign_in_at, :last_sign_in_at, :current_sign_in_at,
  				 	:current_sign_in_ip, :last_sign_in_ip)
  end

  def down
	add_column :users, :nick, :string
	add_column :users, :encrypted_password, :string, :null => false, :default => ''
	add_column :users, :reset_password_token, :string
	add_column :users, :reset_password_sent_at, :datetime
	add_column :users, :remember_created_at, :datetime
	add_column :users, :sign_in_count, :integer, :default => 0
	add_column :users, :current_sign_in_at, :datetime
	add_column :users, :last_sign_in_at, :datetime
	add_column :users, :current_sign_in_ip, :string
	add_column :users, :last_sign_in_ip, :string
  	add_index :users, :email, :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
