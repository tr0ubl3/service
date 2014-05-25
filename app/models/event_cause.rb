class EventCause < ActiveRecord::Base
  attr_accessible :cause

  belongs_to :service_event
end
