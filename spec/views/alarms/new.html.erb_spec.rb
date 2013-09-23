require 'spec_helper'

describe "alarms/new" do
  before(:each) do
    assign(:alarm, stub_model(Alarm,
      :number => 1,
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new alarm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", alarms_path, "post" do
      assert_select "input#alarm_number[name=?]", "alarm[number]"
      assert_select "textarea#alarm_text[name=?]", "alarm[text]"
    end
  end
end
