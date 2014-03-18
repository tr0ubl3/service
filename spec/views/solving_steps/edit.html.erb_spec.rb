require 'spec_helper'

describe "solving_steps/edit" do
  before(:each) do
    @solving_step = assign(:solving_step, stub_model(SolvingStep,
      :service_event_id => 1,
      :step => "MyString"
    ))
  end

  it "renders the edit solving_step form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", solving_step_path(@solving_step), "post" do
      assert_select "input#solving_step_service_event_id[name=?]", "solving_step[service_event_id]"
      assert_select "input#solving_step_step[name=?]", "solving_step[step]"
    end
  end
end
