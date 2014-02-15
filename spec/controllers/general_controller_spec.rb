require 'spec_helper'

describe GeneralController do

  describe "GET index" do
  	let!(:user) { create(:user) }
  	let!(:owner) { create(:machine_owner, :id => 1) }

  	before :each do
  		session[:user_id] = user.id
    end
    
    it 'renders index template' do 
      get :index
      expect(response).to render_template :index
    end

    it 'assigns @machines variable to the view' do
  		@man_ids = Machine.where(:machine_owner_id => controller.current_user.firm_id)
  		get :index 
      expect(assigns[:machines]).to eq(@man_ids)
  	end

    it 'assigns @manufacturer_names variable to the view' do
      get :index 
      expect(assigns[:manufacturer_names]).to be_empty
    end

    it "can be accessed only by registered users" do
      session.delete(:user_id)
      get :index
      expect(response).to redirect_to login_path
    end
  end

  describe "GET control_panel" do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }  
      
      it "can be accessed only by admin users" do
        session[:user_id] = user.id
        get :control_panel
        expect(response).to redirect_to root_path         
      end

      it "renders the control_panel template" do
        session[:user_id] = admin.id
        get :control_panel
        expect(response).to render_template :control_panel  
      end
  end
end
