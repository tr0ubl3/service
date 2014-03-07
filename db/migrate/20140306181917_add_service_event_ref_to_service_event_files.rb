class AddServiceEventRefToServiceEventFiles < ActiveRecord::Migration
  def change
    add_column :service_event_files, :service_event_id, :integer
  end
end
