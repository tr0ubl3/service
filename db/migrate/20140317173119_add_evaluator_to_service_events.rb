class AddEvaluatorToServiceEvents < ActiveRecord::Migration
  def change
    add_column :service_events, :evaluator, :integer
  end
end
