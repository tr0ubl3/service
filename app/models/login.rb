class Login
	include ActiveAttr::BasicModel
	include ActiveAttr::MassAssignment
	attr_accessor :email, :password

	def authenticate
		user = User.find_by_email(email)
		if user && user.authenticate(password)
			user.id 
		else
			nil
		end 
	end
end