class Manifestation < ActiveRecord::Base
  attr_accessible :service_event_id, :symptom_id
  
  belongs_to :service_event
  belongs_to :symptom
end
