class RemoveParentEventFromServiceEvents < ActiveRecord::Migration
  def up
    remove_column :service_events, :parent_event
    remove_column :service_events, :recurrent
  end

  def down
    add_column :service_events, :recurrent, :boolean
    add_column :service_events, :parent_event, :integer
  end
end
