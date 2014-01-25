require 'spec_helper'

describe "authorization" do
	let!(:user) { create(:user) }
	let!(:admin) { create(:admin) }

	describe "when attemting to visit a protected page" do
		before do
			visit user_path(user)
			fill_in('login_email', :with => 'jon.snow@mail.com')
			fill_in('login_password', :with => 'securepassword')
			click_button 'Sign in'
		end
		
		describe "after signing in" do
			it "should render the desired protected page" do
				current_path.should == user_path(user)
				expect(page).to have_content("#{user.full_name} details")
			end
		end
	end
end