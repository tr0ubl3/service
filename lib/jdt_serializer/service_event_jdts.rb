class ServiceEventJdts < Jdts

	def columns
		%w[event_name event_type machine_id created_at]
	end

	def data
		records.map do |record|
			[
				h(''),
				link_to(record.event_name, record),
				h(record.user.full_name),
				h(date_format(record.created_at, time: true)),
				h(record.current_state)
			]
		end
	end

	def get_custom_data
		return Machine.find(params[:machine_id]).service_events.order("#{sort_column} #{sort_direction}")
	end
end