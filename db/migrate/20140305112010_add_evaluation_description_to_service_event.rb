class AddEvaluationDescriptionToServiceEvent < ActiveRecord::Migration
  def change
    add_column :service_events, :evaluation_description, :text
  end
end
