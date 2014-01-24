Feature: Authentification functionality

	Scenario: Succesful user login
		Given I am a guest
		And user with mail "bud.spencer@mail.com" exists
		When I fill login form with valid data for "bud.spencer@mail.com"
		Then I should be logged in as "Bud Spencer" user

	Scenario: Unsuccessful user login
		Given I am a guest
		When I fill login form with invalid data
		Then I should see an error
		And I'm not logged in application

	Scenario: User logout
		Given I am a "bud.spencer@mail.com" user
		When I go to logout page
		Then I should be logged out