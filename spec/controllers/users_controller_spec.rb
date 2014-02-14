require 'spec_helper'

describe UsersController do
	describe 'GET new' do
		let!(:user) { mock_model('User').as_new_record }
		let!(:machine_owner) { create(:machine_owner) }
		before :each do
			User.stub(:new).and_return(user)
			allow(Firm).to receive(:find) { machine_owner }
			get :new 
		end
		it 'assigns user variable to the view' do
			expect(assigns[:user]).to eq(user)
		end

		it 'assigns machine_owners variable to the view' do
			expect(assigns[:machine_owners]).to eq([machine_owner])
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
		let!(:user) { create(:user) }
		context "when admin it's not logged in" do
			before :each do
				session[:user_id] = nil
			end

			it 'redirects to login page' do
				get :show, id: user.id
				expect(response).to redirect_to login_path
			end
		end

		context "admin it's logged in" do
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

	describe 'GET approve' do
		let!(:user) { create(:user2) }
		let!(:admin) { create(:admin) }
		
		before :each do
			session[:user_id] = admin.id
			allow(User).to receive(:find) { user }
			controller.stub(:check_admin).and_return(true)
		end

		it 'sends find message to User class' do
			expect(User).to receive(:find) { user }
			get :approve, id: user
		end

		it "assigns @user variable" do
			get :approve, id: user, approve: "false"
			expect(assigns[:user]).to eq(user)
		end

		it "can't be accessed by non admin users" do
			controller.unstub(:check_admin)
			session.delete(:user_id)
			session[:user_id] = user.id
			get :approve, id: user
			expect(response).to redirect_to root_path
		end

		context 'Admin approves user registration' do
			before :each do
				controller.stub(:current_user).and_return(admin)
			end

			it 'saves approved_at to user table' do
				get :approve, id: user, :approve => "true"
				expect(user.approved_at).not_to be_nil
			end

			it 'saves denied_at to user table' do
				get :approve, id: user, :approve => "true"
				expect(user.denied_at).to be_nil
			end

			it 'assigns a success flash message' do
				get :approve, id: user, :approve => "true"
				expect(flash[:notice]).not_to be_nil
			end

			it 'sends confirmation email to user' do
				UserMailer.should_receive(:user_registration_approved).with(user).and_return(double("UserMailer", :deliver => true))
				get :approve, id: user, approve: "true"
			end

			it "sends confirmation email to admin" do
				UserMailer.should_receive(:user_registration_approved_to_admin).with(user, admin).and_return(double("UserMailer", :deliver => true))
				get :approve, id: user, approved: "true"
			end
		end

		context 'Admin denies user registration' do
			
			it 'saves denied_at to user table' do
				get :approve, id: user, approved: "false"
				expect(user).to receive(:update_attribute) { :denied_at }
			end

			it 'assigns an alert flash message' do
				get :approve, id: user, approved: false
				expect(flash[:alert]).not_to be_nil
			end

			it 'sends mail to user' do
				UserMailer.should_receive(:user_registration_denied).with(user).and_return(double("UserMailer", :deliver => true))
				get :approve, id: user, approved: false
			end
		end
	end

	describe 'GET cp_new' do
		let!(:user) { mock_model('User').as_new_record }
		let!(:admin) { create(:admin) }
		let!(:machine_owner) { create(:machine_owner) }
		
		before :each do
			session[:user_id] = admin.id
			User.stub(:new).and_return(user)
			# get :cp_new
		end
		
		it 'assigns @user variable' do
			get :cp_new
			expect(assigns[:user]).to eq(user)
		end

		it 'assigns machine_owners variable to the view' do
			get :cp_new
			expect(assigns[:machine_owners]).to eq([machine_owner])
		end

		it 'renders new template' do
			get :cp_new
			expect(response).to render_template :cp_new
		end

		it 'renders with application layout' do
			get :cp_new
			expect(response).to render_template(layout: 'layouts/application')
		end

		it "can't be accessed by non admin users" do
			user2 = create(:user2, :approved_at => Time.now)
			session.delete(:user_id)
			session[:user_id] = user2.id
			get :cp_new
			expect(response).to redirect_to root_path
		end
	end

	describe 'POST cp_create' do
		let!(:user) { stub_model(User) }
		let!(:admin) { create(:admin) }
		let!(:machine_owner) { create(:machine_owner) }
		let(:params) do
			 {
				"firm_id" => "2",
				"first_name" => "John",
				"last_name" => "Wilkins",
				"phone_number" => "1234567890",
				"email" => "john.wilkins@firm.com",
				"admin" => false
			}
		end

		before :each do
			session[:user_id] = admin.id
			User.stub(:new).and_return(user)
		end
		
		it 'sends new message to User class' do
			User.should_receive(:new).with(params)
			post :cp_create, user: params
		end

		it 'has password set' do
			post :cp_create, user: params
			expect(user.password).not_to be_nil
		end

		it 'has approved_at set' do
			post :cp_create, user: params
			expect(user.approved_at).not_to be_nil
		end

		it 'sends save message to user model' do
			user.should_receive(:save)
			post :cp_create, user: params
		end

		it "can't be accessed by non admin users" do
			user2 = create(:user2)
			session.delete(:user_id)
			session[:user_id] = user2.id
			post :cp_create, user: params
			expect(response).to redirect_to root_path
		end

		context 'when save message returns true' do
			let(:new_user) { create(:user) }
			
			before :each do
				new_user.stub(:save).and_return(true)
			end

			it 'redirects to manage_users_path' do
				post :cp_create, user: new_user
				expect(response).to redirect_to manage_users_path
			end

			it 'assigns a success flash message' do
				post :cp_create
				expect(flash[:notice]).not_to be_nil
			end

			it 'sends invitation to user' do
				UserMailer.should_receive(:invitation).with(new_user).and_return(double("UserMailer", :deliver => true))
				post :cp_create, :user => new_user
			end

			it "sends invitation confirmation mail to admin" do
				admin = controller.current_user
				UserMailer.should_receive(:invitation_to_admin).with(new_user, admin).and_return(double("UserMailer", :deliver => true))
				post :cp_create, :user => new_user
			end
		end
		
		context "when save message return false" do
			let!(:new_user) { create(:user) }
			let!(:params2) do
			 {
				"firm_id" => "",
				"first_name" => "",
				"last_name" => "",
				"phone_number" => "",
				"email" => "",
				"admin" => false
			}
			end
			before :each do
				new_user.stub(:save).and_return(false)
				post :cp_create, user: params2
			end
			it 'renders new template' do
				expect(response).to render_template :cp_new
			end
			it 'renders with user layout' do
				expect(response).to render_template(layout: 'layouts/application')
			end
			it 'assigns user variable to the view' do
				expect(assigns[:user]).to eq(user)
			end
			it 'assigns machine_owners variable to the view' do
				expect(assigns[:machine_owners]).to eq([machine_owner])
			end
			it 'assigns error flash message' do
				expect(flash[:error]).not_to be_nil
			end
		end
	end

	describe "GET new_admin" do
		let!(:admin) { mock_model('User').as_new_record }
		let!(:user) { create(:user) }
		let!(:existing_admin) { create(:admin_2) }

		before :each do
			User.stub(:new).and_return(admin)
			session[:user_id] = existing_admin.id
		end

		it "assigns @admin variable" do
			get :new_admin
			expect(assigns(:admin)).to eq(admin)
		end

		it 'renders new template' do
			get :new_admin
			expect(response).to render_template :new_admin
		end

		it 'renders with application layout' do
			get :new_admin
			expect(response).to render_template(layout: 'layouts/application')
		end

		it "can't be accessed by non admin users" do
			session.delete(:user_id)
			session[:user_id] = user.id
			get :new_admin
			expect(:response).to redirect_to root_path
		end
	end

	describe "POST create_admin" do
		let(:new_admin) { build(:admin, :password => nil,
		                  :approved_at => nil, :firm_id => nil, :admin => false) }
		let!(:admin) { create(:admin_2) }
		let!(:reseller) { create(:authorized_reseller) }

		before :each do
			session[:user_id] = admin.id
			allow(User).to receive(:new) { new_admin }
		end

		it 'sends new message to User class' do
			expect(User).to receive(:new) { new_admin }
			post :create_admin, admin: new_admin
		end

		it 'has password set' do
			post :create_admin, admin: new_admin
			expect(new_admin.password).not_to be_nil
		end

		it 'has approved_at set' do
			post :create_admin, admin: new_admin
			expect(new_admin.approved_at).not_to be_nil
		end

		it "has firm_id set" do
			post :create_admin, admin: new_admin
			expect(new_admin.firm_id).not_to be_nil
		end

		it "has admin set to true" do
			post :create_admin, admin: new_admin
			expect(new_admin.admin).to be_true
		end

		it 'sends save message to User model' do
			expect(new_admin).to receive(:save)
			post :create_admin, admin: new_admin
		end

		it "can't be accessed by non admin users" do
			user = create(:user2)
			session.delete(:user_id)
			session[:user_id] = user.id
			post :create_admin, admin: new_admin
			expect(:response).to redirect_to root_path
		end

		context 'when save message returns true' do
			let(:admin) { create(:admin_2, :id => 3) }

			before :each do
				session[:user_id] = admin.id
				new_admin.stub(:save).and_return(true)
	 		end

			it 'redirects to manage_users_path' do
				post :create_admin, admin: new_admin
				expect(response).to redirect_to manage_users_path
			end

			it 'assigns a success flash message' do
				post :create_admin, admin: new_admin
				expect(flash[:notice]).not_to be_nil
			end

			it 'sends invitation to new admin user' do
				UserMailer.should_receive(:admin_invitation).with(new_admin).and_return(double(UserMailer, :deliver => true))
				post :create_admin, admin: new_admin
			end

			it "sends invitation confirmation mail to admin" do
				current_admin = controller.current_user
				UserMailer.should_receive(:confirmation_for_admin).with(new_admin, current_admin).and_return(double(UserMailer, :deliver => true))
				post :create_admin, admin: new_admin
			end
		end

		context "when save message return false" do
			let!(:user) { stub_model(User)}
			before :each do
				new_admin.stub(:save).and_return(false)
				new_admin = nil
				User.stub(:new).and_return(user)
				post :create_admin, admin: new_admin
			end

			it "renders new template" do
				expect(response).to render_template :new_admin
			end

			it 'renders with user layout' do
				expect(response).to render_template(layout: 'layouts/application')
			end

			it 'assigns admin variable to the view' do
				expect(assigns[:admin]).to eq(user)
			end

			it 'assigns error flash message' do
				expect(flash[:error]).not_to be_nil
			end
		end		
	end		
end