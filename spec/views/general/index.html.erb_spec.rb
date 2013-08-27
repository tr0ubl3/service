require 'spec_helper'

describe "general/index.html.erb" do
  it "has new event link" do
  	render
  	expect(rendered).to have_link('New event', :href => '/events/new')
  end
end
