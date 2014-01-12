class UserRegistrationNotifier < Devise::Mailer
	helper :application # gives access to all helpers defined within `application_helper`.
	include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

	def registration_confirmation(user)
		mail subject: "Registration confirmation", to: user.email, from: "noreply@service.com"
	end
end