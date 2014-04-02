require 'spec_helper'

describe ApplicationHelper do

	describe "#pending_users" do
		let(:user) { create(:user2) }
		before :each do
			@pending_number = User.where(:approved_at => nil).count
		end

		it "it returns number of users that are pending confirmation" do
			expect(helper.pending_users).to eq(@pending_number)
		end
	end

	describe "#pending_events" do
		let!(:service_event) { create(:service_event) }

		it "returns the number of all unconfirmed events" do
			ServiceEvent.destroy_all
			expect(helper.pending_events).to eq(0)
		end

		it "returns number of unconfirmed events for one machine" do
			machine = create(:machine)
			expect(helper.pending_events(machine)).to eq(0)
		end
	end

	describe "#date_format" do
		let(:time_stamp) { Time.now }
		context "date format with no option passed" do
			it "formats the time stamp to %d.%m.%Y" do
				expect(helper.date_format(time_stamp)).to eq(time_stamp.strftime("%d.%m.%Y"))
			end
		end

		context "date format with time option passed" do
			it "formats the time stamp like %d.%m.%Y at %H:%M" do
				expect(helper.date_format(time_stamp, time: true)).to eq(time_stamp.strftime("%d.%m.%Y at %H:%M"))				
			end
		end
	end
end