class CreateSolvingSteps < ActiveRecord::Migration
  def change
    create_table :solving_steps do |t|
      t.integer :service_event_id
      t.string :step

      t.timestamps
    end
  end
end
