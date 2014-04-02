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

	def pending_events(machine=nil)
		if !machine.nil?
			pending_number = ServiceEvent.query_state('open').where(id: machine.id).count
		else
			pending_number = ServiceEvent.query_state('open').count
		end
	end

	def date_format(date, options = {})
		if options[:time]
			return date.strftime("%d.%m.%Y at %H:%M")
		else
			date.strftime("%d.%m.%Y")
		end
	end
end
