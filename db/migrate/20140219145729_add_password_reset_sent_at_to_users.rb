class AddPasswordResetSentAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_sent_at, :timestamp
  end
end
