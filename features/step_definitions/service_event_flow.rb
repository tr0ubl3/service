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