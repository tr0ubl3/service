Feature: Top menu
	
	Top menu is available only to logged in users.
	Registered users see Service (link to home), Account settings link and Logout link.
	Admin see the same thing the user does, but it has also the Control Panel link and notification bullets for new user registration and waiting for approval and for new event related to machines.

	Scenario: Guest user
		Given I am a guest user
		When I go to home page
		Then I see login page

	Scenario: Registered user
		Given I am a registered user
		And I'm logged in
		When I am on home page
		Then I see "Daenarys Targaryen" menu

	Scenario: Admin user
		Given I am an admin user
		And I'm logged in
		When I am on home page
		Then I see "Jon Snow" menu
		And I see also notification bullets