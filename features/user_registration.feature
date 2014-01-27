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

Scenario: The registration is confirmed
	Given I am a guest
	And I've registered before with "daenarys.targaryen@mail.com"
	And I'm waiting for account confirmation
	And I can't login yet into application
	When I receive the confirmation account email from application
	Then I shoud be able to login into application with my credentials
	And I should be able to see the root index with all my firm machines listed

Scenario: The registration is denied
	Given I was registered and waiting for confirmation
	And Waiting for confirmation of the account
	Then I received an email with denial reason

Scenario: I received a registration invitation
	Given I don't know about web application
	And I received an email with registration details
	Then I can go and login in application with credentials from mail

Scenario: Approving new regular user registration from mail
	Given I am an admin user
	When I receive an email to approve a new user registration
	Then I should be able to click a link in mail to get me to user approval page
	And I should login into application with my admin credentials
	Then I should see user details and approval button
	And I approve
	And I have a confirmation email in inbox

Scenario: Approving new regular user registration from application
	Given I am an admin user
	And I'm logged into application
	When I approve a user from control panel
	Then I should receive a confirmation mail

Scenario: Denying registration of a regular user from application
	Given I am an admin user
	And I'm logged into application
	When I denny user registration from control panel
	Then I should provide a reason of why I dennied registration
	Then I should receive a confirmation mail with the reason

Scenario: Denying registration of a regular user from mail
	Given I am an admin user
	When I receive an email to approve a new user registration
	Then I should be able to click a link in mail to denny user registration
	And I should be redirected to application for entering a reason of denying

Scenario: New regular user registration
	Given I am an admin user
	And I'm logged into application
	And I should be able to register a new regular user from control panel
	Then I should receive a confirmation mail

Scenario: Admin user registration
	Given I am an admin user
	And I'm logged into application
	And I should be able to register another admin user
	Then I should receive a confirmation mail