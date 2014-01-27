module GeneralHelper
	def event_status(machine)
		events_count(machine)
		content_tag(:div, :class => @status, :title => "", :data =>{ title: @data_title} ) do
			raw("<i class='#{@icon}'></i>") +
			raw("<div class='machine-name'>#{machine.display_name}</div>")
		end
	end
	
	private
	def events_count(machine)
		@events_count = machine.service_events.where(:state => 'pending_confirmation').count
		@data_title = @events_count.to_s + " unsolved " + "event".pluralize(@events_count)
		if @events_count > 0
			@status = 'machine alarm'
			@icon = 'icon-exclamation-sign corner-icon blink'
		else
			@status = 'machine'
			@icon = 'icon-ok corner-icon'
		end
	end
end
