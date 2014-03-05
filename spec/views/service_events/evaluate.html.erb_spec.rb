require 'spec_helper'

describe "service_events/evaluate.html.erb" do
	let!(:event) { create(:service_event) }
	before do
		assign(:event, event)
		render 
	end

	it "has event recursive radio buttons" do
		expect(rendered).to have_css('input [type="radio"]#service_event_recursive_t')
		expect(rendered).to have_css('input [type="radio"]#service_event_recursive_f')
	end
end