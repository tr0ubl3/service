class ServiceEventState < ActiveRecord::Base
  attr_accessible :state
  belongs_to :service_event
end
