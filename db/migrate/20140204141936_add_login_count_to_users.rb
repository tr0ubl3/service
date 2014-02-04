class AddLoginCountToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :login_count, :integer, :default => 0
  end

  def down
  	remove_column :users, :login_count
  end
end
