Given(/^I have a problem$/) do
	puts 'Me or machine utilisers observed a new event(problem) on a machine'
end

When(/^I register my new event/) do
  visit root_url
  click_link_or_button('New event')
  current_path.should == '/events/new'
  select('MH.356', :from => 'event_machine_id')
  fill_in 'event_event_date', with: '05.09.2013'
  fill_in('Hour counter', with: '1234')
  choose('Machine stopped')
  # should be an alarm code validator
  fill_in 'alarm_code', with: '700323'
  # click_button('Insert alarm')
  fill_in 'event_description', with: "The machine stopped working with alarm number 700323 and after numerous attempts of restarting the machine, the alarm can't be canceled"
  click_button('Save')
end

Then(/^I have a new event saved$/) do
  visit root_url
  click_link_or_button('New event')
  current_path.should == '/events/new'
  fill_in 'event_event_date', with: '2013'
  fill_in('Hour counter', with: 'abcd')
  fill_in 'alarm_code', with: '@@@'
  fill_in 'event_description', with: "12313"
  click_button('Save')
end

When(/^I register a new event with invalid data$/) do
  expect(page).to have_selector('form#new_event')
end

Then(/^I should see the registration form again$/) do
  expect(Event.find_by_id(1)).to be_nil
end

Then(/^I should not have a new event saved$/) do
  pending # express the regexp above with the code you wish you had
end