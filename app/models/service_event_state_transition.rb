class ServiceEventStateTransition < ActiveRecord::Base
  belongs_to :service_event
  attr_accessible :created_at, :event, :from, :to
end
