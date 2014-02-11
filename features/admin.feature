Feature: Admin functionality

Admin users have special functionality called control panel from where it can manage users (approving or denying user registration, creating new users, creating new admin users)

	Background:
		Given I'm an admin
	
	Scenario: Admin approve new user registration with email
		And New user registered
		Then I receive a notification email regarding pending new user registration
		And I click a link inside email
		Then I should see login page
		And I login with my credentials
		Then I should see user details
		And I click link to approve user registration
		Then I receive an email regarding new user registration

	Scenario: Admin doesn't approve user registration with email
		And New user registered
		When I receive an email regarding user registration
		Then I click a link inside email
		And I should see login page
		Then I login with my credentials
		And I should see user details
		Then I click link to deny user registration
		And I receive an email with regarding user registration denial

	Scenario: Admin successfully registers new user
		Given I'm on home page
		When I go to control panel
		And I successfully create a new user
		Then I receive an email when new user is registered

	Scenario: Admin tries to register new user
		Given I'm on home page
		When I go to control panel
		And I fill new user form with invalid data
		Then I should see the new user form again
		And I should see form errors

	Scenario: Admin sees users pending confirmation from manage users
		Given I'm on home page
		When I go to control panel
		And I choose manage users
		Then I should see users pending confirmation
		And I can click user to see details
		And I'm able to confirm or no registration

	Scenario: Admin sees a flashing bullet when are pending confirmation users
		Given A user is pending confirmation
		When I'm on home page
		Then I see how many users are pending registration confirmation
		And I click flashing bullet
		Then I see manage users page

	Scenario: Admin doesn't see a flashing bullet when are no pending confirmation users
		Given Is no user pending confirmation
		When I'm logged in application
		Then I don't see a bullet with users pending confirmation	

	Scenario: Admin user registers another admin user
		When I'm on manage users page
		Then I click Admin users link
		And I click new admin user to register new admin
		When I successfully submit admin user form
		Then I receive an email regarding succesfull admin registration
		And I'm redirected to manage users
		Then I see successfull flash message



