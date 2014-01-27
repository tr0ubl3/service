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
		let!(:machine_owners) { create(:machine_owner) }
		let(:params) do
			 {
				"first_name" => "John",
				"last_name" => "Wilkins",
				"phone_number" => "1234567890",
				"email" => "john.wilkins@firm.com",
				"password" => "pass",
				"password_confirmation" => "pass",
				"admin" => false
			}
		end
		before :each do
			User.stub(:new).and_return(user)
		end

		it 'sends new message to User class' do
			User.should_receive(:new).with(params)
			post :create, user: params
		end

		it 'sends save message to user model' do
			user.should_receive(:save)
			post :create
		end

		context 'when save message returns true' do
			let(:user) { create(:user2) }
			let(:admin) { create(:admin) }
			before :each do
				user.stub(:save).and_return(true)
			end
			it 'redirects to login path' do
				post :create
				expect(response).to redirect_to login_path
			end
			it 'assigns a success flash message' do
				post :create
				expect(flash[:notice]).not_to be_nil
			end
			it 'sends confirmation mail to user' do
				UserMailer.should_receive(:confirmation).with(user).and_return(double("UserMailer", :deliver => true))
				post :create, :user => user
			end
			it 'sends approval mail to all admin users' do
				admins = User.where(:admin => true)
				UserMailer.should_receive(:approval).with(admins, user).and_return(double("UserMailer", :deliver => true))
				post :create, user: user, admins: admin
			end
		end
		
		context "when save message return false" do
			before :each do
				user.stub(:save).and_return(false)
				post :create, user: params
			end
			it 'renders new template' do
				expect(response).to render_template :new
			end
			it 'renders with user layout' do
				expect(response).to render_template(layout: 'layouts/user')
			end
			it 'assigns user variable to the view' do
				expect(assigns[:user]).to eq(user)
			end
			it 'assigns machine_owners variable to the view' do
				expect(assigns[:machine_owners]).to eq([machine_owners])
			end
			it 'assigns error flash message' do
				expect(flash[:error]).not_to be_nil
			end
		end
	end

	describe 'get SHOW' do
		context "when admin it's not logged in" do
			let!(:user) { create(:user) }
			before :each do
				session[:user_id] = nil
			end

			it 'redirects to login page' do
				get :show, id: user.id
				expect(response).to redirect_to login_path
			end
		end
	end

	describe 'GET show' do
		let!(:user) { create(:user) }
		before :each do
			session[:user_id] = user.id
			allow(User).to receive(:find).and_return(user)
		end
		
		it 'sends find message to User class' do
			expect(User).to receive(:find) { user }
			get :show, id: user.id
		end
		
		it 'assigns user variable to the view' do
			get :show, id: user.id
			expect(assigns[:user]).to eq(user)
		end

		it 'renders show template' do
			get :show, id: user.id
			expect(response).to render_template :show
		end
	end
end