When(/^I'm on "(.*?)" event page$/) do |arg1|
  @event = create(:service_event, user: @admin)
  visit service_event_path(@event)
  current_path.should == service_event_path(@event)
end

Then(/^I click button "(.*?)"$/) do |arg1|
  click_link arg1
end

Then(/^I see evaluate event page$/) do
  current_path.should == evaluate_service_event_path(@event)
end

Given(/^I'm on evaluate event page$/) do
  @event = create(:service_event, user: @admin)
  visit evaluate_service_event_path(@event)
  current_path.should == evaluate_service_event_path(@event)
end

When(/^I finished form$/) do
	current_path.should == evaluate_service_event_path(@event)
	choose "False"
	fill_in "event_description", with: "The machine doesn't have power"
	click_button "Save"
end

Then(/^I submit form and event gets into "(.*?)" state$/) do |arg1|
  @event.reload
  expect(@event.current_state).to eq(arg1)
end

Then(/^I'm redirected to show event page$/) do
  current_path.should == service_event_path(@event)
end

Then(/^I see evaluation details$/) do
  expect(page).to have_content("The machine doesn't have power")
end

Then(/^I don't see Evaluate event button$/) do
  expect(page).not_to have_selector("a", text: "Evaluate event")
end

When(/^I'm on show event page$/) do
  visit service_event_path(@event)
  current_path.should == service_event_path(@event)
end