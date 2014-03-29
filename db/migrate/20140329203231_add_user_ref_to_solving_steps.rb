class AddUserRefToSolvingSteps < ActiveRecord::Migration
  def change
    add_column :solving_steps, :user_id, :integer
  end
end
