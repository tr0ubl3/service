Given(/^I'm an admin$/) do
  @admin = create(:admin)
  @user = create(:user)
  expect(@admin.admin).to be_true
end

Given(/^New user registered$/) do
  @machine_owners = create(:machine_owner, :id => 1)
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

Then(/^I should see login page$/) do
  current_path.should == '/login'
end

Then(/^I login with my credentials$/) do
  fill_in('login_email', :with => 'jon.snow@mail.com')
  fill_in('login_password', :with => 'securepassword')
  click_button 'Sign in'
end

Then(/^I should see user details$/) do
  @new_user = User.last
  expect(current_path).to eq(user_path(@new_user))
  expect(page).to have_content("#{@new_user.full_name} details")
end

Then(/^I click button to approve user registration$/) do
  click_link('Approve registration')
end

Then(/^I receive an email regarding new user registration$/) do
  UserMailer.user_registration_approved_to_admin(@user, @admin).deliver
  open_email(@admin.email, :with_subject => "You approved #{@user.full_name} registration" )
end

Then(/^I click button to deny user registration$/) do
  click_link('Deny registration')
end

Then(/^I receive an email with regarding user registration denial$/) do
  UserMailer.user_registration_denied_to_admin(@user, @admin).deliver
  open_email(@admin.email, :with_subject => "You denied #{@user.full_name} registration" )
end

Given(/^I'm on home page$/) do
  visit('/')
  current_path.should == '/'
end

When(/^I go to control panel$/) do
  click_link 'Control panel'
  current_path.should == '/general/control_panel'
  click_link 'Manage users'
end

When(/^I create a new user$/) do
  click_link 'New client user'
  current_path.should == '/users/cp_new'
  select('Delphi', :from => 'user_machine_owner_id')
  fill_in "user_first_name", :with => "Daenerys"
  fill_in "user_last_name", :with => "Targaryen"
  fill_in "user_phone_number", :with => "0720123123"
  fill_in "user_email", :with => "daenerys.targaryen@mail.com"
  click_button "Register user"
end

Then(/^I receive an email when new user is registered$/) do
  UserMailer.new_user_invitation_to_admin(@user, @admin).deliver
  open_email(@admin.email, :with_subject => "You sent ivitation to #{@user.full_name}" )
end