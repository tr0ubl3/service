class ChangeNameToMachiningTypeInMachineGroups < ActiveRecord::Migration
  def up
  	rename_column :machine_groups, :name, :machining_type
  end

  def down
  	rename_column :machine_groups, :machining_type, :name
  end
end
