require 'spec_helper'

describe "events/new.html.erb" do
  it "has text 'Define new machine event'" do
  	render
  	expect(rendered).to have_content('Define new machine event')
  end

  it 'has new_event form' do
  	render
  	expect(rendered).to have_css('form#new_event')
  end

  it 'has machine list drop down' do
  	render
  	expect(rendered).to have_css('select#event_machine_id')

  end

  it 'has a json event with machine details after selecting the machine number'

  it 'has date of the event' do
  	render
  	expect(rendered).to have_css('div#event_date')
  end

  it 'has hour counter' do
  	render
  	expect(rendered).to have_css('input [type="text"]#hour_counter')
  end

  it 'has event type radio buttons' do
  	render
  	expect(rendered).to have_css('input [type="radio"]#event_type_1')
    expect(rendered).to have_css('input [type="radio"]#event_type_2')
    expect(rendered).to have_css('input [type="radio"]#event_type_3')
  end

  it 'has text box for describing other problems' do
    render
    expect(rendered).to have_css('input [type="text"]#other_problem')
  end

  it "it has error codes definition" do
  	render
  	expect(rendered).to have_content('Error codes definition')
  end

  it 'it has input box for alarm codes' do
  	render
  	expect(rendered).to have_css('input text#alarm_code')
  end

  it 'has a json event after input of alarm code to display alarm text'

  it 'has event description input text' do
  	render
  	expect(rendered).to have_css('input text#event_description')
  end

end