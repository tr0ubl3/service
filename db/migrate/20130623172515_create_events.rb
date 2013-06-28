class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer "machine_id"
      t.date "event_date"
      t.string "event_type"
      t.text "event_description"
      t.timestamps
    end
    add_index("events", "machine_id")
  end
end
