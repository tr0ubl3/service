class ModifyEvent < ActiveRecord::Migration
  def up
  	rename_column('events', 'alarm_code', 'event_name')
  end

  def down
  	rename_column('events', 'event_name', 'alarm_code')
  end
end
