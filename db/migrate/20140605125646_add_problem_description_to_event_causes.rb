class AddProblemDescriptionToEventCauses < ActiveRecord::Migration
  def change
    add_column :event_causes, :problem_description, :text
  end
end
