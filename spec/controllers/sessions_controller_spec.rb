require 'spec_helper'

describe SessionsController do
	describe 'GET new' do
		let!(:login) {mock_model("Login").as_new_record}
		before :each do
			Login.stub(:new).and_return(login)
			get :new
		end
		it 'sends new message' do
			Login.should_receive(:new)
			get :new
		end

		it 'renders new template' do 
			get :new
			expect(response).to render_template :new
		end

		it "assigns @login instance variable to the view" do
			Login.stub(:new).and_return(login)
			get :new
			expect(assigns[:login]).to eq(login)
		end

		it 'renders with user layout' do
			expect(response).to render_template(layout: 'layouts/user')
		end
	end

	describe "POST create" do
		let(:params) do
			{
				"email" => "email@email.com",
				"password" => "securepassword"
			}
		end
		let!(:login) {stub_model(Login)}
		before :each do
			Login.stub(:new).and_return(login)
		end
		context "when data is valid" do
			before :each do
				login.stub(:valid?).and_return(true)
			end
		end
		it 'sends conditional_authentication message to login model' do
			login.should_receive(:conditional_authentication)
			post :create, login: params
		end

		context "when conditional_authentication method return true" do
			before :each do
				login.stub(:conditional_authentication).and_return(true)
				post :create, login: params
			end
			it "redirects to root url" do
				expect(response).to redirect_to(root_url)
			end
			it "assigns a success flash message" do
				expect(flash[:notice]).not_to be_nil
			end
			it "authenticates user" do
				expect(session[:user_id]).not_to be_nil
			end
		end	

		context "when authenticate method return false" do
			before :each do
				login.stub(:conditional_authentication).and_return(false)
				post :create, login: params
			end
			it "redirects to login page" do
				expect(response).to redirect_to(login_path)
			end
			it "assigns an alert flash message" do
				expect(flash[:alert]).not_to be_nil
			end
			it "doesn't authenticate the user" do
				expect(session[:user_id]).to be_nil
			end
		end
	end

	describe "GET destroy" do
		it 'sets session[:user_id] to nil' do
			session[:user_id] = 1
			get :destroy
			expect(session[:user_id]).to be_nil
		end

		it 'redirects to login page' do
			get :destroy
			expect(response).to redirect_to login_path
		end

		it "assigns a flash message" do
			expect(flash[:notice]).not_to be_nil
		end
	end
end
