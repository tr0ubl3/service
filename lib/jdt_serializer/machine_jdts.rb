class MachineJdts < Jdts

	def columns
		%w[display_name machine_number delivery_date]
	end

	def data
		records.map do |record|
			[
				h(''),
				link_to(record.display_name, record),
				h(record.machine_number),
				h(date_format(record.delivery_date))
			]
		end
	end

	def get_custom_data
		return Machine.where(machine_group_id: params[:machine_group_id]).order("#{sort_column} #{sort_direction}")
	end
end