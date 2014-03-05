class AddRecursiveToServiceEvent < ActiveRecord::Migration
  def change
    add_column :service_events, :recursive, :boolean, default: false
  end
end
