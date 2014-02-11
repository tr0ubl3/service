require 'spec_helper'

describe ApplicationHelper do

	describe "#top_right_menu" do
		let!(:user) { create(:user) }
		
		it "has Register link if user is not logged in" do
			helper.stub(:current_user).and_return(nil)
			expect(helper.top_right_menu).to have_link("Register")
		end

		it "has logged in as user full name" do
			helper.stub(:current_user).and_return(user)
			expect(helper.top_right_menu).to have_content("Logged in as #{user.full_name}")
		end

		it "has current_user link" do
			helper.stub(:current_user).and_return(user)
			expect(helper.top_right_menu).to have_link("#{user.full_name}", :href => "#")
		end
	end

	describe "#pending_users" do
		let(:user) { create(:user2) }
		before :each do
			@pending_number = User.where(:approved_at => nil).count
		end

		it "it returns number of users that are pending confirmation" do
			expect(helper.pending_users).to eq(@pending_number)
		end
	end

	describe "#admin_notifications" do
		
		context "when there are pending users" do
			before :each do
				helper.stub(:pending_users).and_return(1)
			end
		
			it "has a div.admin_notifications container" do
				expect(helper.admin_notifications).to have_selector("div.admin_notifications")
			end

			it "has a bootstrap info badge span.badge.badge-info" do
				expect(helper.admin_notifications).to have_selector("span.badge.badge-info")
			end

			it "has a bootstrap i.icon-user" do
				expect(helper.admin_notifications).to have_selector("i.icon-user")
			end
				
			it "has link pending_number" do
				expect(helper.admin_notifications).to have_link("#{@pending_number}", :href => manage_users_path)
			end
		end

		context "when are no pending users" do
			before :each do
				helper.stub(:pending_users).and_return(0)
			end
			
			it "doesn't have div.admin_notifications" do
				expect(helper.admin_notifications).not_to have_selector("div.admin_notifications")
			end
		end
	end
end