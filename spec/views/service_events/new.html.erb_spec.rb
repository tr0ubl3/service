require 'spec_helper'

describe "service_events/new.html.erb" do
  context "params[:machine] is nil" do
    let!(:user) { create(:user2) }
    before :each do
      view.stub(:current_user).and_return(user)
      params[:machine] = nil
      render
    end

    it "has h2 heading with text: 'Define new machine event'" do
      expect(rendered).to have_selector("h2", "Define new machine event")
    end

    it "has select machine combo box" do
      expect(rendered).to have_css("select#event_machine_id")
    end

    it "does not have hidden field" do
      expect(rendered).not_to have_css("input#event_machine_id")
    end
  end

  context "params[:machine] is not nil" do
     let!(:user) { create(:user2) }
     before :each do
        view.stub(:current_user).and_return(user)    
        params[:machine] = user.firm.machines.first.id
        render
     end

     it "has h2 heading with text: 'Define new machine event MH.xxx'" do
         machine_name = user.firm.machines.first.display_name
         expect(rendered).to have_selector("h2", "Define new machine event #{machine_name}")
     end

     it "doesn't display select machine combo box" do
        expect(rendered).not_to have_css("select#event_machine_id")
     end

     it "has hidden input field" do
       expect(rendered).to have_css("input#event_machine_id", "#{user.firm.machines.first.id}")
     end
  end

  context "common elements" do
    let!(:user) { create(:user2) }
     before :each do
        view.stub(:current_user).and_return(user)
        render
      end

    it 'has new_event form' do
    	expect(rendered).to have_css('form#new_event')
    end

    it 'has machine list drop down' do
    	expect(rendered).to have_css('select#event_machine_id')
    end

    it 'has a json event with machine details after selecting the machine number'

    it 'has date of the event' do
    	expect(rendered).to have_css('input#event_date')
    end

    it 'has hour counter' do
    	expect(rendered).to have_css('input [type="text"]#hour_counter')
    end

    it 'has event type radio buttons' do
    	expect(rendered).to have_css('input [type="radio"]#event_event_type_1')
      expect(rendered).to have_css('input [type="radio"]#event_event_type_2')
      expect(rendered).to have_css('input [type="radio"]#event_event_type_3')
    end

    it "has error codes definition" do
    	expect(rendered).to have_content('Error codes definition')
    end

    it 'has input box for alarm codes' do
    	expect(rendered).to have_css('input [type="text"]#alarm_code')
    end

    it "has button 'Insert alarm'" do
      expect(rendered).to have_content('Insert alarm')
    end

    it 'has a json event after input of alarm code to display alarm text'

    it 'has h3 Event description' do
      expect(rendered).to have_content('Event description')
    end

    it 'has event description input text' do
    	expect(rendered).to have_css('textarea#event_description')
    end
  end
end