class SolvingStep < ActiveRecord::Base
	attr_accessible :service_event_id, :step, :created_at
	belongs_to :service_event
  
	validates :step, :presence => true
end
