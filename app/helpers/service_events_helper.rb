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

	def evaluate_event_button(event)
		if event.open?
			link_to "Evaluate event", evaluate_service_event_path(event), :class => "btn btn-primary"
		else
			return
		end
	end

	def rowspan_files(event)
		calc = (event.service_event_files.count / 4.0).round(2)
		
		if calc.modulo(1).round(2).between?(0.1, 0.5)
			return (calc + 2).round
		else
			return (calc + 1).round
		end

	end
end
