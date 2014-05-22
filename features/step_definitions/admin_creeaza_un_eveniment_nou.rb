Datfiind(/^ca sunt sunt admin$/) do
  @admin = create(:admin)
  @machine = create(:machine)
end

Datfiind(/^sunt autentificat$/) do
  visit '/login'
  fill_in 'email', with: @admin.email
  fill_in 'password', with: @admin.password
  click_button 'Sign in'
  current_path.should == '/'
end

Datfiind(/^ca sunt pe pagina de creare a unui eveniment nou$/) do
	click_link 'MH.331'
	current_path.should == machine_service_events_path(@machine)
	click_link 'Create new event'
	current_path.should == new_machine_service_event_path(@machine)
end

Datfiind(/^completez forumularul cu date corecte$/) do
  find_field('Date of the event').click
  fill_in 'hour_counter', with: '1001'
  choose('Machine stopped')
  fill_in 'alarm_code', with: '700121'
  click_button 'Insert alarm'
  fill_in 'event_description', with: 'New test event'
end

Datfiind(/^aleg ca urmatorul pas sa fie diagnoza\(debugging\)$/) do
  select('Yes', :from => 'Need debugging?')
  click_button 'Save'
end