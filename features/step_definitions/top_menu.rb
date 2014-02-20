Given(/^I am a guest user$/) do
  page.set_rack_session(:user_id => nil)
end

When(/^I go to home page$/) do
  visit root_url
end

Then(/^I see login page$/) do
  current_path.should == login_path
  expect(page).to have_content("Please login to see page")
end

Given(/^I am a registered user$/) do
  @registered_user = create(:user2, approved_at: Time.now, confirmed: true) 
  create(:machine_owner, :id => 1)
end

Given(/^I'm logged in$/) do
  visit login_path
  fill_in "login_email", with: @registered_user.email
  fill_in "login_password", with: @registered_user.password
  click_button "Sign in"
end

When(/^I am on home page$/) do
  current_path.should == root_path
end

Then(/^I see "(.*?)" menu$/) do |arg1|
  expect(page).to have_content("Logged in as #{arg1}")
  expect(page).to have_link("Account settings", href: control_panel_general_index_path)
  expect(page).to have_link("Logout", href: logout_path)
end