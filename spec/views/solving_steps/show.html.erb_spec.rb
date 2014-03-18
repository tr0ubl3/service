require 'spec_helper'

describe "solving_steps/show" do
  before(:each) do
    @solving_step = assign(:solving_step, stub_model(SolvingStep,
      :service_event_id => 1,
      :step => "Step"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Step/)
  end
end
