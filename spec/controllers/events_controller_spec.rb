require 'spec_helper'

describe EventsController do
	describe 'GET new' do
		before :each do
    		get :new
		end
		it 'assigns @event variable to the view' do
			expect(assigns[:event]).not_to be_nil
		end

		it 'renders new template' do
			expect(response).to render_template :new
		end
	end
end