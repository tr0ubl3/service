require 'spec_helper'

describe 'users/new_admin.html.erb' do
	before :each do
		admin = build(:admin)
		assign(:admin, admin)
		render
	end
	
	it 'has new_user form' do
		expect(rendered).to have_selector('form#new_user')
	end

	it 'has first_name field' do
		expect(rendered).to have_selector('input#user_first_name')
	end

	it 'has last_name field' do
		expect(rendered).to have_selector('input#user_last_name')
	end

	it 'has phone_number field' do
		expect(rendered).to have_selector('input#user_phone_number')
	end

	it 'has email field' do
		expect(rendered).to have_selector('input#user_email')
	end
	
	it 'has sign_up button' do
		expect(rendered).to have_selector('input[type="submit"]')
	end
end