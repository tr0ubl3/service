require 'spec_helper'

describe ServiceEventsController do
	describe 'GET new' do
		let!(:event) { mock_model('ServiceEvent').as_new_record }
		let!(:user) { create(:user) }
		
		before do
			session[:user_id] = user.id
    		User.stub(:new).and_return(event)
    		get :new
		end
		
		it 'assigns @event variable to the view' do
			expect(assigns[:event]).not_to be_nil
		end

		it 'renders new template' do
			expect(response).to render_template :new
		end

		it 'responds to json format' do
			alarm = create(:alarm)
			get :new, format: :json, search: alarm.number
			response.body.should include_json(alarm.to_json)
		end
	end

	describe 'POST create' do
		pending
		let!(:event) { mock_model('ServiceEvent').as_new_record }
		let!(:user) { create(:user) }
		let(:params) do
		    {
				'event_date' => '01.01.1900',
				'event_type' => 'Machine stopped',
				'event_description' => 'Machine stopped with alarm 700123',
				'hour_counter' => '1234'
			}
		    
		end

		before :each do
			session[:user_id] = user.id
			ServiceEvent.stub(:new).and_return(event)
		end

		it 'sends new message to Event class' do
			ServiceEvent.should_receive(:new).with(params)
			post :create, event: params 
		end

		it 'sends save message to Event model' do
			event.should_receive(:save)
			post :create, event: params
		end
		
		context 'when save message returns true' do
			before :each do
				event.stub(:save).and_return(true)
			end
			it 'redirects to event root path' do
				post :create, event: params 
				expect(response).to redirect_to root_url
			end
			it 'assigns a success flash message' do
				post :create, event: params 
				expect(flash[:notice]).not_to be_nil
			end
		end
		
		context 'when save message return false' do
			before :each do
				event.stub(:save).and_return(false)
				post :create, event: params
			end
			it 'render new template' do
				expect(response).to render_template :new
			end
			it 'assigns variable event to the view' do
				expect(assigns[:event]).to eq(event)
			end
			it 'assigns error flash message' do
				expect(flash[:alert]).not_to be_nil
			end
		end
	end

	describe "GET evaluate" do
		let!(:event) { create(:service_event) }
		
		before :each do
			get :evaluate, id: event
		end

		it 'renders evaluate template' do
			expect(response).to render_template :evaluate
		end

		it "assigns @event variable to the view" do
			expect(assigns[:event]).to eq(event)
		end
	end

	describe "POST create_evaluate" do
		let(:event) { create(:service_event) }
		let(:params) do {
			"recursive" => false,
			"evaluation_description" => "testing"
		}
		end

		it 'sends update message to ServiceEvent model' do
			event.should_receive(:update_attributes)
			post :create_evaluate, id: event.id, :event => params
		end

		context "evaluation is successfully submited" do
			it "redirects to show service event" do
				post :create_evaluate, id: event.id, event: params 
				expect(response).to redirect_to service_event_path(event)
			end

			it "assigns a flash message to the view" do
				post :create_evaluate, id: event.id, event: params 
				expect(flash[:notice]).not_to be_nil
			end

			it "sets event to evaluated state" do
				post :create_evaluate, id: event.id, event: params 
				expect(event.current_state).to eq("evaluated")
			end
		end
	end
end