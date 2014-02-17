Given(/^I'm an admin$/) do
  @admin = create(:admin)
  @user = create(:user)
  @user2 = create(:user2)
  @machine_owners = create(:machine_owner, :id => 3)
  expect(@admin.admin).to be_true
end

Given(/^New user registered$/) do
  visit "/signup"
  select('Delphi', :from => 'user_firm_id')
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

Then(/^I click link to approve user registration$/) do
  click_link('Approve registration')
end


Then(/^I receive an email regarding new user registration$/) do
  UserMailer.user_registration_approved_to_admin(@user, @admin).deliver
  open_email(@admin.email, :with_subject => "You approved #{@user.full_name} registration" )
end

When(/^I receive an email regarding user registration$/) do
  open_email(@admin.email)
  current_email.should have_subject('Pending new user confirmation')
end

Then(/^I click link to deny user registration$/) do
  click_link('Deny registration')
end

Then(/^I receive an email with regarding user registration denial$/) do
  UserMailer.user_registration_denied_to_admin(@user, @admin).deliver
  open_email(@admin.email, :with_subject => "You denied #{@user.full_name} registration" )
end

Given(/^I'm on home page$/) do
  visit login_path
  fill_in(:email, :with => @admin.email)
  fill_in(:password, :with => @admin.password)
  click_button "Sign in"
  visit('/')
  current_path.should == '/'
end

When(/^I go to control panel$/) do
  click_link 'Control panel'
  current_path.should == '/general/control_panel'
  click_link 'Manage users'
end

When(/^I successfully create a new user$/) do
  reset_mailer
  click_link 'New client user'
  current_path.should == '/users/cp_new'
  select('Delphi', :from => 'user_firm_id')
  fill_in "user_first_name", :with => "Vasile"
  fill_in "user_last_name", :with => "Ionescu"
  fill_in "user_phone_number", :with => "0720123123"
  fill_in "user_email", :with => "vasile.ionescu@email.com"
  click_button "Save user"
  current_path.should == manage_users_path
  expect(page).to have_content("You successfully created user Vasile Ionescu")
end

Then(/^I receive an email when new user is registered$/) do
  open_email(@admin.email)
  expect(current_email).to have_subject("You sent invitation to Vasile Ionescu")
end

When(/^I fill new user form with invalid data$/) do
  click_link 'New client user'
  current_path.should == '/users/cp_new'
  select('', :from => 'user_firm_id')
  fill_in "user_first_name", :with => ""
  fill_in "user_last_name", :with => ""
  fill_in "user_phone_number", :with => ""
  fill_in "user_email", :with => ""
  click_button "Save user"
end

Then(/^I should see the new user form again$/) do
  expect(page).to have_content("Sign up new user")
end

Then(/^I should see form errors$/) do
  expect(page).to have_content("Invalid form values")
end

When(/^I choose manage users$/) do
  current_path.should == manage_users_path
end

Then(/^I should see users pending confirmation$/) do
  expect(page).to have_selector("th", "Pending confirmation")
  expect(page).to have_selector('tr', :text => @user2.full_name && "Yes")
end

Then(/^I can click user to see details$/) do
  click_link @user2.full_name
  current_path.should == user_path(@user2)
end

Then(/^I'm able to confirm or no registration$/) do
  expect(page).to have_link("Approve registration" && "Deny registration")
end

Given(/^A user is pending confirmation$/) do
  @user_pending = User.where(:approved_at => nil).count
  @user_pending.should be > 0
end

Then(/^I see how many users are pending registration confirmation$/) do
  current_path.should == "/"
  expect(page).to have_selector("div.admin_notifications", text: "#{@user_pending}")
end

Then(/^I click flashing bullet$/) do
  click_link "#{@user_pending}"
end

Then(/^I see manage users page$/) do
  current_path.should == manage_users_path
end

Given(/^Is no user pending confirmation$/) do
  @user2.destroy
end

When(/^I'm logged in application$/) do
  page.set_rack_session(:user_id => @admin.id)
  visit root_path
  current_path.should == '/'
end

Then(/^I don't see a bullet with users pending confirmation$/) do
  @user_pending = User.where(:approved_at => nil).count
  expect(page).not_to have_selector("div.admin_notifications", text: "#{@user_pending}")
end

When(/^I'm on manage users page$/) do
  page.set_rack_session(:user_id => @admin.id)
  visit manage_users_path
  current_path.should == manage_users_path
end

Then(/^I click Admin users link$/) do
  click_link "Admin users"
end

Then(/^I click new admin user to register new admin$/) do
  click_link "New admin"
  current_path.should == new_admin_users_path
end

When(/^I successfully submit admin user form$/) do
  reseller = create(:authorized_reseller, :id => 2)
  fill_in "user_first_name", :with => "Ned"
  fill_in "user_last_name", :with => "Stark"
  fill_in "user_phone_number", :with => 123123123
  fill_in "user_email", :with => "ned.stark@email.com"
  click_button "Save admin"
  # expect(page).to have_content("You successfully registered Ned Stark admin user")
end

Then(/^I receive an email regarding succesfull admin registration$/) do
  open_email(@admin.email, :with_subject => "You successfully registered new admin user Ned Stark")
end

Then(/^I'm redirected to manage users$/) do
  current_path.should == manage_users_path
end

Then(/^I see successfull flash message$/) do
  expect(page).to have_content("You successfully registered admin user Ned Stark")
end

Then(/^I fill register form with invalid data$/) do
  reseller = create(:authorized_reseller, :id => 2)
  fill_in "user_first_name", :with => ""
  fill_in "user_last_name", :with => ""
  fill_in "user_phone_number", :with => ""
  fill_in "user_email", :with => "n.s@email.com"
  click_button "Save admin"
end

Then(/^I see the form again$/) do
  expect(page).to have_content("Sign up new admin")
end

Then(/^I see an error flash message$/) do
  expect(page).to have_content("Invalid form values")
end

When(/^I'm a registered user$/) do
  @machine_owners.destroy unless @machine_owners == nil
  @user = create(:user) if @user == nil
  create(:machine_owner, :id => 1)
  visit login_path
  fill_in('login_email', :with => @user.email)
  fill_in('login_password', :with => @user.password)
  click_button 'Sign in'
  current_path.should == "/"
end

Then(/^I don't see control panel link$/) do
  expect(page).not_to have_link("Control panel", :href => control_panel_general_index_path)
end

Then(/^I cannot access control panel$/) do
  visit control_panel_general_index_path
  current_path.should == root_path
end