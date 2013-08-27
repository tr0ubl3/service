Feature: User register a problem
	
	In order to have a history of events(problems) on each machine in Delphi and to be announced when a new problem occures, me or the machine utilisers have to register a new event(problem) in the database.


Scenario:  User register a new problem
	Given I have a problem 
	When I register my new event
	Then I have a new problem saved 

