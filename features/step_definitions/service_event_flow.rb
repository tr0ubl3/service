When(/^I'm on a open event page$/) do
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
	choose "False"
	
end

Then(/^I submit form and event gets into solving state$/) do
  pending # express the regexp above with the code you wish you had
end