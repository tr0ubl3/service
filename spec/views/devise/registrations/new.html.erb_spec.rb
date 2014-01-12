require 'spec_helper'

describe 'devise/registrations/new.html.erb' do
	before do
	  view.stub(:resource).and_return(User.new)
	  view.stub(:resource_name).and_return(:user)
	  view.stub(:devise_mapping).and_return(Devise.mappings[:user])
	  render
	end

	it 'has new_user form' do
		expect(rendered).to have_selector('form#new_user')
	end
	it 'has firm dropdown menu' do
		expect(rendered).to have_selector('select#user_machine_owner_id')
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
	it 'has password field' do
		expect(rendered).to have_selector('input#user_password')
	end
	it 'has password_confirmation field' do
		expect(rendered).to have_selector('input#user_password_confirmation')
	end
	it 'has sign_up button' do
		expect(rendered).to have_selector('input[type="submit"]')
	end
	it 'has sign_in link' do
		expect(rendered).to have_link("Sign in", :href => "/users/sign_in")
	end
	it 'forgot password link' do
		expect(rendered).to have_link("Forgot your password?", :href => "/users/password/new")
	end
end