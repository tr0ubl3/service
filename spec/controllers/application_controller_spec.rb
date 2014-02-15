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

	describe "#check_auth" do
		context "when user is logged in" do
			let!(:user) {create(:user)}
			before :each do
				session[:user_id] = user.id
			end

			it "returns true whe user is logged in" do
				expect(controller.send(:check_auth)).to be_true
			end
		end	
	end


	describe "#check_admin" do
		
		controller do
			before_filter :check_admin
			def index
				render :text => "Testing permision method"
			end
		end
		
		context "when user is not admin" do
			let(:user) { create(:user) }
			
			before :each do
				session[:user_id] = user.id
			end

			it "redirects to root path" do
				controller.should_receive(:redirect_to).with(root_path)
				get :index
			end

			it "shows a flash message" do
				get :index
				expect(controller.flash[:error]).to eq("You are not allowed to view this page")
			end
		end

		context "when user is admin" do
			let(:admin) { create(:admin) }

			before :each do
				session[:user_id] = admin.id
				get :index
			end

			it "renders the protected page" do
				expect(response).to be_success 
			end

			it "doesn't show a flash message" do
				expect(controller.flash[:error]).to be_nil
			end
		end
	end

	describe "#update_login_count" do
		let!(:user) { create(:user, :login_count => 2) }
		
		it 'save login_count to user table' do
			expect{controller.update_login_count(user)}.to change{user.login_count}.by(1)
		end

		it 'sends email to first login of user' do
			user2 = create(:user2, :login_count => 0)
			UserMailer.should_receive(:welcome).with(user2).and_return(double("UserMailer", :deliver => true))
			controller.update_login_count(user2)
		end
	end
end