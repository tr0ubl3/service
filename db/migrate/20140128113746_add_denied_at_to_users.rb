class AddDeniedAtToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :denied_at, :timestamp
  end

  def down
  	remove_column :users, :denied_at
  end
end
