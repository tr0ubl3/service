require 'spec_helper'

describe 'manage_users/index.html.erb' do
	let(:user) { create(:user2) }
	let(:admin) { create(:admin) }
	before :each do
		assign(:regular_users, [user])
		assign(:admin_users, [admin])
		render
	end

	it "has Pending confirmation column" do
		expect(rendered).to have_selector('th', :text => "Pending confirmation")
	end

	it "has .warning class for row with pending confirmation true" do
		expect(rendered).to have_selector("tr.warning", :text => user.full_name)
	end

	it "has true or false values for Pending confirmation values" do
		expect(rendered).to have_selector("tr.warning", :text => user.full_name && "Yes")
	end

	it "has user.full_name links that redirects to show_user" do
		expect(rendered).to have_link(user.full_name, :href => user_path(user) )
	end
end