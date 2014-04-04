require 'spec_helper'

describe "machine_groups/index" do
  before(:each) do
    assign(:machine_groups, [
      stub_model(MachineGroup,
        :name => "Name",
        :type => "Type",
        :manufacturer_id => 1
      ),
      stub_model(MachineGroup,
        :name => "Name",
        :type => "Type",
        :manufacturer_id => 1
      )
    ])
  end

  it "renders a list of machine_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
