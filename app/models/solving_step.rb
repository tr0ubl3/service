class SolvingStep < ActiveRecord::Base
	attr_accessible :service_event_id, :step, :created_at, :description,:user_id
	belongs_to :service_event
	belongs_to :user
  
	validates :step, :presence => true
end
