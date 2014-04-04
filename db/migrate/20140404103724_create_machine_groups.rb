class CreateMachineGroups < ActiveRecord::Migration
  def change
    create_table :machine_groups do |t|
      t.string :name
      t.string :type
      t.integer :manufacturer_id

      t.timestamps
    end
  end
end
