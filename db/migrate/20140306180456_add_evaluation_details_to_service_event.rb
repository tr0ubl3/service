class AddEvaluationDetailsToServiceEvent < ActiveRecord::Migration
  def change
    add_column :service_events, :parent_event, :integer
  end
end
