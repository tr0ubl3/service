Given(/^I am a guest$/) do
end

Given(/^I want to register on service web application$/) do
  @machine_owners = create(:machine_owner)
  visit "/signup"
end

When(/^I fill the register form with valid data$/) do
  current_path.should == '/signup'
  select('Delphi', :from => 'user_machine_owner_id')
  fill_in "user_first_name", :with => "Ionescu"
  fill_in "user_last_name", :with => "Vasile"
  fill_in "user_phone_number", :with => "1231231231"
  fill_in "user_email", :with => "ionescu@mail.com"
  fill_in "user_password", :with => "password123"
  fill_in "user_password_confirmation", :with => "password123"
  click_button "Sign up"
end

When(/^I succesfully submit the form$/) do
  expect(User.find_by_email('ionescu@mail.com')).not_to be_nil
end

Then(/^I receive an email regarding successfull submision of registration to admins$/) do
  email = ActionMailer::Base.deliveries.first
  email.from.should == ["noreply@service.com"]
  email.to.should == [User.last.email]
  email.subject.should include("Registration confirmation")
end

Then(/^Path should be login$/) do
  current_path.should == "/login"
end

When(/^I fill the register form with invalid data$/) do
  visit "/signup"
  # select('Delphi', :from => 'user_machine_owner_id')
  fill_in "user_first_name", :with => "I"
  fill_in "user_last_name", :with => "V"
  fill_in "user_phone_number", :with => "1"
  fill_in "user_email", :with => "ionescu"
  fill_in "user_password", :with => "password123"
  fill_in "user_password_confirmation", :with => "password123"
  click_button "Sign up"
end

Then(/^I should see the register form again$/) do
  expect(page).to have_selector('form#new_user')
end

Then(/^I should not be registered in application$/) do
  expect(User.find_by_email('ionescu')).to be_nil
end

When(/^I receive the confirmation account mail from application$/) do
  pending # express the regexp above with the code you wish you had
end 

Then(/^I shoud be able to login into application with my credentials$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be able to see the root index with all my firm machines listed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I was registered and waiting for confirmation$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^Waiting for confirmation of the account$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I received an email with denial reason$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I don't know about web application$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I received an email with registration details$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I can go and login in application with credentials from mail$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am an admin user$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I receive an email to approve a new user registration$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be able to click a link in mail to approve user registration$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^A confirmation mail should be sent to me$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I'm logged into application$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I approve a user from control panel$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should receive a confirmation mail$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I denny user registration from control panel$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should provide a reason of why I dennied registration$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should receive a confirmation mail with the reason$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be able to click a link in mail to denny user registration$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be redirected to application for entering a reason of denying$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I should be able to register a new regular user from control panel$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I should be able to register another admin user$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^user with mail  "(.*?)" exists$/) do |arg1|
  User.stub(:find).and_return(create(:user))
end

When(/^I fill login form with valid data for "(.*?)"$/) do |email|
  visit('/login')
  fill_in 'login_email', with: email
  fill_in 'login_password', with: 'securepass'
  click_button 'Sign in'
end

Then(/^I should be logged in as "(.*?)" user$/) do |name|
  expect(page).to have_content("Logged in as " + name)
end