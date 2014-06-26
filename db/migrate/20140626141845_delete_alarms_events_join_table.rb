class DeleteAlarmsEventsJoinTable < ActiveRecord::Migration
  def up
  	drop_table :alarms_events
  end

  def down
  	create_table :alarms_events, :id => false do |t|
  		t.belongs_to :event
  		t.belongs_to :alarm
  	end
  	add_index :alarms_events, ["event_id", "alarm_id"]
  end
end
