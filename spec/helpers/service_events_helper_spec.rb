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

	describe "#evaluate_event_button" do
		let!(:event) { create(:service_event) }
		context "event is in open state" do
			before do
				event.current_state.stub(:open)
			end

			it "it shows a button on show#service_event" do
				expect(helper.evaluate_event_button(event)).to have_link("Evaluate event", :href => evaluate_service_event_path(event))
			end
		end

		context "event is in evaluated state" do
			before do
				event.stub(:open?).and_return(false)
			end

			it "returns nothing when event is in other state" do
				expect(helper.evaluate_event_button(event)).to render_template(:partial => '_evaluation_details')
			end
		end
	end

	describe "#rowspan_files" do
		let!(:event) { create(:service_event) }
		
		context "number of files divided / 4 < 0.5" do
			before do
				event.stub(:service_event_files).and_return([1])
			end

			it "returns value of 2" do
				expect(helper.rowspan_files(event)).to eq(2)
			end
		end

		context "number of files divided / 4 > 0.5" do
			before do
				event.stub(:service_event_files).and_return([1,2,3])
			end

			it "returns value of 2" do
				expect(helper.rowspan_files(event)).to eq(2)
			end
		end
	end

	describe "#thumbnail_assign" do
		let!(:file) do
			stub_model(ServiceEventFile, :id => 5, :random_attribute => true)
		end

		context "file is an image" do
			before do
				file.stub(:mime_type).and_return("image/png")
			end
			
			it "assigns the thumbnail version of the image" do
				expect(helper.thumbnail_assign(file)).to have_selector("a[rel='pictures']")
			end
		end

		context "file is a video" do
			before do
				file.stub(:mime_type).and_return("video/mp4")
			end

			it "assigns the uniq thumbnail for video" do
				expect(helper.thumbnail_assign(file)).to have_selector("a[rel='videos']")
			end
		end

		context "file is a logfile" do
			before do
				file.stub(:mime_type).and_return("text/log")
			end

			it "assigns the uniq thumbnail for video" do
				expect(helper.thumbnail_assign(file)).to have_selector("a.fancybox.iframe")
			end
		end
	end

	describe "evaluator_full_name" do
		let!(:user) { create(:user) }
		
		it "return the evaluator full_name" do
			expect(helper.evaluator_full_name(user.id)).to eq(user.full_name)
		end
	end

	describe "#parent_event_name" do
		let!(:event) { create(:service_event) }

		context "parent event exists" do
			it "return the event name" do
				expect(helper.parent_event_name(event.id)).to eq(event.event_name)
			end
		end

		context "parent event don't exist" do
			it "returns N/A" do
				expect(helper.parent_event_name(nil)).to eq("N/A")
			end
		end
	end
	
	describe "#solve_event_button" do
		let!(:event) { create(:service_event) }
		
		context "event is in evaluated state" do
			before do
				event.states.create! state: "evaluated"
			end

			it "it shows a button on show#service_event" do
				expect(helper.solve_event_button(event)).to have_link("Solve event", :href => solving_steps_path(event: event.id))
			end
		end

		context "event is solved" do
			before do
				event.stub(:solved?).and_return(true)
			end

			it "returns the partial with solving steps" do
				expect(helper.solve_event_button(event)).to render_template(:partial => '_solving_steps')
			end
		end	
	end
end