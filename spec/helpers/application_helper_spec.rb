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
		before do
			@pending_number = ServiceEvent.where(state: "pending_confirmation").count
		end

		it "it returns the number of unconfirmed events" do
			expect(helper.pending_events).to eq(@pending_number)
		end
	end

	describe "#date_format" do
		it "formats the time stamp to %d.%m.%Y" do
			time_stamp = Time.now
			expect(helper.date_format(time_stamp)).to eq(time_stamp.strftime("%d.%m.%Y"))
		end
	end
end