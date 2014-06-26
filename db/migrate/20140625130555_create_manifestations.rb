class CreateManifestations < ActiveRecord::Migration
  def change
    create_table :manifestations do |t|
      t.integer :service_event_id
      t.integer :event_cause_id
      t.integer :symptom_id

      t.timestamps
    end
  end
end
