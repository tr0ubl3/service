require 'spec_helper'

describe "devise/registrations/index" do
  before(:each) do
    assign(:devise_registrations, [
      stub_model(Devise::Registration),
      stub_model(Devise::Registration)
    ])
  end

  it "renders a list of devise/registrations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
