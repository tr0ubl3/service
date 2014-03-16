class AddMimeTypeToServiceEventFiles < ActiveRecord::Migration
  def change
    add_column :service_event_files, :mime_type, :string
  end
end
