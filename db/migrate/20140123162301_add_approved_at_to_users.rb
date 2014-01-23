class AddApprovedAtToUsers < ActiveRecord::Migration
 def up
  	add_column :users, :approved_at, :timestamp
  end

  def down
  	remove_column :users, :approved_at
  end
end
