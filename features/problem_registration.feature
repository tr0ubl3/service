Feature: User register a problem
	
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