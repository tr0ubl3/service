class ServiceEventState < ActiveRecord::Base
  attr_accessible :state
  belongs_to :service_event

  def self.with_last_state
  	order("id desc")
  end
end
