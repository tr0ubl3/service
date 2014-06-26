class DeleteEventCausesServiceEvents < ActiveRecord::Migration
  def up
  	drop_table :event_causes_service_events
  end

  def down
  	create_table :event_causes_service_events, id: false do |t|
      t.integer :event_cause_id
      t.integer :service_event_id
    end
  end
end
