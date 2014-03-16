class ServiceEventFile < ActiveRecord::Base
	
  attr_accessible :file, :service_event_id
  belongs_to :service_event
  mount_uploader :file, EventEvaluationUploader
  before_create :set_mime_type
  # validates :file, :presence => true


  private
	def set_mime_type
		self.mime_type = Mime::Type.lookup_by_extension(File.extname(self.file.filename.to_s)[1..-1]).to_s
	end
end
