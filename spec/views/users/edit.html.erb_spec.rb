require 'spec_helper'

describe "devise/registrations/edit" do
  before(:each) do
    @devise_registration = assign(:devise_registration, stub_model(Devise::Registration))
  end

  it "renders the edit devise_registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", devise_registration_path(@devise_registration), "post" do
    end
  end
end
