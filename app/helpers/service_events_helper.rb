module ServiceEventsHelper

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
end
