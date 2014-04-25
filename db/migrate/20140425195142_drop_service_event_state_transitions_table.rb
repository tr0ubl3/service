class DropServiceEventStateTransitionsTable < ActiveRecord::Migration
  def up
  	drop_table :service_event_state_transitions
  end

  def down
  	create_table :service_event_state_transitions do |t|
      t.references :event
      t.string :event
      t.string :from
      t.string :to
      t.timestamp :created_at
    end
    add_index :service_event_state_transitions, :event_id
  end
end
