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
		content_tag(:div, class: "dropdown pull-right navbar-text")	do
			if current_user
				raw("Logged in as #{link_top_right_menu(current_user)}") +
				dropdown_menu
			else
				link_to "Register", signup_path
			end
		end
	end

	private
	def link_top_right_menu(user)
		link_to user.full_name, "#", :class => "navbar-text navbar-link dropdown-toggle",
		 							 :data => { :toggle => "dropdown" } 
	end

	def dropdown_menu
		content_tag(:ul, class: "dropdown-menu", :role => "menu") do
			items_dropdown
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
