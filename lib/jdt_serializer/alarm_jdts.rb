class AlarmJdts < Jdts
	def columns
		%w[number description]
	end

	def data
		records.map do |record|
			[
				h(''),
				link_to(record.number, record),
				h(record.description)
			]
		end
	end

	def fetch_records
		records = get_custom_data
		records = records.page(page).per_page(per_page)
		if params[:sSearch].present?
			records = records.where("number like :search or description like :search", search: "%#{params[:sSearch]}%")
		end
		records
	end

	def get_custom_data
		return Alarm.where(machine_group_id: params[:machine_group_id]).order("#{sort_column} #{sort_direction}")
	end
end