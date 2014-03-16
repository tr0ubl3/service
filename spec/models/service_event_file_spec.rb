require 'spec_helper'

describe ServiceEventFile do

	it { should belong_to(:service_event) }  
	it { should allow_mass_assignment_of(:file) }
	it { should allow_mass_assignment_of(:service_event_id) }
	it { should allow_value('image/png').for(:mime_type) }

	it "when new record is saved file_type is automaticaly set" do
		event = create(:service_event)
		file = File.open("app/assets/images/rails.png")
		ServiceEventFile.create(service_event_id: event.id, file: file)

		expect(ServiceEventFile.last.mime_type).to eq("image/png")
	end
end
