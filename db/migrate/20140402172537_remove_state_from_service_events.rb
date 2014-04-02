class RemoveStateFromServiceEvents < ActiveRecord::Migration
  def up
  	remove_column :service_events, :state
  end

  def down
  	add_column :service_events, :state, :string
  end
end
