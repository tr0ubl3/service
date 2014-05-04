class Jdts
	delegate :params, :h, :link_to, :number_to_currency, :date_format, to: :@view

	def initialize(view)
		@view = view
	end

	def as_json(options = {})
		{
			sEcho: params[:sEcho].to_i,
			iTotalRecords: MachineOwner.count,
			iTotalDisplayRecords: records.total_entries,
			aaData: data
		}
	end

	private

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

	def records
		@records ||= fetch_records
	end

	def fetch_records
		records = MachineOwner.order("#{sort_column} #{sort_direction}")
		records = records.page(page).per_page(per_page)
		if params[:sSearch].present?
			records = records.where("name like :search or address like :search", search: "%#{params[:sSearch]}%")
		end
		records
	end

	def page
		params[:iDisplayStart].to_i/per_page + 1
	end

	def per_page
		params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
	end

	def sort_column
		columns = %w[name address office_tel office_mail updated_at]
		columns[params[:iSortCol_0].to_i]
	end

	def sort_direction
		params[:sSortDir_0] == "desc" ? "desc" : "asc"
	end
end