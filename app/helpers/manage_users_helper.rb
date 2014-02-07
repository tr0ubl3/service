module ManageUsersHelper

	def confirm_warning(user)
		"warning" unless user.approved_at?
	end

	def user_confirmation_text(user)
		if user.approved_at?
			"No"
		else
			"Yes"
		end
	end
end
