class AddMachineGroupIdToAlarms < ActiveRecord::Migration
  def change
    add_column :alarms, :machine_group_id, :integer
  end
end
