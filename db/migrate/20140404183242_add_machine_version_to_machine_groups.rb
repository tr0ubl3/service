class AddMachineVersionToMachineGroups < ActiveRecord::Migration
  def change
    add_column :machine_groups, :version, :string
  end
end
