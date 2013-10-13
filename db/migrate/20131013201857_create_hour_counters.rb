class CreateHourCounters < ActiveRecord::Migration
  def change
    create_table :hour_counters do |t|
      t.belongs_to :machine
      t.integer	"machine_hours_age"
      t.timestamps
    end
  end
end
