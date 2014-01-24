Given(/^I'm an admin$/) do
  @admin = create(:admin)
  expect(@admin.admin).to be_true
end

Given(/^New user registered$/) do
  @machine_owners = create(:machine_owner)
  visit "/signup"
  select('Delphi', :from => 'user_machine_owner_id')
  fill_in "user_first_name", :with => "Daenerys"
  fill_in "user_last_name", :with => "Targaryen"
  fill_in "user_phone_number", :with => "0720123123"
  fill_in "user_email", :with => "daenerys.targaryen@mail.com"
  fill_in "user_password", :with => "securepass"
  fill_in "user_password_confirmation", :with => "securepass"
  click_button "Sign up"
  open_email('daenerys.targaryen@mail.com')
  current_email.should have_subject('Registration confirmation')
end

When(/^I receive a notification email regarding pending new user registration$/) do
  open_email(@admin.email)
  current_email.should have_subject('Pending new user confirmation')
end

Then(/^I click a link inside email$/) do
  open_email(@admin.email)
  click_first_link_in_email
end

Then(/^I should be redirected to user details$/) do
  @user = User.find_by_email('daenerys.targaryen@mail.com')
  current_path.should == '/users/' + @user.id.to_s
end

Then(/^I'm not logged into application$/) do
  page.set_rack_session(:user_id => @user.id)
  expect(page.get_rack_session_key(:user_id)).to be_nil
end

Then(/^I should see login page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^After login I should see user details$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see confirmation button$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^User is ok for registration$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I click button to approve user registration$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I receive a notification email regaring pending new user registration$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see Don't confirm button$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user is nok for registration$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I click button to disapprove registration$/) do
  pending # express the regexp above with the code you wish you had
end