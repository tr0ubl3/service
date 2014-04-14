class ModifyNumberFromAlarms < ActiveRecord::Migration
  def up
  	remove_column :alarms, :number
  	add_column :alarms, :number, :string
  	add_index(:alarms, [:number, :machine_group_id], :unique => true)
  end

  def down
  	remove_column :alarms, :number
  	add_column :alarms, :number, :integer
  	remove_index :alarms, column: [:number, :machine_group_id]
  end
end