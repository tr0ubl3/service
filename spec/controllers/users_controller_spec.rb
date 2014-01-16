require 'spec_helper'

describe UsersController do
	describe 'GET new' do
		let!(:user) { mock_model('User').as_new_record }
		let!(:machine_owners) { create(:machine_owner) }
		before :each do
			User.stub(:new).and_return(user)
			get :new
		end
		it 'assigns user variable to the view' do
			expect(assigns[:user]).to eq(user)
		end

		it 'assigns machine_owners variable to the view' do
			expect(assigns[:machine_owners]).to eq([machine_owners])
		end
		it 'renders new template' do
			expect(response).to render_template :new
		end

		it 'renders with user layout' do
			expect(response).to render_template(layout: 'layouts/user')
		end
	end

	describe 'POST create' do
		let!(:user) { stub_model(User) }
		before :each do
			User.stub(:new).and_return(user)
		end

		it 'sends new message to User class' do
			params = {
				"first_name" => "John",
				"last_name" => "Wilkins",
				"phone_number" => "1234567890",
				"email" => "john.wilkins@firm.com",
				"password" => "pass",
				"password_confirmation" => "pass",
				"admin" => false
			}
			User.should_receive(:new).with(params)
			post :create, user: params
		end

		it 'sends save message to user model' do
			user.should_receive(:save)
			post :create
		end

		context 'when save message returns true' do
			before :each do
				user.stub(:save).and_return(true)
			end
			it 'redirects to signup path' do
				post :create
				expect(response).to redirect_to signup_path
			end
			it 'assigns a success flash message' do
				post :create
				expect(flash[:notice]).not_to be_nil
			end
			it 'sends confirmation mail to user' do
				email = UserMailer::ActionMailer::Base.deliveries.first
				expect(email.from).to eq(['noreply@service.com'])
			end
			it 'sends approval mail to all admin users'
		end
	end
end
