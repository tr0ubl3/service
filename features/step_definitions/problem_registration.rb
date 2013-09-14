Given(/^I have a problem$/) do
	puts 'Me or machine utilisers observed a new event(problem) on a machine'
end

When(/^I register my new event/) do
  @e = Event.all.count
  visit root_path
  click_link_or_button('New event')
  current_path.should == '/events/new'
  select('MH.357', :from => 'event_machine_id')
  # page.evaluate_script '$.active == 0'
  # find('#event_date').find('span.add-on').click
  # expect(page.has_content?('datepicker')).to be_true
  # wait_until { page.has_content?('datepicker') }
  # find('datepicker').find("td.day.active").click
  # fill_in('Date of the event', with: '01.01.1900')
  fill_in 'hour_counter', with: 1234 
  choose('Machine stopped')
  # should be an alarm code validator
  fill_in 'alarm_code', with: 700323
  click_button('Insert alarm')
  expect(page.has_css?('alarm-area'))
  fill_in 'event_description', with: "The machine stopped working with alarm number 700323 and after numerous attempts of restarting the machine, the alarm can't be canceled"
  click_button('Save')
end

Then(/^I have a new event saved$/) do
  expect(Event.all.count).to eq(@e+1)
  current_path.should == root_path
  expect(page).to have_content("Event succesfully registered!")
end

When(/^I register a new event with invalid data$/) do
  visit root_url
  click_link_or_button('New event')
  current_path.should == '/events/new'
  fill_in 'event_date', with: ''
  fill_in('hour_counter', with: '12')
  fill_in 'alarm_code', with: 'abcd'
  fill_in 'event_description', with: ""
  click_button('Save')
end

Then(/^I should see the registration form again$/) do
  expect(page).to have_selector('form#new_event')
end

Then(/^I should not have a new event saved$/) do
  expect(Event.all.count).to eq(@e.to_i)
end