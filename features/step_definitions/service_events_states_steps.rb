Given(/^I'm a registered user or admin$/) do
	@admin = create(:admin_2)
	login_user(@admin)
	current_path.should == root_path
	click_link "MH.331"
	current_path.should == machine_events_general_index_path
	click_link "Create new event"
end

When(/^I successfully submit a new service event$/) do
	current_path.should == new_service_event_path
	fill_in "hour_counter", with: 1001
	choose "Machine stopped"
	fill_in "event_description", with: "Just testing"
	click_button "Save"
	current_path.should == root_path 
end

Then(/^Then service event state is open$/) do
  event = ServiceEvent.last
  expect(event.state).to eq("open")
end