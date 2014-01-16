class ModifyUsersForCustomAuthentification < ActiveRecord::Migration
  def change
  	remove_index :users, :email
    remove_index :users, :reset_password_token
  	remove_columns(:users, :nick, :encrypted_password, :reset_password_token,
  				 	:reset_password_sent_at, :remember_creatd_at, :sign_in_count,
  				 	:current_sign_in_at, :last_sign_in_at, :current_sign_in_at,
  				 	:current_sign_in_ip, :last_sign_in_ip)
  end
end
