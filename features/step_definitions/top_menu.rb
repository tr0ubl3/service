def login_user(user)
  visit login_path
  fill_in "login_email", with: user.email
  fill_in "login_password", with: user.password
  click_button "Sign in"
end

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
  login_user(@registered_user || @admin)
end

When(/^I am on home page$/) do
  current_path.should == root_path
end

Then(/^I see "(.*?)" menu$/) do |arg1|
  expect(page).to have_content("Logged in as #{arg1}")
  expect(page).to have_link("Account settings", href: edit_user_path(@registered_user || @admin))
  expect(page).to have_link("Logout", href: logout_path)
end

Given(/^I am an admin user$/) do
  @admin = create(:admin)
  create(:machine_owner, id: 3)
  create(:user2)
end

Then(/^I see also notification bullets$/) do
  expect(page).to have_selector("div.admin_notifications")
  expect(page).to have_selector("div.admin_notifications>a.users_pending")
  expect(page).to have_selector("div.admin_notifications>a.service_events_pending")
end

When(/^I go to user menu and go to account settings$/) do
  current_path.should == root_path
  click_link "Account settings"
end

Then(/^I change my account settings$/) do
  fill_in "user_email", with: "bud2.spencer@mail.com"
  fill_in "user_password", with: "newsecurepassword"
  fill_in "user_password_confirmation", with: "newsecurepassword"
  fill_in "user_current_password", with: @registered_user.password
  click_button "Update"
  current_path.should == root_path
  expect(page).to have_content("You successfully updated your account")
end

When(/^I go to user menu$/) do
  click_link "#{@registered_user.full_name}"
end

Then(/^I choose logout$/) do
  click_link "Logout"
end

Then(/^I'm logged out from application$/) do
  current_path.should == login_path
end