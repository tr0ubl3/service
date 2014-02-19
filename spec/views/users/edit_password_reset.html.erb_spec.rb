require 'spec_helper'

describe "users/edit_password_reset.html.erb" do
	let(:user) { create(:user) }
	
	before :each do
		assign(:user, user)
		render
	end

	it "has h2 with 'Setup new password'" do
		expect(rendered).to have_selector("h2", text: "Setup a new password")
	end

	it "has reset_password#form" do
		expect(rendered).to have_selector('form#reset_password')
	end	

	it "has password field" do
		expect(rendered).to have_selector('input#user_password')
	end

	it "has password cofirmation field" do
		expect(rendered).to have_selector('input#user_password_confirmation')
	end

	it 'has save button' do
		expect(rendered).to have_selector('input[type="submit"]')
	end

	context "form errors" do
		before :each do
			user.update_attributes(:password => nil, :password_confirmation => nil)
			user.reload
			test_user = user
			assign(:user, test_user)
			render
		end

		it 'when password is empty' do
			expect(rendered).to have_content("Password can't be blank")
		end

		it "when password don't have required length" do
			expect(rendered).to have_content('Password is too short (minimum is 6 characters)')
		end
		
		it "when passwords don't match" do
			user.update_attributes(:password => 'dasddasd', :password_confirmation => 'dadacqdg')
			pass_test = user.reload
			assign(:user, pass_test)
			render
			expect(rendered).to have_content("Password doesn't match confirmation")
		end
	end
end