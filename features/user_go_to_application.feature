Feature: user register a problem

As a user
I want to go to service application
So that i can register a problem

Scenario:  open application
	Given I am not yet on web application
	When I open application
	Then I should see "International G&T web platform"
	And I should see "Login"
