class AddMachineOwnerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :machine_owner_id, :integer
    add_index :users, :machine_owner_id
  end
end
