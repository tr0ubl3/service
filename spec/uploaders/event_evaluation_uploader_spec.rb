require 'spec_helper'
require 'carrierwave/test/matchers'

describe EventEvaluationUploader do
	include CarrierWave::Test::Matchers

let!(:service_event) { create(:service_event) }

	before do
		EventEvaluationUploader.enable_processing = true
	    @uploader = EventEvaluationUploader.new(service_event, :file)
	    @uploader.store!(File.open('app/assets/images/rails.png'))
	end

	after do
		EventEvaluationUploader.enable_processing = false
		@uploader.remove!
	end
end