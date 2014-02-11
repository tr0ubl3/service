class ModifyUsersMachineOwnerIdToFirmId < ActiveRecord::Migration
  def up
  	rename_column :users, :machine_owner_id, :firm_id
  	add_index :users, :firm_id
  	remove_index :users, :machine_owner_id
  end

  def down
  	rename_column :users, :firm_id, :machine_owner_id
  	remove_index :users, :firm_id
  	add_index :users, :machine_owner_id
  end
end
