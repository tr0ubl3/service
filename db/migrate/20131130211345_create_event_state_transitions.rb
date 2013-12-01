class CreateEventStateTransitions < ActiveRecord::Migration
  def change
    create_table :event_state_transitions do |t|
      t.references :event
      t.string :event
      t.string :from
      t.string :to
      t.timestamp :created_at
    end
    add_index :event_state_transitions, :event_id
  end
end
