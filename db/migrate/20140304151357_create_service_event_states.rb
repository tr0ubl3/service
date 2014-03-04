class CreateServiceEventStates < ActiveRecord::Migration
  def change
    create_table :service_event_states do |t|
			t.belongs_to :service_event		    				
			t.string :state

      t.timestamps
    end

    add_index :service_event_states, :service_event_id
  end
end
