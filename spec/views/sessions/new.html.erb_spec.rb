require 'spec_helper'

describe 'sessions/new.html.erb' do
	before :each do
		assign(:login, mock_model("Login").as_null_object.as_new_record)
		render
	end

	it 'has login form' do
		expect(rendered).to have_selector('form#new_login')
	end

	it 'has email field' do
		expect(rendered).to have_selector("#login_email")
	end

	it "has password field" do
		expect(rendered).to have_selector("#login_password")
	end

	it 'has submit button' do
		expect(rendered).to have_selector("input[type='submit']")
	end

	it "has 'Create an account ...' link" do
		expect(rendered).to have_link("Create an account ...", href: signup_path)
	end

	it "has 'Forgot your password?' link" do
		expect(rendered).to have_link("Forgot your password?", href: new_password_reset_users_path)
	end
end