require 'spec_helper'

describe "machine_groups/new" do
  before(:each) do
    assign(:machine_group, stub_model(MachineGroup,
      :name => "MyString",
      :type => "",
      :manufacturer_id => 1
    ).as_new_record)
  end

  it "renders new machine_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", machine_groups_path, "post" do
      assert_select "input#machine_group_name[name=?]", "machine_group[name]"
      assert_select "input#machine_group_type[name=?]", "machine_group[type]"
      assert_select "input#machine_group_manufacturer_id[name=?]", "machine_group[manufacturer_id]"
    end
  end
end
