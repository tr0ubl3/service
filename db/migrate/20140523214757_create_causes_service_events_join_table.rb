class CreateCausesServiceEventsJoinTable < ActiveRecord::Migration
  def change
    create_table :event_causes_service_events, id: false do |t|
      t.integer :event_cause_id
      t.integer :service_event_id
    end
  end
end
