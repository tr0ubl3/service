require 'spec_helper'

describe ApplicationController do
	describe "#current_user" do
		it 'returns nil if user is not logged in' do
			session[:user_id] = nil
			expect(controller.current_user).to be_nil
		end
		it 'returns user if user is logged in' do
			user = create(:user)
			session[:user_id] = user.id
			expect(controller.current_user).to eq(user)
		end
	end
end