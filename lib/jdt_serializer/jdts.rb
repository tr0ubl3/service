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
	def records
		@records ||= fetch_records
	end

	def fetch_records
		records = get_custom_data
		records = records.page(page).per_page(per_page)
		search_query = ""
		# columns.each_with_index do |col, index|
		# 	if index + 1 < columns.length
		# 		search_query << col + ' like :search or '
		# 	elsif index + 1 == columns.length
		# 		search_query << col + ' like :search'
		# 	end
		# end
		search_query << columns.shift + ' like :search'
		if params[:sSearch].present?
			records = records.where("#{search_query}", search: "%#{params[:sSearch]}%")
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
		columns[params[:iSortCol_0].to_i]
	end

	def sort_direction
		params[:sSortDir_0] == "desc" ? "desc" : "asc"
	end
end