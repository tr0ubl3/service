require 'spec_helper'

describe "alarms/edit" do
  before(:each) do
    @alarm = assign(:alarm, stub_model(Alarm,
      :number => 1,
      :text => "MyText"
    ))
  end

  it "renders the edit alarm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", alarm_path(@alarm), "post" do
      assert_select "input#alarm_number[name=?]", "alarm[number]"
      assert_select "textarea#alarm_text[name=?]", "alarm[text]"
    end
  end
end
