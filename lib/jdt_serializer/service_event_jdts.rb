class ServiceEventJdts < Jdts

	def columns
		%w[event_name event_type machine_id created_at]
	end

	def data
		records.map do |record|
			[
				h(''),
				link_to(record.event_name, record),
				h(event_type(record)),
				h(record.machine.display_name),
				h(date_format(record.created_at, time: true))
			]
		end
	end

	def get_custom_data
		return ServiceEvent.order("#{sort_column} #{sort_direction}")
	end
end