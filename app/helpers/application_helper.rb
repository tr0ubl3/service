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

	def pending_users
		pending_number = User.where(:approved_at => nil).count
	end

	def pending_events
		pending_number = ServiceEvent.query_state('open').count
	end

	def date_format(date, options = {})
		date.strftime("%d.%m.%Y")

		if options[:time]
			return date.strftime("%d.%m.%Y at %H:%M")
		end
	end
end
