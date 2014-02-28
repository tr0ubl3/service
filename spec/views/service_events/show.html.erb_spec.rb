require 'spec_helper'

describe "service_events/show.html.erb" do
	# let!(:admin) { create(:user) }
	let!(:event) { create(:service_event) }
	
	before do
		# session[:user_id] = admin.id
		assign(:event, event)
		render
	end

	it "has h3 with event name" do
		expect(rendered).to have_selector("h3", text: "Event #{event.event_name}")
	end

	it "has table.event-rable" do
		expect(rendered).to have_selector("table.event-table")
	end

	it "has td with manufacturer name" do
		expect(rendered).to have_selector("td", text: "#{event.machine.manufacturer.name}")
	end

	it "has td with machine type" do
		expect(rendered).to have_selector("td", text: "#{event.machine.machine_type}")
	end

	it "has td with machine number" do
		expect(rendered).to have_selector("td", text: "#{event.machine.machine_number}")
	end

	it "has td with machine display name" do
		expect(rendered).to have_selector("td", text: "#{event.machine.display_name}")
	end

	it "has td with machine delivery date" do
		expect(rendered).to have_selector("td", text: "#{event.machine.delivery_date}")
	end

	it "has td with machine waranty period" do
		expect(rendered).to have_selector("td", text: "#{event.machine.waranty_boolean}")
	end

	it "has td with machine owner name" do
		expect(rendered).to have_selector("td", text: "#{event.machine.machine_owner.name}")
	end

	it "has td with machine owner address" do
		expect(rendered).to have_selector("td", text: "#{event.machine.machine_owner.address}")
	end

	it "has td with machine owner city" do
		expect(rendered).to have_selector("td", text: "#{event.machine.machine_owner.city}")
	end

	it "has td with machine postal code" do
		expect(rendered).to have_selector("td", text: "#{event.machine.machine_owner.postal_code}")
	end

	it "has td with event name" do
		expect(rendered).to have_selector("td", text: "#{event.event_name}")
	end

	it "has td with event date" do
		expect(rendered).to have_selector("td", text: "#{event.event_date}")
	end

	it "has td with event user full name" do
		expect(rendered).to have_selector("td", text: "#{event.user.full_name}")
	end

	it "has td with event type" do
		expect(rendered).to have_selector("td", text: "#{event_type(event)}")
	end

	context "the event doesn't have any alarms declared" do
		before do
			view.stub(:alarm_arr).and_return(nil)
			render
		end
		
		it "renders a td with text 'No alarms reported'" do
			expect(rendered).to have_content("No alarms reported")
		end
	end

	context "the event has at least one alarm reported" do

		context "the event has only one alarm reported" do
			let(:event) { create(:service_event) }
			let(:alarm) { create(:alarm) }
			
			before do
				assign(:event, event)
				render
			end

			it "renders only one td with alarm number & text" do
				expect(rendered).to have_selector("td", text: "#{alarm.number.to_s} - #{alarm.text}")
			end
		end

		context "the event has 5 alarms reported" do
			let!(:alarms) { create_list(:alarm, 4) }
			let!(:event) { create(:service_event) }
			
			before do
				event.stub(:alarms).and_return(alarms)
				render
			end

			it "renders 5 tds with alarms" do
				expect(rendered).to have_selector("td", text: "#{alarms.first.number.to_s} - #{alarms.first.text}", :count => 5)
			end
		end
	end

	it "has td with event_description" do
		expect(rendered).to have_selector("td", text: "#{event.event_description}")
	end
end