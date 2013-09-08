require 'spec_helper'

describe Event do
	let(:event) { Event.new }

	describe "validations" do
		before :each do
			@params = {
				event_date: "01.01.1900",
				hour_counter: "1234",
				event_type: "1",
				alarm_code: "700123",
				event_description: "machine has alarm 700123"
			}
		end
		it 'is invalid when event_date is empty' do
			@params[:event_date] = nil
			event = Event.new(@params)
			expect(event.valid?).to be_false
		end
		it 'is invalid when hour_counter is empty' do
			@params[:hour_counter] = nil
			event = Event.new(@params)
			expect(event.valid?).to be_false
		end
		it 'is invalid when event_type is empty' do
			@params[:event_type] = nil
			event = Event.new(@params)
			expect(event.valid?).to be_false
		end
		it 'is invalid when alarm_code is empty' do
			@params[:alarm_code] = nil
			event = Event.new(@params)
			expect(event.valid?).to be_false
		end
		it 'is invalid when event_description is empty' do
			@params[:event_description] = nil
			event = Event.new(@params)
			expect(event.valid?).to be_false
		end
		it 'is invalid when hour_counter < 3 chars'
		it 'is invalid when alarm_code < 6 chars'
		it 'is invalid when event_description < 3 chars'
		it "is invalid when date format it's not %d.%m.%y"
		it "is invalid when hour_counter it's not integer"
		it "is invalid when alarm code it's not integer"
		it "is invalid when event_description has only numbers or spaces"
	end

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
	it 'has alarm_code' do
		event.alarm_code = 700123
		expect(event.alarm_code).to eq(700123)
	end
end