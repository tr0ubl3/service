require 'spec_helper'

describe GeneralController do

  describe "GET index" do
  	let!(:user) { create(:user) }
  	let!(:owner) { create(:machine_owner) }
  	let!(:machine) { create(:machine) }

  	before :each do
  		session[:user_id] = user.id
  		@man_ids = Machine.where(:machine_owner_id => controller.current_user.machine_owner_id)
  	end
  	
  	it 'renders index template' do 
		get :index
		expect(response).to render_template :index
	end

	it 'assigns user variable to the view' do
  		get :index 
		expect(assigns[:manufacturer_ids]).to eq(@man_ids)
	end
  end

end
