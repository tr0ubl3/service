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

	# def top_right_menu
	# 	content_tag(:div, class: "dropdown pull-right navbar-text")	do
	# 		if current_user
	# 			admin_notifications +
	# 			raw("Logged in as #{link_top_right_menu(current_user)}") +
	# 			dropdown_menu
	# 		else
	# 			link_to "Register", signup_path
	# 		end
	# 	end
	# end

	# def admin_notifications
	# 	if pending_users > 0 && admin?
	# 		content_tag(:div, class: "admin_notifications", 
	# 					title: "#{pending_users} users pending confirmation") do
	# 			link_to manage_users_path do
	# 				raw("<span class='badge badge-info'>
	# 						<i class='icon-user'></i> #{pending_users}
	# 				</span>")
	# 			end
	# 		end
	# 	else
	# 		raw("")
	# 	end
	# end

	def pending_users
		pending_number = User.where(:approved_at => nil).count
	end

	def pending_events
		pending_number = ServiceEvent.where(state: 'pending_confirmation').count
	end

	def date_format(date, options = {})
		date.strftime("%d.%m.%Y")

		if options[:time]
			return date.strftime("%d.%m.%Y at %H:%M")
		end
	end

end
