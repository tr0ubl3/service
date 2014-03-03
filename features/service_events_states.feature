Feature: Service event states

Service event can have 4 states : open, evaluated, solved, closed.
After creation an event has automatically assigned open state and an email is sent to admin users. 
After an event has been evaluated by an admin user the event gets into evaluated state. 
The event now can be solved by an admin user and here the steps taken to solve will be recorded, and after the event is solved the event will transition to solved state. 
If the event is not pending parts then it will automatically goes into closed state.

Scenario: Open state of service event
	Given I'm a registered user or admin
	When I successfully submit a new service event
	Then Then service event state is open

Scenario: Evaluated state of service event
	Given I'm an admin
	When I successfully submit a service event evaluation
	Then service event state is evaluated

Scenario: Solved state of service event
	Given I'm an admin
	When I successfully solve an event
	Then service event state is solved

Scenario: Closed state of service event
	When service event is solved
	And It doesn't need spare parts
	Then the event state is closed
