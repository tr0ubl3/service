class RemoveManufacturerIdFromMachine < ActiveRecord::Migration
  def up
  	remove_column :machines, :manufacturer_id
  end

  def down
  	add_column :machines, :manufacturer_id, :integer
  end
end
