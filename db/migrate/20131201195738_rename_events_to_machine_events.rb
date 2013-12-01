class RenameEventsToMachineEvents < ActiveRecord::Migration
  def up
  	remove_index :events, column: :machine_id
  	remove_index :alarms_events, column: [:event_id, :alarm_id]
  	remove_index :events, column: :state
  	remove_index :event_state_transitions, column: :event_id
  	rename_column :alarms_events, :event_id, :service_event_id
  	rename_column :event_state_transitions, :event_id, :service_event_id
  	rename_table :events, :service_events
  	rename_table :alarms_events, :alarms_service_events
  	rename_table :event_state_transitions, :service_event_state_transitions
  end

  def down
  	rename_table :service_events, :events
  	rename_table :alarms_service_events, :alarms_events
  	rename_table :service_event_state_transitions, :event_state_transitions
  	rename_column :alarms_events, :service_event_id, :event_id
  	rename_column :event_state_transitions, :service_event_id, :event_id
  	add_index :events, :machine_id
  	add_index :alarms_events, ["event_id", "alarm_id"]
  	add_index :events, :state
  	add_index :event_state_transitions, :event_id
  end
end
