require 'spec_helper'

describe "solving_steps/new" do
  before(:each) do
    assign(:solving_step, stub_model(SolvingStep,
      :service_event_id => 1,
      :step => "MyString"
    ).as_new_record)
  end

  it "renders new solving_step form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", solving_steps_path, "post" do
      assert_select "input#solving_step_service_event_id[name=?]", "solving_step[service_event_id]"
      assert_select "input#solving_step_step[name=?]", "solving_step[step]"
    end
  end
end
