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
		it 'sends authenticate message to login model' do
			login.should_receive(:authenticate)
			post :create, login: params
		end

		context "when authenticate method return true" do
			it "redirects to root url"
			it "assigns a success flash message"
			it "authenticates reader"
		end
	end
end
