Feature: Admin functionality

Admin users have special functionality called control panel from where it can manage users (approving or denying user registration, creating new users, creatimg new admin users)

	Background:
		Given I'm an admin
		And New user registered
	
	Scenario: Admin approve new user registration with email
		When I receive a notification email regarding pending new user registration
		Then I click a link inside email
		And I should be redirected to user details
		But I'm not logged into application
		And I should see login page
		And After login I should see user details
		And I should see confirmation button
		When User is ok for registration
		Then I click button to approve user registration

	Scenario: Admin doesn't approve user registration with email
		When I receive a notification email regaring pending new user registration
		Then I click a link inside email
		And I should be redirected to user details
		But I'm not logged into application
		And I should see login page
		And After login I should see user details
		And I should see Don't confirm button
		When user is nok for registration
		Then I click button to disapprove registration