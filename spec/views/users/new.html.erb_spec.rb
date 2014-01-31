require 'spec_helper'

describe 'users/new.html.erb' do
	before do
	  @user = build(:user)
	  @machine_owners = [create(:machine_owner)]
	  assign(:user, @user)
	  assign(:machine_owners, @machine_owners)
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
		expect(rendered).to have_link("Login", :href => '/login')
	end
	it 'forgot password link' do
		expect(rendered).to have_link("Forgot your password?", :href => '/password_reset')
	end

	context 'display form errors' do
		before :each do
			test_user = User.create
			assign(:user, test_user)
			render
		end

		it 'when form is submmited empty' do
			expect(rendered).to have_css('#error_explanation')
		end
		it 'when machine_owner_id is not selected' do
			expect(rendered).to have_content("Machine owner can't be blank") 
		end
		it 'when first name is empty' do
			expect(rendered).to have_content("First name can't be blank")
		end
		it "when first name don't have required length" do
			expect(rendered).to have_content('First name is too short (minimum is 2 characters)')
		end
		it 'when first name format is wrong' do
			expect(rendered).to have_content('First name is invalid')
		end
		it 'when last_name is empty' do
			expect(rendered).to have_content("Last name can't be blank")
		end
		it "when last_name don't have required length" do
			expect(rendered).to have_content('Last name is too short (minimum is 2 characters)')
		end
		it 'when last_name format is wrong' do
			expect(rendered).to have_content('Last name is invalid')
		end
		it 'when phone number is empty' do
			expect(rendered).to have_content("Phone number can't be blank")
		end
		it 'when phone number is not a number' do
			expect(rendered).to have_content("Phone number is not a number")
		end
		it "when phone number don't have the required length" do
			expect(rendered).to have_content("Phone number is too short (minimum is 6 characters)")
		end
		it 'when email is empty' do
			expect(rendered).to have_content("Email can't be blank")
		end
		it "when email format is wrong" do
			expect(rendered).to have_content('Email is invalid')
		end
		it 'when email is not unique' do
			@user.save
			uniq_email_test = User.create(:email => @user.email)
			assign(:user, uniq_email_test)
			render
			expect(rendered).to have_content('Email has already been taken')
		end
		it 'when password is empty' do
			expect(rendered).to have_content("Password can't be blank")
		end
		it "when password don't have required length" do
			expect(rendered).to have_content('Password is too short (minimum is 6 characters)')
		end
		it "when passwords don't match" do
			pass_test = User.create( password: @user.password, password_confirmation: 'loremipsum' )
			assign(:user, pass_test)
			render
			expect(rendered).to have_content("Password doesn't match confirmation")
		end
	end
end