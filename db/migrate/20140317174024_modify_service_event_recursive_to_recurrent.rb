class ModifyServiceEventRecursiveToRecurrent < ActiveRecord::Migration
  def change
  	rename_column :service_events, :recursive, :recurrent
  end

  def down
  	rename_column :service_events, :recurrent, :recursive
  end
end
