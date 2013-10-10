class CreateEventsAlarmsJoin < ActiveRecord::Migration
  def up
  	create_table :events_alarms, :id => false do |t|
  		t.integer "event_id"
  		t.integer "alarm_id"
  	end
  	add_index :events_alarms, ["event_id", "alarm_id"]
  end

  def down
  	drop_table :events_alarms
  end
end
