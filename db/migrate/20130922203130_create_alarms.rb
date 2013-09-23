class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.integer :number
      t.text :text

      t.timestamps
    end
  end
end
