class ServiceEventFile < ActiveRecord::Base
	
  attr_accessible :file, :service_event_id
  belongs_to :service_event
  mount_uploader :file, EventEvaluationUploader

  # validates :file, :presence => true
end
