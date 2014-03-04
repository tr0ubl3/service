require 'spec_helper'

describe ServiceEventState do
	let(:states) { ServiceEventState.new }

	it 'is an ActiveRecord model' do
		expect(ServiceEventState.superclass).to eq(ActiveRecord::Base)
	end

	it { should belong_to(:service_event) }

	it 'has state column' do
		states.state = 'open'
		expect(states.state).to eq("open")
	end	

	it { should allow_mass_assignment_of(:state) }	
end
