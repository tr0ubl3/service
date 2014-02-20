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

	def admin_notifications
		if pending_users > 0 && admin?
			content_tag(:div, class: "admin_notifications", 
						title: "#{pending_users} users pending confirmation") do
				link_to manage_users_path do
					raw("<span class='badge badge-info'>
							<i class='icon-user'></i> #{pending_users}
					</span>")
				end
			end
		else
			raw("")
		end
	end

	def pending_users
		pending_number = User.where(:approved_at => nil).count
	end

	def admin?
		current_user.admin?
	end

	private

	def link_top_right_menu(user)
		link_to user.full_name, "#", :class => "navbar-text navbar-link dropdown-toggle",
		 							 :data => { :toggle => "dropdown" } 
	end

	def dropdown_menu
		content_tag(:ul, class: "dropdown-menu", :role => "menu") do
			items_dropdown if admin?
		end
	end

	def items_dropdown
		content_tag(:li) do
			link_to control_panel_general_index_path do
				raw("<i class='icon-wrench'></i> Control panel")
			end
		end
	end

end
