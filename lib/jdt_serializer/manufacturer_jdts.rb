class ManufacturerJdts < Jdts

	def columns
		%w[name address office_tel office_mail updated_at]
	end

	def data
		records.map do |record|
			[
				h(''),
				link_to(record.name, record),
				h(record.address),
				h(record.office_tel),
				h(record.office_mail),
				h(date_format(record.updated_at, time: true))
			]
		end
	end

	def get_custom_data
		return Manufacturer.order("#{sort_column} #{sort_direction}")
	end
end