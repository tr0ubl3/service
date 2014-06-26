class Manifestation < ActiveRecord::Base
  attr_accessible :service_event_id, :event_cause_id, :symptom_id
  
  belongs_to :service_event
  belongs_to :event_cause
  belongs_to :symptom
end
