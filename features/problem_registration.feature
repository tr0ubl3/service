Feature: Regular user registration

	In order for a regular user to register, he has to go to the sign up page and choose his working firm, fill in first and last name, phone number, email and password. After registration a confirmation email is sent to admins for approval. After the regular user registration is approved he can login and work with the application.
 	
	In order to have a history of events(problems) on each machine in Delphi and to be announced when a new problem occures, me or the machine utilisers have to register a new event(problem) in the database.
 
Scenario:  User register a new problem
	Given I have a problem 
	When I register my new event
	Then I have a new event saved

Scenario: User tries to register a new problem with invalid data
	Given I have a problem
	When I register a new event with invalid data
	Then I should see the registration form again
	And I should not have a new event saved