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

	def event_type(event)
		case event.event_type
		when 1
			return "Machine fully stopped"
		when 2
			return "Machine is working with problems"
		when 3
			return "Event unrelated to machine stopping"
		end
	end

	def pending_users
		pending_number = User.where(:approved_at => nil).count
	end

	def pending_events(machine=nil)
		if !machine.nil?
			pending_number = ServiceEvent.query_state('open').where(machine_id: machine.id).length
		else
			pending_number = ServiceEvent.query_state('open').length
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
