require 'spec_helper'

describe 'users/edit.html.erb' do
	let!(:user) { create(:user) }
	
	before do
		view.stub(:current_user).and_return(user)
		render	
	end

	it "renders 'Edit user.full_name'" do
		expect(rendered).to have_selector("h2", text: "Edit #{user.full_name}")
	end

	it "renders the edit form" do
		expect(rendered).to have_selector("form#edit_user_1")
	end

	it "has email field" do
		expect(rendered).to have_selector("input#user_email")
	end

	it "has phone number field" do
		expect(rendered).to have_selector("input#user_phone_number")
	end

	it "has submit button" do
		expect(rendered).to have_selector('input[type="submit"]')
	end

	context 'display form errors' do
		before do
			view.stub(:update).and_return(false)
		end
		
		it 'when form is submmited empty' do
			expect(rendered).to have_css('#error_explanation')
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