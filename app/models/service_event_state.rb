class ServiceEventState < ActiveRecord::Base
  attr_accessible :state
  belongs_to :service_event

  def self.with_last_state(state)
  	where("service_event_states.id IN (SELECT MAX(id) FROM service_event_states GROUP BY service_event_id)").where(:state => state)
  end
end