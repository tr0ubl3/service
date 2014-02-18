require 'spec_helper'

describe "users/edit_password_reset.html.erb" do
	let(:user) { create(:user) }
	
	before :each do
		assign(:user, user)
		render
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

end