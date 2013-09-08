require 'spec_helper'

describe Event do
	let(:event) { Event.new }
	it 'is an ActiveRecord model' do
		expect(Event.superclass).to eq(ActiveRecord::Base)
	end

	it 'has machine_id' do
		event.machine_id = 1
		expect(event.machine_id).to eq(1)
	end

	it 'has event_date' do
		event.event_date = '01.01.1900'
		expect(event.event_date.strftime('%d.%m.%Y')).to eq('01.01.1900')		
	end

	it 'has event_type' do
		event.event_type = 'Machine stopped'
		expect(event.event_type).to eq('Machine stopped')
	end

	it 'has event_description' do
		event.event_description = 'Machine stopped with alarm 700123'
		expect(event.event_description).to eq('Machine stopped with alarm 700123')
	end

	it 'has hour_counter' do
		event.hour_counter = 1234
		expect(event.hour_counter).to eq(1234)
	end
end