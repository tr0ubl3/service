class DeleteServiceEventAlarmJoinTable < ActiveRecord::Migration
  def up
  	drop_table :alarms_service_events
  end

  def down
  	create_table :alarms_service_events, :id => false do |t|
  		t.belongs_to :service_event
  		t.belongs_to :alarm
  	end
  	add_index :alarms_service_events, ["service_event_id", "alarm_id"]
  end
end
