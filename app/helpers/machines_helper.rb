module MachinesHelper
	def waranty_boolean(machine)
	    machine.delivery_date + machine.waranty_period.months > DateTime.now ? 'yes' : 'no'
	end
end
