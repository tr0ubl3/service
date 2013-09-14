require 'spec_helper'

describe EventsController do
	describe 'GET new' do
		before :each do
    		get :new
		end
		it 'assigns @event variable to the view' do
			expect(assigns[:event]).not_to be_nil
		end

		it 'assigns @machines.all array too the view' do
			expect(assigns[:machines]).not_to be_nil
		end
		it 'renders new template' do
			expect(response).to render_template :new
		end
	end

	describe 'POST create' do
		let!(:event) { stub_model(Event) }
		let(:params) do
		    {
				'event_date' => '01.01.1900',
				'event_type' => 'Machine stopped',
				'event_description' => 'Machine stopped with alarm 700123',
				'hour_counter' => '1234'
			}
		    
		end
		before :each do
			Event.stub(:new).and_return(event)
		end
		it 'sends new message to Event class' do
			Event.should_receive(:new).with(params)
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
end