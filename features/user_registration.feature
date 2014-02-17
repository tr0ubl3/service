Feature: User registration
	Regular user registration
		In order for a regular user to be registered there are two ways to do it:
			1. He has to go to the sign up page and choose his working firm, fill in first and last name, phone number, email and password. After registration a confirmation email is sent to admins for approval. After the regular user registration is approved he can login and work with the application.
			2. The user is registered by an existing admin user using the control panel from the application
	Admin user registration	
		A new admin user can be registered only by another existing admin user through control panel from the application.
		It's important that only admin users can create another users.

Scenario: Successfully registering through web form application
	Given I am a guest
	And I want to register on service web application
	When I fill the register form with valid data
	And I succesfully submit the form
	Then I receive an email regarding successfull submision of registration to admins
	And Path should be login

Scenario: I try to register with invalid data
	Given I am a guest
	When I fill the register form with invalid data
	Then I should see the register form again
	And I should not be registered in application	

Scenario: The registration is confirmed, and user clicks confirmation in email
	Given I am a guest
	And I've registered before with "daenarys.targaryen@mail.com"
	And I'm waiting for account confirmation
	And I can't login yet into application
	When I receive the confirmation account email from application
	Then I click the confirmation link
	Then I login into application with my credentials
	And I receive an welcome email
	And I see the root index with all my firm machines listed

Scenario: The registration is confirmed, but user didn't click on confirmation link in email
	Given I am a guest
	And I've registered before with "daenarys.targaryen@mail.com"
	And I'm waiting for account confirmation
	And I can't login yet into application
	When I receive the confirmation account email from application
	Then I try to login with my credentials
	But I'm not logged into application

Scenario: The registration is denied
	Given I was registered and waiting for confirmation
	And Waiting for confirmation of the account
	Then I received an email with denial reason

Scenario: I received a registration invitation
	Given I don't know about web application
	And I received an email with registration invitation
	Then I click the link from invitation
	And I enter credentials from email
	And I'm logged into application
	And I receive an welcome email

Scenario: I receive admin confirmation
