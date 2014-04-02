module GeneralHelper
	
	def machine_status(machine, options={})
		case options
		when [:status] && pending_events
			return 'alarm'
		end 
	end


	def event_status(machine)
		events_count(machine)
		content_tag(:div, :class => @status, :title => "", :data =>{ title: @data_title} ) do
			raw("<i class='#{@icon}'></i>") +
			raw("<div class='machine-name'>#{machine.display_name}</div>")
		end
	end

	def machine_types(manufacturer_name)
		@machines.where(:manufacturer_id => Manufacturer.find_by_name(manufacturer_name).id).collect(&:machine_type).uniq
	end

	def machines_collection(manufacturer_name, machine_type)
		@machines.where(:manufacturer_id => Manufacturer.find_by_name(manufacturer_name).id,
		                :machine_type => machine_type)
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
