Feature: Admin functionality

Admin users have special functionality called control panel from where it can manage users (approving or denying user registration, creating new users, creating new admin users)

	Background:
		Given I'm an admin
		And New user registered
		When I receive a notification email regarding pending new user registration
		Then I click a link inside email
		And I should see login page
		Then I login with my credentials
		And I should see user details
	
	Scenario: Admin approve new user registration with email
		Then I click button to approve user registration
		And I receive an email regarding new user registration

	Scenario: Admin doesn't approve user registration with email
		And I click button to deny user registration
		And I receive an email with regarding user registration denial

	Scenario: Admin registers new user
		Given I'm on home page
		When I go to control panel
		And I create a new user
		Then I receive an email when new user is registered