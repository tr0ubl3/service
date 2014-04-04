require 'spec_helper'

describe "machine_groups/show" do
  before(:each) do
    @machine_group = assign(:machine_group, stub_model(MachineGroup,
      :name => "Name",
      :type => "Type",
      :manufacturer_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Type/)
    rendered.should match(/1/)
  end
end
