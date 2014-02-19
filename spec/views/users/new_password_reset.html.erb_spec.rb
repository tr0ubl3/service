require 'spec_helper'

describe "users/new_password_reset.html.erb" do
  before :each do
  	render
  end

  it "has form#password_reset" do
  	expect(rendered).to have_selector("form#password_reset")
  end
end
