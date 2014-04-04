class RenameColumnTypeOnMachineGroupToMachineType < ActiveRecord::Migration
  def up
  	rename_column :machine_groups, :type, :machine_type
  end

  def down
  	rename_column :machine_groups, :machine_type, :type
  end
end
