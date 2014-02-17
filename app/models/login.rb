class Login
	include ActiveAttr::BasicModel
	include ActiveAttr::MassAssignment
	attr_accessor :email, :password

	def conditional_authentication
		user = User.find_by_email(email)
		if user && user.authenticate(password) && check_approval(user) && user.confirmed
			user.id 
		else
			nil
		end 
	end

	private
	def check_approval(user)
		if user.approved_at?
			return true
		else
			return false
		end
	end
end