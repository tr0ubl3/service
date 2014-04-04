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

	def machine_types(machines)
		machines.collect(&:machine_group).collect(&:name).uniq
	end

	def machines_collection(machines, manufacturer_name)
		machines.where(:machine_group_id => Manufacturer.find_by_name(manufacturer_name).machine_groups)
	end
end
