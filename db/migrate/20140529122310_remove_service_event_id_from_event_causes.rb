class RemoveServiceEventIdFromEventCauses < ActiveRecord::Migration
  def up
    remove_column :event_causes, :service_event_id
  end

  def down
    add_column :event_causes, :service_event_id, :integer
  end
end
