class ModifyFirms < ActiveRecord::Migration
  def up
  	remove_column('firms', 'owner')
  	add_column('firms', 'type', :string)
  end

  def down
  	remove_column('firms', 'type')
  	add_column('firms', 'owner', :boolean, :default => false)
  end
end
