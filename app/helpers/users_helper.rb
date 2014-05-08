module UsersHelper
	def confirm_warning(user)
		"warning" unless user.approved_at?
	end
end
