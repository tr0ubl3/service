module ApplicationHelper
	def flash_class(type)
		case type
			when :alert
				'alert-error'
			when :notice
				'alert-success'
			else
				''
		end
	end

	def top_right_menu
		content_tag(:div, class: "navbar-link dropdown pull-right")	do
			if current_user
				"Logged in as #{current_user.full_name}"
			else
				link_to "Register", signup_path
			end
		end
	end
end
