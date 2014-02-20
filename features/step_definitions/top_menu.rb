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