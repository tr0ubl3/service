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

	describe "#machine_display_name" do
		context "params[:machine] is nil" do
			before do
				params[:machine] = nil
			end

			it "renders nothing" do
				expect(helper.machine_display_name).to be_nil
			end
		end

		context "params[:machine] is not nil" do
			let!(:machine) { create(:machine) }	
			before do
				params[:machine] = machine.id
			end

			it "renders machine display name" do
				expect(helper.machine_display_name).to have_content("#{machine.display_name}")
			end
		end
	end
	

	describe "#machine_scoped" do
		context "params[:machine] is not nil" do
			before do
				params[:machine] = 1
			end

			it "renders _new_event_scoped partial" do
				expect(helper.machine_scoped(nil)).to render_template(:partial => 'service_events/_new_event_scoped')
			end
		end

		context "params[:machine] is nil" do
			before do
				params[:machine] = nil
			end

			it "renders _new_event`_unscoped partial" do
				# expect(helper.machine_scoped(f).stub(:render).and_return(true)).to render_template(:partial => 'service_events/_new_event_unscoped')
			end
		end
	end
end