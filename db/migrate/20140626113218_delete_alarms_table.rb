class DeleteAlarmsTable < ActiveRecord::Migration
  def up
  	drop_table :alarms
  end

  def down
  	create_table :alarms do |t|
      t.integer :number
      t.text :text

      t.timestamps
	  end
  end
end
