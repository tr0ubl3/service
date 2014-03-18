class SolvingStep < ActiveRecord::Base
  attr_accessible :service_event_id, :step
  belongs_to :service_event
end
