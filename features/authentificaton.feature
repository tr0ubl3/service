Feature: Authentification functionality

	Scenario: Succesfull user login
		Given I am a guest
		And user with mail "bud.spencer@mail.com" exists
		When I fill login form with valid data for "bud.spencer@mail.com"
		Then I should be logged in as "Bud Spencer" user