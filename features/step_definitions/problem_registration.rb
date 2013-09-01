# Given(/^I am a guest$/) do
# end

# When(/^I visit application root address$/) do
# 	visit('/')
# end

# Then(/^I should be redirected to login page$/) do
# 	current_path.should == "/users/sign_in"
# end

# Then(/^I should see "(.*?)"$/) do |arg1|
# 	 arg1 = ['Login', 'Create an account ...']
# 	 arg1.each do |n|
# 		 page.should have_content(n)
# 	 end
# end 
Given(/^I have a problem$/) do
	puts 'I or machine utilisers observed a new event(problem) on a machine'
end

When(/^I register my new event/) do
  visit('/')
  click_link_or_button('New event')
  current_path.should == '/events/new'
  select('MH.329', :from => 'machine_list')
  select('Date of event', :from => 'date')
  fill_in 'machine_hour_counter', with: '1234'
  choose('Machine stopped')
  # should be an alarm code validator
  fill_in 'alarm_code', with: '700323'
  click_button('Insert')
  fill_in 'event_description', with: "The machine stopped working with alarm number 700323 and after numerous attempts of restarting the machine, the alarm can't be canceled"
  click_button('Submit')
end

Then(/^I have a new problem saved$/) do
	current_path.should == "/events/event_confirmation"
	page.should have_content('Problem saved and pending confirmation')
end