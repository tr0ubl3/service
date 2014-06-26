class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.string :number
      t.text :description
      t.integer :machine_group_id
      t.string :type

      t.timestamps
    end
  end
end
