class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.integer "manufacturer_id"
      t.integer "machine_owner_id" 
      t.string "machine_number"
      t.string "machine_type"
      t.date "delivery_date"
      t.integer "waranty_period"
      t.string "display_name"
      t.timestamps
    end
    add_index("machines", "manufacturer_id")
    add_index("machines", "machine_owner_id")
  end
end
