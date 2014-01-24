require 'spec_helper'

describe ApplicationHelper do

	describe "#top_right_menu" do
		let!(:user) { create(:user) }
		it "has Register link if user is not legged in" do
			helper.stub(:current_user).and_return(nil)
			expect(helper.top_right_menu).to have_link("Register")
		end

		it "has logged in as user full name" do
			helper.stub(:current_user).and_return(user)
			expect(helper.top_right_menu).to have_content("Logged in as #{user.full_name}")
		end 

		# it "has user full name link" do
		# 	helper.stub(:current_user).and_return(user)
		# 	expect(helper.top_right_menu).to have_link('#{user.full_name}')
		# end
	end

end