class ModifyUserEventTypeToInteger < ActiveRecord::Migration
  def up
  	change_column :service_events, :event_type, :integer, :limit => 1
  end

  def down
  	change_column :service_events, :event_type, :string
  end
end
