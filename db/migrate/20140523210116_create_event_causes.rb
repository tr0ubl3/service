class CreateEventCauses < ActiveRecord::Migration
  def change
    create_table :event_causes do |t|
      t.string :cause
      t.integer :service_event_id
      
      t.timestamps
    end
  end
end
