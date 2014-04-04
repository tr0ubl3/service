class RemoveMachineTypeFromMachines < ActiveRecord::Migration
  def up
  	remove_column :machines, :machine_type
  end

  def down
  	add_column :machines, :machine_type, :string
  end
end
