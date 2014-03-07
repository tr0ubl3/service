class CreateServiceEventFiles < ActiveRecord::Migration
  def change
    create_table :service_event_files do |t|
      t.string :file

      t.timestamps
    end
  end
end
