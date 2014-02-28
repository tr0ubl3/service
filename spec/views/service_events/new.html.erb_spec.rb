require 'spec_helper'

describe "service_events/new.html.erb" do
  before :each do
    render
  end

  it "has text 'Define new machine event'" do
  	expect(rendered).to have_content('Define new machine event')
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