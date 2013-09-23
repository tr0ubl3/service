require 'spec_helper'

describe "alarms/index" do
  before(:each) do
    assign(:alarms, [
      stub_model(Alarm,
        :number => 1,
        :text => "MyText"
      ),
      stub_model(Alarm,
        :number => 1,
        :text => "MyText"
      )
    ])
  end

  it "renders a list of alarms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
