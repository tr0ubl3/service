class ConvergeManufacturersOwners < ActiveRecord::Migration
  def up
  	rename_table('manufacturers', 'firms')
  	add_column("firms", "owner", :boolean, :default => false)
  end

  def down
  	rename_table('firms', 'manufacturers')
  	remove_column("firms", "owner")
  end
end
