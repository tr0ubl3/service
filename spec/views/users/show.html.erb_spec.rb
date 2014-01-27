require 'spec_helper'

describe 'users/show.html.erb' do
	let(:user) { create(:user) }
	before :each do
		assign(:user, user)
		render
	end
	it "contains 'Bud Spencer details'" do
		expect(rendered).to have_content("#{user.full_name} details")
	end

	it "has link 'Approve registration'" do
		expect(rendered).to have_link("Approve registration", :href => approve_user_path(user))
	end

	it 'has dl.dl-horizontal' do
		expect(rendered).to have_selector('dl.dl-horizontal')
	end

	it "has dt 'First name" do
		expect(rendered).to have_content('First name')
	end

	it "has dt 'Last name'" do
		expect(rendered).to have_content('Last name')
	end

	it "has Phone number" do
		expect(rendered).to have_content('Phone number')
	end

	it "has Email" do
		expect(rendered).to have_content('Email')
	end

	it "has Firm" do
		expect(rendered).to have_content('Firm')
	end

	it "Registered at" do
		expect(rendered).to have_content('Registered at')
	end
end