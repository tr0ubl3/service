class ModifyEvents < ActiveRecord::Migration
  def up
  	add_column('events', 'hour_counter', :integer)
  end

  def down
  	remove_column('events', 'hour_counter')
  end
end
