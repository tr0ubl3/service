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

	def machine_display_name
		Machine.find_by_id(params[:machine]).display_name if params[:machine]
	end

	def machine_scoped(f)
		if params[:machine].nil?
			render :partial => "service_events/new_event_unscoped", :locals => { :f => f }
		else
			render :partial => "service_events/new_event_scoped"
		end
	end
end
