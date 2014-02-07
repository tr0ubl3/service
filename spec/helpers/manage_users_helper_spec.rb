require 'spec_helper'

describe ManageUsersHelper do
	describe "#confirm_warning" do
		let(:user) { create(:user2) }
		it "returns .info css class" do
			expect(helper.confirm_warning(user)).to have_content("warning")
		end
	end

	describe "#user_confirmation_text" do
		let(:user) { create(:user) }
		let(:user2) { create(:user2) }
		it "returns True when user has approved_at" do
			expect(helper.user_confirmation_text(user)).to have_content("No")
		end

		it "returns False when user doesn't have approved_at" do
			expect(helper.user_confirmation_text(user2)).to have_content("Yes")
		end
	end
end
