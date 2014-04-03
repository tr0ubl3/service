module GeneralHelper
	
	def machine_status(machine, options={})
		if options[:status] && pending_events(machine) > 0
			return 'alarm'
		elsif options[:title]
			return title = "#{pending_events(machine)} #{"event".pluralize(pending_events(machine))} pending evaluation"
		elsif options[:icon]	
			if pending_events(machine) > 0
				return 'icon-exclamation-sign blink'
			else
				return 'icon-ok'
			end
		end 
	end

	def machine_types(manufacturer_name)
		@machines.where(:manufacturer_id => Manufacturer.find_by_name(manufacturer_name).id).collect(&:machine_type).uniq
	end

	def machines_collection(manufacturer_name, machine_type)
		@machines.where(:manufacturer_id => Manufacturer.find_by_name(manufacturer_name).id,
		                :machine_type => machine_type)
	end
end
