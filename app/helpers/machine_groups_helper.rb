module MachineGroupsHelper
	def group_name(group)
		return group.manufacturer.name+"-"+group.machine_type+"-"+group.version
	end
end
