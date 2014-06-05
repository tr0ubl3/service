class RenameCauseColumnToNameInEventCauses < ActiveRecord::Migration
  def up
  	rename_column :event_causes, :cause, :name
  end

  def down
  	rename_column :event_causes, :name, :cause
  end
end
