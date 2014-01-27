Given(/^I am a guest$/) do
end

Given(/^I want to register on service web application$/) do
  @machine_owners = create(:machine_owner)
  visit "/signup"
end

When(/^I fill the register form with valid data$/) do
  current_path.should == '/signup'
  select('Delphi', :from => 'user_machine_owner_id')
  fill_in "user_first_name", :with => "Daenerys"
  fill_in "user_last_name", :with => "Targaryen"
  fill_in "user_phone_number", :with => "0720123123"
  fill_in "user_email", :with => "daenerys.targaryen@mail.com"
  fill_in "user_password", :with => "securepass"
  fill_in "user_password_confirmation", :with => "securepass"
  click_button "Sign up"
end

When(/^I succesfully submit the form$/) do
  expect(User.find_by_email('daenerys.targaryen@mail.com')).not_to be_nil
end

Then(/^I receive an email regarding successfull submision of registration to admins$/) do
  expect(unread_emails_for("daenerys.targaryen@mail.com").size).to eq(1)
end

Then(/^Path should be login$/) do
  current_path.should == "/login"
end

When(/^I fill the register form with invalid data$/) do
  visit "/signup"
  # select('Delphi', :from => 'user_machine_owner_id')
  fill_in "user_first_name", :with => "D"
  fill_in "user_last_name", :with => "T"
  fill_in "user_phone_number", :with => "1"
  fill_in "user_email", :with => "daenerys"
  fill_in "user_password", :with => "password123"
  fill_in "user_password_confirmation", :with => "password123"
  click_button "Sign up"
end

Then(/^I should see the register form again$/) do
  expect(page).to have_selector('form#new_user')
end

Then(/^I should not be registered in application$/) do
  expect(User.find_by_email('daenerys')).to be_nil
end

Given(/^I've registered before with "(.*?)"$/) do |email|
  @user = create(:user2)
  expect(User.find_by_email(email)).not_to be_nil
end

Given(/^I'm waiting for account confirmation$/) do
  expect(@user.approved_at).to be_nil
end

Given(/^I can't login yet into application$/) do
  login = Login.new(email: @user.email, password: @user.password)
  expect(login.conditional_authentication).to be_nil
end

When(/^I receive the confirmation account email from application$/) do
  UserMailer.user_registration_approved(@user).deliver
  open_email(@user.email, :with_subject => "Your registration has been approved" )
end 

Then(/^I shoud be able to login into application with my credentials$/) do
  @user.update_attributes(:approved_at => Time.now)
  visit "/login"
  fill_in "login_email", :with => "#{@user.email}"
  fill_in "login_password", :with => "#{@user.password}"
  click_button "Sign in"
end

Then(/^I should be able to see the root index with all my firm machines listed$/) do
  current_path.should == "/"
  expect(page).to have_content('')
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

Given(/^user with mail "(.*?)" exists$/) do |arg1|
  User.stub(:find).and_return(create(:user))
end

When(/^I fill login form with valid data for "(.*?)"$/) do |email|
  visit('/login')
  fill_in 'login_email', with: email
  fill_in 'login_password', with: 'securepassword'
  click_button 'Sign in'
end

Then(/^I should be logged in as "(.*?)" user$/) do |name|
  expect(page).to have_content("Logged in as " + name)
end

When(/^I fill login form with invalid data$/) do
  visit('/login')
  fill_in 'login_email', with: 'test@mail.com'
  fill_in 'login_password', with: 'securepass'
  click_button 'Sign in'
end

Then(/^I should see an error$/) do
  expect(page).to have_content('Invalid email or password')
end

Then(/^I'm not logged in application$/) do
  current_path.should == '/login'
end

Given(/^I am a "(.*?)" user$/) do |arg1|
end

When(/^I go to logout page$/) do
  visit('/logout')
end

Then(/^I should be logged out$/) do
  current_path.should == '/login'
end