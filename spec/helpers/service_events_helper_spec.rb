require 'spec_helper'

describe ServiceEventsHelper do

	describe "#event_type" do
		context "event type is 1" do
			let(:event) { create(:service_event, event_type: 1) }
			it "returns 'Machine fully stopped' when event type is 1" do
				expect(helper.event_type(event)).to have_content("Machine fully stopped")
			end
		end

		context "event type is 2" do
			let(:event) { create(:service_event, event_type: 2) }
			it "returns 'Machine is working with problems' when event type is 1" do
				expect(helper.event_type(event)).to have_content("Machine is working with problems")
			end
		end

		context "event type is 3" do
			let(:event) { create(:service_event, event_type: 3) }
			it "returns 'Event unrelated to machine stopping' when event type is 1" do
				expect(helper.event_type(event)).to have_content("Event unrelated to machine stopping")
			end
		end
	end

end