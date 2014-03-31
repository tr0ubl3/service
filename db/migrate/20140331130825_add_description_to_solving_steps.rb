class AddDescriptionToSolvingSteps < ActiveRecord::Migration
  def change
    add_column :solving_steps, :description, :text
  end
end
