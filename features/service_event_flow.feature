Feature: Service Event

Service event feature deals with event registration, event evaluation and event solving. 

A new service event can be registered by all users and contains some details regarding the event and has the following features:
- if the event is registered by a normal user he will be asked about the steps taken to solve that event;
- if the event is registered by an admin, he will not be asked to give the steps taken to solve event also he will not have to make an event evaluation.

An event evaluation has to be made after an event is registered by a normal user and the form contains : event recurent? (boolean), reported alarms confirm? (check box), description is confirmed?, upload some contents(video, foto), adding a more elabored description and classify the event cause (electrical , mechanical, hydraulic, pneumatic, software, etc.), upload some files with log files, alarms, etc after this step the event goes into solving state.

An event solving page will be formed by steps taken to solve the problem (like todo example form emberjs).


Background:
		Given I'm an admin
		And I'm logged in

Scenario: Admin goes from open event page to evaluate event page
	When I'm on a open event page
	Then I click button "Evaluate event"
	And I see evaluate event page

Scenario: Admin evaluates an event
	Given I'm on evaluate event page
	When I finished form
	Then I submit for and event gets into solving state