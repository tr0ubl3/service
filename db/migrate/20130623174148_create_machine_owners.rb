class CreateMachineOwners < ActiveRecord::Migration
  def change
    create_table :machine_owners do |t|
      t.string "name"
      t.string "address"
      t.string "office_tel"
      t.string "office_mail"
      t.timestamps
    end
  end
end
