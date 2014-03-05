class ServiceEventState < ActiveRecord::Base
  attr_accessible :state
  belongs_to :service_event

  def self.with_last_state(state)
  	order("id desc").group("service_event_id").having(state: state)
  end
end
