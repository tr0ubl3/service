require 'spec_helper'

describe GeneralHelper do
	let(:machine) { create(:machine) }
	before :each do
		helper.stub(:pending_event).and_return(1)
	end
	
	describe "#machine_status" do
		context "when option is alarm" do
			it "returns 'alarm' when passed option is alarm" do
				expect(helper.machine_status(machine, status: true)).to have_content('alarm')
			end
		end
	end
end
