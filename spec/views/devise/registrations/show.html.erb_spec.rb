require 'spec_helper'

describe "devise/registrations/show" do
  before(:each) do
    @devise_registration = assign(:devise_registration, stub_model(Devise::Registration))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
