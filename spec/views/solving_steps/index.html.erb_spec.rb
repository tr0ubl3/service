require 'spec_helper'

describe "solving_steps/index" do
  before(:each) do
    assign(:solving_steps, [
      stub_model(SolvingStep,
        :service_event_id => 1,
        :step => "Step"
      ),
      stub_model(SolvingStep,
        :service_event_id => 1,
        :step => "Step"
      )
    ])
  end

  it "renders a list of solving_steps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Step".to_s, :count => 2
  end
end
