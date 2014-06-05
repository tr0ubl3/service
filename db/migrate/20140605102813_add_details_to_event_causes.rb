class AddDetailsToEventCauses < ActiveRecord::Migration
  def change
    add_column :event_causes, :type, :string
    add_column :event_causes, :category, :string
    add_column :event_causes, :problem, :string
  end
end
