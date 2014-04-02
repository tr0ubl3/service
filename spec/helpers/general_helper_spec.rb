require 'spec_helper'

describe GeneralHelper do
	let(:machine) { create(:machine) }
	before :each do
		helper.stub(:pending_events).and_return(1)
	end
	
	describe "#machine_status" do
		context "when option is alarm" do
			it "returns 'alarm' when passed option is status" do
				expect(helper.machine_status(machine, status: true)).to have_content('alarm')
			end
		end

		context "when option is title" do
			it "returns '1 unsolved event'" do
				expect(helper.machine_status(machine, title: true)).to have_content(helper.pending_events.to_s + " unsolved " + "event".pluralize(helper.pending_events.to_i))
			end
		end

		context "when option is icon" do
			context "pending events is not 0" do
				it "returns 'icon-exclamation-sign'" do
					expect(helper.machine_status(machine, icon: true)).to have_content('icon-exclamation-sign blink')
				end
			end

			context "pending events is 0" do
				before :each do
					helper.stub(:pending_events).and_return(0)
				end

				it "returns 'icon-ok'" do
					expect(helper.machine_status(machine, icon: true)).to have_content('icon-ok')
				end
			end
		end
	end
end
