class DeleteMachineOwners < ActiveRecord::Migration
  def up
  	drop_table :machine_owners
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
