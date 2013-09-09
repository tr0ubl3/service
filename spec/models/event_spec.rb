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
			event = Event.new(@params)
		end
		it 'is invalid when machine_id is empty' do
			@params[:machine_id] = nil
			expect(event.valid?).to be_false
		end
		it 'is invalid when event_date is empty' do
			@params[:event_date] = nil
			expect(event.valid?).to be_false
		end
		it 'is invalid when hour_counter is empty' do
			@params[:hour_counter] = nil
			expect(event.valid?).to be_false
		end
		it 'is invalid when event_type is empty' do
			@params[:event_type] = nil
			expect(event.valid?).to be_false
		end
		it 'is invalid when event_description is empty' do
			@params[:event_description] = nil
			expect(event.valid?).to be_false
		end
		it 'is invalid when hour_counter < 3 chars' do
			@params[:hour_counter] = 12
			expect(event.valid?).to be_false
		end
		it 'is invalid when alarm_code < 6 chars' do
			@params[:alarm_code] = 12
			expect(event.valid?).to be_false
		end
		it 'is invalid when event_description < 3 chars' do
			@params[:event_description] = 'ma'
			expect(event.valid?).to be_false
		end
		it "is invalid when hour_counter it's not a number" do
			@params[:hour_counter] = '123a'
			expect(event.valid?).to be_false
			# puts event.errors.full_messages
		end
		it "is invalid when alarm_code it's not integer" do
			@params[:alarm_code] = 'aaaaaa'
			expect(event.valid?).to be_false
			# puts event.errors.full_messages
		end
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