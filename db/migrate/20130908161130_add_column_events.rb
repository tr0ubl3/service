class AddColumnEvents < ActiveRecord::Migration
  def up
  	add_column('events', 'alarm_code', :string )
  end

  def down
  	remove_column('events', 'alarm_code')
  end
end
